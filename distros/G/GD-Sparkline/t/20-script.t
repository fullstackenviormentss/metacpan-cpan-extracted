use strict;
use warnings;
use Test::More tests => 2;
use IO::Scalar;

{
  local @ARGV = (q[s=1,2,3,4]);

  my $str = q[];
  my $io  = IO::Scalar->new(\$str);
  select $io;
  eval q[require "bin/sparkline"];

  like($str, qr/PNG/smix);
  like($str, qr/Content-type/smix);
}
