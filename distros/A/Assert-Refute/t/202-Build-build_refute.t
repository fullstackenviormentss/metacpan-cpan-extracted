#!perl

use strict;
use warnings;
use Test::More;

use Assert::Refute qw(:core);

# emulate use Foo;
BEGIN {
    package Foo;
    use base qw(Exporter);

    use Assert::Refute::Build;

    build_refute my_is => sub {
        my ($got, $exp) = @_;
        return $got eq $exp ? '' : to_scalar ($got) ." ne ".to_scalar ($exp);
    }, args => 2, export => 1;
};
BEGIN {
    Foo->import;
};

my $spec = contract {
    my_is shift, 137, "Fine";
};

my $report = $spec->apply( 137 );
ok $report->is_passing, "137 is fine";

   $report = $spec->apply( 42 );
ok !$report->is_passing, "Life is not fine";

note $report->as_tap;

done_testing;
