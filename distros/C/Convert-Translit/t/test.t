#!perl

BEGIN {print "1..9\n";}
END {print "not ok 1\n" unless $loaded;}

use Convert::Translit;
$loaded = 1;
print "ok 1\n";

$from_charset = "Latin2";
$to_charset = "Ebcdic-US";

# Text is Polish: That quick red fox will be jumping over the sleeping lazy brown dog.

$aa = q/�w szybki czerwony lis b�dzie skaka� nad �pi�cego pr�niaczego br�zowego psa./;
@latin2_original = (
	0xD3,0x77,0x20,0x73,0x7A,0x79,0x62,0x6B,0x69,0x20,0x63,0x7A,0x65,0x72,0x77,0x6F,
	0x6E,0x79,0x20,0x6C,0x69,0x73,0x20,0x62,0xEA,0x64,0x7A,0x69,0x65,0x20,0x73,0x6B,
	0x61,0x6B,0x61,0xB3,0x20,0x6E,0x61,0x64,0x20,0xB6,0x70,0x69,0xB1,0x63,0x65,0x67,
	0x6F,0x20,0x70,0x72,0xF3,0xBF,0x6E,0x69,0x61,0x63,0x7A,0x65,0x67,0x6F,0x20,0x62,
	0x72,0xB1,0x7A,0x6F,0x77,0x65,0x67,0x6F,0x20,0x70,0x73,0x61,0x2E
);
$xx = pack ("C*", @latin2_original);
print "not " if ($aa ne $xx);
print "ok 2\n";

@ebcdic_us_result = (
	0xD6,0xA6,0x40,0xA2,0xA9,0xA8,0x82,0x92,0x89,0x40,0x83,0xA9,0x85,0x99,0xA6,0x96,
	0x95,0xA8,0x40,0x93,0x89,0xA2,0x40,0x82,0x85,0x84,0xA9,0x89,0x85,0x40,0xA2,0x92,
	0x81,0x92,0x81,0x93,0x40,0x95,0x81,0x84,0x40,0xA2,0x97,0x89,0x81,0x83,0x85,0x87,
	0x96,0x40,0x97,0x99,0x96,0xA9,0x95,0x89,0x81,0x83,0xA9,0x85,0x87,0x96,0x40,0x82,
	0x99,0x81,0xA9,0x96,0xA6,0x85,0x87,0x96,0x40,0x97,0xA2,0x81,0x4B
);
$bb = pack("C*", @ebcdic_us_result);
$lattoeb = new Convert::Translit( $from_charset, $to_charset);
print "not " if (!defined $lattoeb);
print "ok 3\n";
$yy = Convert::Translit::transliterate($xx);
print "not " if ($bb ne $yy);
print "ok 4\n";

$ee = "Ow szybki czerwony lis bedzie skakal nad spiacego prozniaczego brazowego psa.";
@latin2_again = (
	0x4F,0x77,0x20,0x73,0x7A,0x79,0x62,0x6B,0x69,0x20,0x63,0x7A,0x65,0x72,0x77,0x6F,
	0x6E,0x79,0x20,0x6C,0x69,0x73,0x20,0x62,0x65,0x64,0x7A,0x69,0x65,0x20,0x73,0x6B,
	0x61,0x6B,0x61,0x6C,0x20,0x6E,0x61,0x64,0x20,0x73,0x70,0x69,0x61,0x63,0x65,0x67,
	0x6F,0x20,0x70,0x72,0x6F,0x7A,0x6E,0x69,0x61,0x63,0x7A,0x65,0x67,0x6F,0x20,0x62,
	0x72,0x61,0x7A,0x6F,0x77,0x65,0x67,0x6F,0x20,0x70,0x73,0x61,0x2E
);
$cc = pack ("C*", @latin2_again);
print "not " if ($cc ne $ee);
print "ok 5\n";

$ebtolat = new Convert::Translit( $to_charset, $from_charset);
print "not " if (!defined $ebtolat);
print "ok 6\n";
$zz = Convert::Translit::transliterate($yy);
print "not " if ($zz ne $ee);
print "ok 7\n";

$yy = $lattoeb->transliterate($xx);
print "not " if ($bb ne $yy);
print "ok 8\n";

$zz = $ebtolat->transliterate($yy);
print "not " if ($zz ne $ee);
print "ok 9\n";
