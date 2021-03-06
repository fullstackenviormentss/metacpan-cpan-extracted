use v6-alpha;
use Test;
plan 53;

# L<S29/Num/"=item truncate">
# truncate and int() are synonynms. 
# Possibly more tests for truncate should be added here, too. 

=pod

Basic tests for the int() builtin

=cut

is(int(-1), -1, "int(-1) is -1");
is(int(0), 0, "int(0) is 0");
is(int(1), 1, "int(1) is 1");
is(int(3.14159265), 3, "int(3.14159265) is 3");
is(int(-3.14159265), -3, "int(-3.14159265) is -3");

is(int(0.999), 0, "int(0.999) is 0");
is(int(0.51), 0, "int(0.51) is 0");
is(int(0.5), 0, "int(0.5) is 0");
is(int(0.49), 0, "int(0.49) is 0");
is(int(0.1), 0, "int(0.1) is 0");

is(int(-0.999), -0, "int(-0.999) is -0");
is(int(-0.51), -0, "int(-0.51) is -0");
is(int(-0.5), -0, "int(-0.5) is -0");
is(int(-0.49), -0, "int(-0.49) is -0");
is(int(-0.1), -0, "int(-0.1) is -0");

is(int(1.999), 1, "int(1.999) is 1");
is(int(1.51), 1, "int(1.51) is 1");
is(int(1.5), 1, "int(1.5) is 1");
is(int(1.49), 1, "int(1.49) is 1");
is(int(1.1), 1, "int(1.1) is 1");

is(int(-1.999), -1, "int(-1.999) is -1");
is(int(-1.51), -1, "int(-1.51) is -1");
is(int(-1.5), -1, "int(-1.5) is -1");
is(int(-1.49), -1, "int(-1.49) is -1");
is(int(-1.1), -1, "int(-1.1) is -1");

sub __int( Str $s ) {
  if ($s ~~ rx:Perl5/^(-?\d+)$/) { return $0 };
  if ($s ~~ rx:Perl5/^(-?\d+)\./) { return $0 };
  if ($s ~~ rx:Perl5/^\./) { return 0 };
  return undef;
};

# Check the defaulting to $_ 

for(0, 0.0, 1, 50, 60.0, 99.99, 0.4, 0.6,
    -1, -50, -60.0, -99.99
    ) {
    my $int = __int($_);
    is(.int, $int, "integral value for $_ is $int");
    isa_ok(.int, "Int");
}

# Special values

is(int(1.9e3), 1900, "int 1.9e3 is 1900");
is(int(Inf),    Inf, "int Inf is Inf", :todo<bug>);
is(int(-Inf),  -Inf, "int -Inf is -Inf", :todo<bug>);
is(int(NaN),    NaN, "int NaN is NaN", :todo<bug>);

