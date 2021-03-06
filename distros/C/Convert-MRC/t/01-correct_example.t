#test that the original example MRC converts correctly

use strict;
use warnings;
use FindBin qw($Bin);
use File::Spec::Functions;
use Test::More tests => 2;
use Test::LongString;
use Test::XML;
use Convert::MRC;
use autodie;
use Data::Section::Simple qw(get_data_section);

my $converter = Convert::MRC->new;

#print conversion info to these scalars
my ( $tbx, $log );
open my $tbx_handle, '>', \$tbx;
open my $log_handle, '>', \$log;

$converter->input_fh( catfile( $Bin, 'data', 'tradumatica_sample.txt' ) );
$converter->tbx_fh($tbx_handle);
$converter->log_fh($log_handle);
$converter->convert;
close $tbx_handle;
close $log_handle;

my $allData = get_data_section;

chomp $allData->{log};

#make sure version's correct
$allData->{log} =~ s/\[version\]/Convert::MRC->_version/e;

#remove datetime stamps before comparing
$log =~ s/\[MSG\] \[.+\] /\[MSG\] /gm;
is_string( $log, $allData->{log}, 'correct log output' );

#make sure version's correct
$allData->{tbx} =~ s/\[version\]/Convert::MRC->_version/e;

# print $allData->{tbx};
is_xml( $tbx, $allData->{tbx}, 'correct tbx output' );

__DATA__
@@ log
[MSG] MRC2TBX converter version [version]
[MSG] File includes links to:
	R007
	http://flickr.com/photos/lilgreen/432468210/
[MSG] File includes IDs:
	C003
	C003fr1
	C003en1
	C005
	C005en1
	C005en2
	C005fr1
	R007
@@ tbx
<?xml version='1.0' encoding="UTF-8"?>
<!DOCTYPE martif SYSTEM "TBXBasiccoreStructV02.dtd">
<martif type="TBX-Basic-V1" xml:lang="en">
	<martifHeader>
		<fileDesc>
			<titleStmt>
				<title>termbase from MRC file</title>
			</titleStmt>
			<sourceDesc>
				<p>generated by Convert::MRC version [version]</p>
			</sourceDesc>
			<sourceDesc>
				<p>a restaurant menu in English and French</p>
			</sourceDesc>
		</fileDesc>
		<encodingDesc>
			<p type="DCSName">TBXBasicXCSV02.xcs</p>
		</encodingDesc>
	</martifHeader>
	<text>
		<body>
			<termEntry id="C003">
				<descripGrp>
					<descrip type="subjectField">Restaurant Menus</descrip>
				</descripGrp>
				<langSet xml:lang="fr">
					<tig id="C003fr1">
						<term>poulet</term>
						<termNote type="partOfSpeech">noun</termNote>
						<termNote type="grammaticalGender">masculine</termNote>
					</tig>
				</langSet>
				<langSet xml:lang="en">
					<tig id="C003en1">
						<term>chicken</term>
						<termNote type="partOfSpeech">noun</termNote>
					</tig>
				</langSet>
			</termEntry>
			<termEntry id="C005">
				<descripGrp>
					<descrip type="subjectField">Restaurant Menus</descrip>
				</descripGrp>
				<transacGrp>
					<transac type="transactionType">origination</transac>
					<date>2007-01-31</date>
					<transacNote type="responsibility" target="R007">Jill</transacNote>
				</transacGrp>
				<xref type="xGraphic" target="http://flickr.com/photos/lilgreen/432468210/">garbanzo beans</xref>
				<langSet xml:lang="en">
					<descripGrp>
						<descrip type="definition">an edible legume of the family Fabaceae, subfamily Faboideae</descrip>
						<admin type="source">http://en.wikipedia.org/wiki/Chickpea</admin>
					</descripGrp>
					<tig id="C005en1">
						<term>chick peas</term>
						<termNote type="partOfSpeech">noun</termNote>
					</tig>
					<tig id="C005en2">
						<term>garbanzo beans</term>
						<termNote type="partOfSpeech">noun</termNote>
						<termNote type="geographicalUsage">southwest United States</termNote>
						<admin type="customerSubset">AlmostRipe Foods</admin>
					</tig>
				</langSet>
				<langSet xml:lang="fr">
					<tig id="C005fr1">
						<term>pois chiches</term>
						<termNote type="partOfSpeech">noun</termNote>
					</tig>
				</langSet>
			</termEntry>
		</body>
		<back>
			<refObjectList type="respPerson">
				<refObject id="R007">
					<item type="fn">Jill Johnson</item>
					<item type="email">jill@example.com</item>
					<item type="title">bean expert</item>
				</refObject>
			</refObjectList>
		</back>
	</text>
</martif>
