#!/usr/bin/perl

# The inverse of n factorial, based on the inverse of Stirling's approximation.

use 5.010;
use strict;
use warnings;

use lib qw(../lib);
use Math::AnyNum qw(:overload tau e factorial LambertW lgrt);

use constant S => tau->sqrt->log;
use constant T => tau->root(-2.0 * e);

sub inv_fac_W {
    my ($n) = @_;
    my $L = log($n) - S;
    $L / LambertW($L / e) - 0.5;
}

sub inv_fac_lgrt {
    my ($n) = @_;
    lgrt(T * $n**(1 / e)) * e - 0.5;
}

for my $n (1 .. 100) {

    my $f = factorial($n);
    my $i = inv_fac_W($f);
    my $j = inv_fac_lgrt($f);

    printf("F(%2s!) =~ %s\n", $n, $i);

    if ($i->round(-50) != $j->round(-50)) {
        die "$i != $j";
    }

    if ($i->round != $n) {
        die "However that is incorrect! (expected: $n -- got ", $i->round, ")";
    }
}
