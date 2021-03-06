use utf8;
use warnings;
use strict;
use Test::More;

use Document::OOXML;
use FindBin;
use Path::Tiny;

my $doc_dir = path($FindBin::Bin, '..', 't', 'resources');

# Removing spell-check markers
{
    my $doc = Document::OOXML->read_document(
        path($doc_dir, 'spelling-error.docx')->stringify
    );

    my $doc_part = $doc->document_part;

    {    
        my @nodes = $doc_part->xpc->findnodes('//w:proofErr', $doc_part->xml);
        is(scalar @nodes, 8, "8 spelling mistake markers (start/end) in document");
    }

    $doc->remove_spellcheck_markers();

    {    
        my @nodes = $doc_part->xpc->findnodes('//w:proofErr', $doc_part->xml);
        is(scalar @nodes, 0, "No spelling mistake markers in document");
    }
}

# Merge Runs
{
    my $xml = <<'EOX';
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://purl.oclc.org/ooxml/wordprocessingml/main" w:conformance="strict">
    <w:body>
        <w:p>
            <w:pPr>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
                <w:t xml:space="preserve">This file contains </w:t>
            </w:r>
            <w:r>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
                <w:t>two runs.</w:t>
            </w:r>
        </w:p>
    </w:body>
</w:document>
EOX

    my $part = Document::OOXML::Part::WordprocessingML->new_from_xml(
        '/word/document.xml',
        $xml,
        1,
    );

    {
        my @runs = $part->xpc->findnodes('//w:r', $part->xml);
        is(scalar @runs, 2, "Two runs in base document");
    }

    $part->merge_runs();

    {
        my @runs = $part->xpc->findnodes('//w:r', $part->xml);
        is(scalar @runs, 1, "Two runs merged properly");

        my @txt = $part->xpc->findnodes('//w:t', $part->xml);
        is(
            $txt[0]->textContent,
            'This file contains two runs.',
            'Merged text looks correct too',
        );
    }
}

# Find Text
{
    my $xml = <<'EOX';
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://purl.oclc.org/ooxml/wordprocessingml/main" w:conformance="strict">
    <w:body>
        <w:p>
            <w:pPr>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
                <w:t xml:space="preserve">This part contains several partial words we're part looking for.</w:t>
            </w:r>
        </w:p>
    </w:body>
</w:document>
EOX

    my $part = Document::OOXML::Part::WordprocessingML->new_from_xml(
        '/word/document.xml',
        $xml,
        1,
    );

    {
        my @txt = $part->xpc->findnodes('//w:t', $part->xml);
        is(
            $txt[0]->textContent,
            "This part contains several partial words we're part looking for.",
            'Text before replacement looks OK',
        );
    }

    $part->replace_text('part', 'word');

    {
        my @txt = $part->xpc->findnodes('//w:t', $part->xml);
        is(
            $txt[0]->textContent,
            "This word contains several wordial words we're word looking for.",
            '->replace_text replaced text',
        );
    }
}

# Extract text nodes
{
    my $xml = <<'EOX';
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://purl.oclc.org/ooxml/wordprocessingml/main" w:conformance="strict">
    <w:body>
        <w:p>
            <w:pPr>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
                <w:t xml:space="preserve">This part contains several partial words we're part looking for.</w:t>
            </w:r>
        </w:p>
    </w:body>
</w:document>
EOX

    my $part = Document::OOXML::Part::WordprocessingML->new_from_xml(
        '/word/document.xml',
        $xml,
        1,
    );

    my $found = $part->find_text_nodes(qr/part(?:ial)?/);
    is(scalar @$found, 3, "Found 3 matching words/parts");

    is_deeply(
        [map { $_->toString } @$found],
        [qw(part partial part)],
        'Correct words found',
    );

    for my $txt (@$found) {
        $txt->replaceDataString('part', 'word');
    }

    # For easy checking if it worked.
    $part->merge_runs();

    {
        my @txt = $part->xpc->findnodes('//w:t', $part->xml);
        is(
            $txt[0]->textContent,
            "This word contains several wordial words we're word looking for.",
            'Manually replaced text works',
        );
    }
}

# Style text nodes
{
    my $xml = <<'EOX';
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://purl.oclc.org/ooxml/wordprocessingml/main" w:conformance="strict">
    <w:body>
        <w:p>
            <w:pPr>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:t xml:space="preserve">This part contains several partial words we're part looking for.</w:t>
            </w:r>
        </w:p>
    </w:body>
</w:document>
EOX

    my $part = Document::OOXML::Part::WordprocessingML->new_from_xml(
        '/word/document.xml',
        $xml,
        1,
    );

    $part->style_text(qr/part(?:ial)?/, bold => 1);
    $part->style_text(qr/This/, italic => 1);
    $part->style_text(qr/looking/, color => 'ABCDEF');
    $part->style_text(
        qr/contains/,
        underline_style => 'dotDash',
        underline_color => 'ABCDEF',
    );
    $part->style_text(
        qr/several/,
        underline_style => 'wave'
    );

    my @txt = $part->xpc->findnodes('//w:t', $part->xml);
    is(@txt, 14, "Text nodes were split correctly for styling");

    my @runs = $part->xpc->findnodes('//w:r', $part->xml);
    {
        my ($b) = $part->xpc->findnodes('./w:rPr/w:b', $runs[2]);
        ok($b, "w:b element found in the run properties");

        ($b) = $part->xpc->findnodes('./w:rPr/w:b', $runs[8]);
        ok($b, "w:b element found in the run properties");

        ($b) = $part->xpc->findnodes('./w:rPr/w:b', $runs[10]);
        ok($b, "w:b element found in the run properties");
    }
    {
        my ($i) = $part->xpc->findnodes('./w:rPr/w:i', $runs[0]);
        ok($i, "w:i element found in the run properties");
    }
    {
        my ($col) = $part->xpc->findnodes('./w:rPr/w:color', $runs[12]);
        ok($col, "w:color element found in the run properties");

        my $color_value = $col->getAttributeNS($col->namespaceURI, 'val');
        is($color_value, 'ABCDEF', 'Correct w:val attribute found in w:color element');
    }
    {
        #        my ($u) = $part->xpc->findnodes('./w:rPr/w:u', $runs[4]);
        my ($u) = $part->xpc->findnodes('./w:rPr/w:u', $runs[4]);
        ok($u, "w:u element found in the run properties");
        is($u->getAttributeNS($u->namespaceURI => 'val'), 'dotDash', 'Second underline type is dotDash');
        is($u->getAttributeNS($u->namespaceURI => 'color'), 'ABCDEF', 'Second underline has color ABCDEF');

        ($u) = $part->xpc->findnodes('./w:rPr/w:u', $runs[6]);
        ok($u, "w:u element found in the run properties");
        is($u->getAttributeNS($u->namespaceURI => 'val'), 'wave', 'Second underline type is wave');
        is($u->getAttributeNS($u->namespaceURI => 'color'), undef, 'Second underline has no color');
    }
}

{
    my $xml = <<'EOX';
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://purl.oclc.org/ooxml/wordprocessingml/main" w:conformance="strict">
    <w:body>
        <w:p>
            <w:pPr>
                <w:rPr>
                    <w:lang w:val="en-US"/>
                </w:rPr>
            </w:pPr>
            <w:r>
                <w:rPr>
                    <w:color w:themeColor="text1"/>
                </w:rPr>
                <w:t>Already styled with a theme color.</w:t>
            </w:r>
        </w:p>
    </w:body>
</w:document>
EOX

    my $part = Document::OOXML::Part::WordprocessingML->new_from_xml(
        '/word/document.xml',
        $xml,
        1,
    );

    $part->style_text(
        qr/Already styled/,
        color => 'FF0000'
    );

    my @txt = $part->xpc->findnodes('//w:t', $part->xml);
    is(@txt, 2, "Text nodes were split correctly for styling");

    my @runs = $part->xpc->findnodes('//w:r', $part->xml);
    {
        my ($col) = $part->xpc->findnodes('./w:rPr/w:color', $runs[0]);
        ok($col, "w:color element found in the run properties");

        my $color_value = $col->getAttributeNS($col->namespaceURI, 'val');
        my $theme_value = $col->getAttributeNS($col->namespaceURI, 'themeColor');

        is($color_value, 'FF0000', 'New run has "val" attribute set correctly');
        is($theme_value, undef, 'New run has no "themeColor" attribute');

        ($col) = $part->xpc->findnodes('./w:rPr/w:color', $runs[1]);
        ok($col, "w:color element found in the run properties");

        $color_value = $col->getAttributeNS($col->namespaceURI, 'val');
        $theme_value = $col->getAttributeNS($col->namespaceURI, 'themeColor');

        is($color_value, undef, 'Original run has no "val" attribute for color');
        is($theme_value, 'text1', 'Original run has "themeColor" attribute set correctly');
    }
}

for my $type (qw(regular strict)) {
    my $filename = path($doc_dir, "multipart-${type}.docx")->stringify;
    my $doc = Document::OOXML->read_document($filename);

    my $part = $doc->document_part;

    $doc->merge_runs();

    my $words = $doc->extract_words;
    is_deeply(
        $words,
        [qw(
            A document with multiple referenced parts
            These words are in the footer
            This is text in the document header
            This is a footnote
        )],
        'Words found from all parts',
    );

    my $found = $doc->find_text_nodes(qr/header|footer|footnote|referenced/i);

    is_deeply(
        [map {$_->toString} @$found],
        [qw(
            referenced
            footer
            header
            footnote
        )],
        "Text found in all document parts"
    );

    for my $item (@$found) {
        $item->setData('lalalala');
    }

    my $tmp = Path::Tiny->tempfile;
    $doc->save_to_file($tmp->stringify);

    my $doc2 = Document::OOXML->read_document($tmp->stringify);
    my $found2 = $doc2->find_text_nodes('lalalala');
    is_deeply(
        [map {$_->toString} @$found2],
        ['lalalala', 'lalalala', 'lalalala', 'lalalala'],
        'New content saved/reloaded correctly.'
    );
}

done_testing();
