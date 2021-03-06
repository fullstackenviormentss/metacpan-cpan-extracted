package Net::ACME::X::Empty;

use strict;
use warnings;

use parent qw( Net::ACME::X::HashBase );

sub new {
    my ( $class, $args_hr ) = @_;

    my $str;

    if ( defined $args_hr->{'name'} && length $args_hr->{'name'} ) {
        $str = "“$args_hr->{'name'}” cannot be empty!";
    }
    else {
        $str = 'This value cannot be empty!';
    }

    return $class->SUPER::new($str, $args_hr);
}

1;
