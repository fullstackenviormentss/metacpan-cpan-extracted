#!/usr/bin/perl

# [[[ PREPROCESSOR ]]]
# <<< EXECUTE_SUCCESS: 'before    loop, have current $i = 0' >>>
# <<< EXECUTE_SUCCESS: 'top    of loop, have current $i = 0' >>>
# <<< EXECUTE_SUCCESS: 'after     loop, have current $i = 1' >>>

# [[[ HEADER ]]]
use RPerl;
use strict;
use warnings;
our $VERSION = 0.001_000;

# [[[ CRITICS ]]]
## no critic qw(ProhibitUselessNoCritic ProhibitMagicNumbers RequireCheckedSyscalls)  # USER DEFAULT 1: allow numeric values & print operator
## no critic qw(RequireInterpolationOfMetachars)  # USER DEFAULT 2: allow single-quoted control characters & sigils

# [[[ OPERATIONS ]]]

my integer $i = 0;

print 'before    loop, have current $i = ', $i, "\n\n";

MY_LOOP:
while ( $i < 5 ) {
    print 'top    of loop, have current $i = ', $i, "\n";
    $i++;
    if ( $i > 10 ) {
        print 'inside of loop, have next    $i = ', $i, '; value too big, bailing out!', "\n";
        last MY_LOOP;
    }
    last MY_LOOP;
}

print "\n";
print 'after     loop, have current $i = ', $i, "\n";
