# encoding: Latin10
# This file is encoded in Latin-10.
die "This file is not encoded in Latin-10.\n" if q{あ} ne "\x82\xa0";

use Latin10;
print "1..1\n";

my $__FILE__ = __FILE__;

if ('あいいう' =~ /(あい*いう)/) {
    if ("$1" eq "あいいう") {
        print "ok - 1 $^X $__FILE__ ('あいいう' =~ /あい*いう/).\n";
    }
    else {
        print "not ok - 1 $^X $__FILE__ ('あいいう' =~ /あい*いう/).\n";
    }
}
else {
    print "not ok - 1 $^X $__FILE__ ('あいいう' =~ /あい*いう/).\n";
}

__END__
