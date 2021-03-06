#!./perl

use List::Util::Superpositions qw(sum);

print "1..6\n";

print "not " if defined sum;
print "ok 1\n";

print "not " unless sum(9) == 9;
print "ok 2\n";

print "not " unless sum(1,2,3,4) == 10;
print "ok 3\n";

print "not " unless sum(-1) == -1;
print "ok 4\n";

my $x = -3;

print "not " unless sum($x,3) == 0;
print "ok 5\n";

print "not " unless sum(-3.5,3) == -0.5;
print "ok 6\n";

