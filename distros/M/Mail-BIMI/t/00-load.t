#!perl -T
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 3;

BEGIN {
    use_ok( 'Mail::BIMI' ) || print "Bail out! ";
    use_ok( 'Mail::BIMI::Record' ) || print "Bail out! ";
    use_ok( 'Mail::BIMI::Result' ) || print "Bail out! ";
}

diag( "Testing Mail::BIMI $Mail::BIMI::VERSION, Perl $], $^X" );

