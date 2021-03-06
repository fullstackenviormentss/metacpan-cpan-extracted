package Prty::SoapWsdlServiceCgi::Demo;
use base qw/Prty::SoapWsdlServiceCgi/;

use strict;
use warnings;

our $VERSION = 1.124;

use POSIX ();

# -----------------------------------------------------------------------------

=encoding utf8

=head1 NAME

Prty::SoapWsdlServiceCgi::Demo - Demo für SOAP Web Service

=head1 BASE CLASS

L<Prty::SoapWsdlServiceCgi>

=head1 METHODS

=head2 Service-Methoden

=head3 serverTime() - Liefere lokale Server-Zeit als Zeichenkette

=head4 Synopsis

    $time = $class->serverTime;

=head4 Wsdl

    _RETURN $string

=begin WSDL

_RETURN $string

=end WSDL

=cut

# -----------------------------------------------------------------------------

sub serverTime {
    my $class = shift;
    return POSIX::strftime('%Y-%m-%d %H:%M:%S',localtime);
}
    

# -----------------------------------------------------------------------------

=head1 VERSION

1.124

=head1 AUTHOR

Frank Seitz, L<http://fseitz.de/>

=head1 COPYRIGHT

Copyright (C) 2018 Frank Seitz

=head1 LICENSE

This code is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

# -----------------------------------------------------------------------------

1;

# eof
