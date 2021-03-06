#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use MVC::Neaf;

MVC::Neaf->route( '/' => sub {
    return {
        -content => 1,
        -continue => sub {
            $_[0]->write(2);
            $_[0]->close;
        },
    };
} );

my @data = MVC::Neaf->run_test( '/' );

is ($data[2], 12, "all content made through");

done_testing;
