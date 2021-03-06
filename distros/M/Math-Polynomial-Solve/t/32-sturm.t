use 5.010001;
use Test::More tests => 17;

use Math::Polynomial::Solve qw(:sturm ascending_order);
use strict;
use warnings;

my @case = (
	[[1], 0],
	[[3, 5], 1],
	[[-1, 0, 0, 1], 1],
	[[1, 0, 0, 1], 1],
	[[1, 0, 0, 0, 1], 0],
	[[-1, 0, 0, 0, 1], 2],
	[[1, 0, 0, 0, 0, 1], 1],
	[[-1, 0, 0, 0, 0, 1], 1],
	[[1, 3, 3, 1], 1],
	[[-1, 0, 3, 1], 3],
	[[-1, 3, 0, 1], 1],
	[[-87, 59, -13, 1], 1],
	[[-16, 4, -4, 1], 1],
	[[-6, 11, -6, 1], 3],
	[[-336, -62, 5, 1], 3],
	[[6.25, 0, -24, 8], 3],
	[[-1/16, 7/8, -2.5, 1], 3],
);

ascending_order(1);

for my $cref (@case)
{
	my($p, $n) = @$cref;
	my @polynomial = @$p;

	my @chain = poly_sturm_chain(@polynomial);

	my $c = sturm_real_root_range_count(\@chain, -10000, 10000);

	ok($c == $n, "Polynomial: [" . join(", ", @polynomial) . "], count = $c");
}

exit(0);
