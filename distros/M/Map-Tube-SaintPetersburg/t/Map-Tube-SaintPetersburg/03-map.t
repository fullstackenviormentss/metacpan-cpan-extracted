# Pragmas.
use strict;
use warnings;

# Modules.
use Map::Tube::SaintPetersburg;
use Test::Map::Tube 'tests' => 2;
use Test::NoWarnings;

# Test.
ok_map(Map::Tube::SaintPetersburg->new, 'Test validity of map.');
