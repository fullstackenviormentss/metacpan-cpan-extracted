# encoding: Latin3
# This file is encoded in Latin-3.
die "This file is not encoded in Latin-3.\n" if q{あ} ne "\x82\xa0";

use Latin3;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('あいう' =~ /^(あいう)$/) {
    if ("$1" eq "あいう") {
        print "ok - 1 $^X $__FILE__ ('あいう' =~ /^あいう\$/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('あいう' =~ /^あいう\$/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('あいう' =~ /^あいう\$/).\n";
}

__END__
