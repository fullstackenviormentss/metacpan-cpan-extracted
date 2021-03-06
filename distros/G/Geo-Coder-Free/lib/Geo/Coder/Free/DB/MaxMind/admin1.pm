package Geo::Coder::Free::DB::MaxMind::admin1;

use strict;
use warnings;

# admin1.db is from http://download.geonames.org/export/dump/admin1CodesASCII.txt

use Geo::Coder::Free::DB;

our @ISA = ('Geo::Coder::Free::DB');

sub _open {
	my $self = shift;

	return $self->SUPER::_open(sep_char => "\t", column_names => ['concatenated_codes', 'name', 'asciiname', 'geonameId']);
}

1;
