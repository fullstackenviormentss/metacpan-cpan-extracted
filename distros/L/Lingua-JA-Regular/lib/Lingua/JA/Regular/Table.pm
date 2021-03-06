package Lingua::JA::Regular::Table;

use strict;
use vars qw($VERSION);
$VERSION = '0.04';

use vars qw(@ISA @EXPORT);
require Exporter;
@ISA    = qw(Exporter);

use vars qw(
    $HANKAKU_ASCII
    $ZENKAKU_ASCII
    $KATAKANA
    $HIRAGANA
    $CHARACTER_STRICT_REGEX
    $CHARACTER_UNDEF_REGEX
);

@EXPORT = qw(
    $HANKAKU_ASCII
    $ZENKAKU_ASCII
    $KATAKANA
    $HIRAGANA
    $CHARACTER_STRICT_REGEX
    $CHARACTER_UNDEF_REGEX
);


$HANKAKU_ASCII = q{0-9A-Za-z,.:;?!^~_/\|`'"()[]{}+=<>$%#&*@};


$ZENKAKU_ASCII = qq{\xA3\xB0-\xA3\xB9\xA3\xC1-\xA3\xDA\xA3\xE1-\xA3\xFA\xA1\xA4\xA1\xA5\xA1\xA7\xA1\xA8\xA1\xA9\xA1\xAA\xA1\xB0\xA1\xB1\xA1\xB2\xA1\xBF\xA1\xEF\xA1\xC3\xA1\xAE\xA1\xC7\xA1\xC9\xA1\xCA\xA1\xCB\xA1\xCE\xA1\xCF\xA1\xD0\xA1\xD1\xA1\xDC\xA1\xE1\xA1\xE3\xA1\xE4\xA1\xF0\xA1\xF3\xA1\xF4\xA1\xF5\xA1\xF6\xA1\xF7};


$KATAKANA = qq{\xA5\xA2\xA5\xA4\xA5\xA6\xA5\xA8\xA5\xAA\xA5\xAB\xA5\xAD\xA5\xAF\xA5\xB1\xA5\xB3\xA5\xB5\xA5\xB7\xA5\xB9\xA5\xBB\xA5\xBD\xA5\xBF\xA5\xC1\xA5\xC4\xA5\xC6\xA5\xC8\xA5\xCA\xA5\xCB\xA5\xCC\xA5\xCD\xA5\xCE\xA5\xCF\xA5\xD2\xA5\xD5\xA5\xD8\xA5\xDB\xA5\xDE\xA5\xDF\xA5\xE0\xA5\xE1\xA5\xE2\xA5\xE4\xA5\xE6\xA5\xE8\xA5\xE9\xA5\xEA\xA5\xEB\xA5\xEC\xA5\xED\xA5\xEF\xA5\xF2\xA5\xF3\xA5\xAC\xA5\xAE\xA5\xB0\xA5\xB2\xA5\xB4\xA5\xB6\xA5\xB8\xA5\xBA\xA5\xBC\xA5\xBE\xA5\xC0\xA5\xC2\xA5\xC5\xA5\xC7\xA5\xC9\xA5\xD0\xA5\xD3\xA5\xD6\xA5\xD9\xA5\xDC\xA5\xD1\xA5\xD4\xA5\xD7\xA5\xDA\xA5\xDD\xA5\xA1\xA5\xA3\xA5\xA5\xA5\xA7\xA5\xA9\xA5\xE3\xA5\xE5\xA5\xE7\xA5\xC3};


$HIRAGANA = qq{\xA4\xA2\xA4\xA4\xA4\xA6\xA4\xA8\xA4\xAA\xA4\xAB\xA4\xAD\xA4\xAF\xA4\xB1\xA4\xB3\xA4\xB5\xA4\xB7\xA4\xB9\xA4\xBB\xA4\xBD\xA4\xBF\xA4\xC1\xA4\xC4\xA4\xC6\xA4\xC8\xA4\xCA\xA4\xCB\xA4\xCC\xA4\xCD\xA4\xCE\xA4\xCF\xA4\xD2\xA4\xD5\xA4\xD8\xA4\xDB\xA4\xDE\xA4\xDF\xA4\xE0\xA4\xE1\xA4\xE2\xA4\xE4\xA4\xE6\xA4\xE8\xA4\xE9\xA4\xEA\xA4\xEB\xA4\xEC\xA4\xED\xA4\xEF\xA4\xF2\xA4\xF3\xA4\xAC\xA4\xAE\xA4\xB0\xA4\xB2\xA4\xB4\xA4\xB6\xA4\xB8\xA4\xBA\xA4\xBC\xA4\xBE\xA4\xC0\xA4\xC2\xA4\xC5\xA4\xC7\xA4\xC9\xA4\xD0\xA4\xD3\xA4\xD6\xA4\xD9\xA4\xDC\xA4\xD1\xA4\xD4\xA4\xD7\xA4\xDA\xA4\xDD\xA4\xA1\xA4\xA3\xA4\xA5\xA4\xA7\xA4\xA9\xA4\xE3\xA4\xE5\xA4\xE7\xA4\xC3};


#
# EUC-JP文字(機種依存文字・未定義領域・3バイト文字を含まない)
#
$CHARACTER_STRICT_REGEX = qr{
    (?<!\x8F)
    (?: [\x00-\x7F]|                          # ASCII
        \x8E[\xA1-\xDF]|                       # 半角カタカナ
        [\xA1\xB0-\xCE\xD0-\xF3][\xA1-\xFE]|   # 1,16-46,48-83区
        \xA2[\xA1-\xAE\xBA-\xC1\xCA-\xD0\xDC-\xEA\xF2-\xF9\xFE]| # 2区
        \xA3[\xB0-\xB9\xC1-\xDA\xE1-\xFA]|     # 3区
        \xA4[\xA1-\xF3]|                       # 4区
        \xA5[\xA1-\xF6]|                       # 5区
        \xA6[\xA1-\xB8\xC1-\xD8]|              # 6区
        \xA7[\xA1-\xC1\xD1-\xF1]|              # 7区
        \xA8[\xA1-\xC0]|                       # 8区
        \xCF[\xA1-\xD3]|                       # 47区
        \xF4[\xA1-\xA6]                        # 84区
    )
    (?= (?:[\xA1-\xFE][\xA1-\xFE])* # JIS X 0208 が 0文字以上続いて
        (?:[\x00-\x7F\x8E\x8F]|\z)  # ASCII, SS2, SS3 または終端
    )
}x;


#
# EUC-JP未定義文字(機種依存文字・補助漢字)にマッチする正規表現
#
$CHARACTER_UNDEF_REGEX = qr{
    (?<!\x8F)
    (?: [\xA9-\xAF\xF5-\xFE][\xA1-\xFE]|                      # 9-15,85-94区
        \x8E[\xE0-\xFE]|                                      # 半角カタカナ
        \xA2[\xAF-\xB9\xC2-\xC9\xD1-\xDB\xEB-\xF1\xFA-\xFD]|  # 2区
        \xA3[\xA1-\xAF\xBA-\xC0\xDB-\xE0\xFB-\xFE]|           # 3区
        \xA4[\xF4-\xFE]|                                      # 4区
        \xA5[\xF7-\xFE]|                                      # 5区
        \xA6[\xB9-\xC0\xD9-\xFE]|                             # 6区
        \xA7[\xC2-\xD0\xF2-\xFE]|                             # 7区
        \xA8[\xC1-\xFE]|                                      # 8区
        \xCF[\xD4-\xFE]|                                      # 47区
        \xF4[\xA7-\xFE]|                                      # 84区
        \x8F[\xA1-\xFE][\xA1-\xFE]                            # 3バイト文字
    )
    (?= (?:[\xA1-\xFE][\xA1-\xFE])* # JIS X 0208 が 0文字以上続いて
        (?:[\x00-\x7F\x8E\x8F]|\z)  # ASCII, SS2, SS3 または終端
    )
}x;


1;
__END__

=head1 NAME

Lingua::JA::Regular::Table - Conversion Table for Lingua::JA::Regular

=head1 SYNOPSIS

B<DO NOT USE THIS MODULE DIRECTLY>

=head1 DESCRIPTION

This module defines conversion table used by Lingua::JA::Regular

=head1 AUTHOR

KIMURA, takefumi E<lt>takefumi@takefumi.comE<gt>

=head1 SEE ALSO

L<Lingua::JA::Regular>,
L<http://www.din.or.jp/~ohzaki/perl.htm#Character>,
L<http://www.din.or.jp/~ohzaki/perl.htm#JP_Match>,

=cut
