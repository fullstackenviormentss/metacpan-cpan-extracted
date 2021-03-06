use strict;
use warnings;

use Test::More;

plan skip_all => "not HP-UX or missing /etc/TIMEZONE" if $^O ne 'hpux' || ! -f '/etc/TIMEZONE';

plan tests => 3;

local $ENV;
delete $ENV{TZ};

use DateTime::TimeZone;

my $tz1 = DateTime::TimeZone->new( name => 'local' );
isa_ok( $tz1, 'DateTime::TimeZone' );
diag($tz1->name);

my $tz2 = DateTime::TimeZone->new( name => $tz1->name );
isa_ok( $tz2, 'DateTime::TimeZone' );
is( $tz2->name, $tz1->name, "Can recreate object from name");
