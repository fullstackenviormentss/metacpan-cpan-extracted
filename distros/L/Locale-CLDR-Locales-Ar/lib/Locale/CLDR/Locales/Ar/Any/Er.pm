=head1

Locale::CLDR::Locales::Ar::Any::Er - Package for language Arabic

=cut

package Locale::CLDR::Locales::Ar::Any::Er;
# This file auto generated from Data\common\main\ar_ER.xml
#	on Fri 13 Apr  7:01:21 am GMT

use strict;
use warnings;
use version;

our $VERSION = version->declare('v0.32.0');

use v5.10.1;
use mro 'c3';
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';
use Types::Standard qw( Str Int HashRef ArrayRef CodeRef RegexpRef );
use Moo;

extends('Locale::CLDR::Locales::Ar::Any');
has 'currencies' => (
	is			=> 'ro',
	isa			=> HashRef,
	init_arg	=> undef,
	default		=> sub { {
		'ERN' => {
			symbol => 'Nfk',
		},
	} },
);


no Moo;

1;

# vim: tabstop=4
