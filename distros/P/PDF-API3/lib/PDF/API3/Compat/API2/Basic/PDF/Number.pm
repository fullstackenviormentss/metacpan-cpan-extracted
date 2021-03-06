#=======================================================================
#    ____  ____  _____              _    ____ ___   ____
#   |  _ \|  _ \|  ___|  _   _     / \  |  _ \_ _| |___ \
#   | |_) | | | | |_    (_) (_)   / _ \ | |_) | |    __) |
#   |  __/| |_| |  _|    _   _   / ___ \|  __/| |   / __/
#   |_|   |____/|_|     (_) (_) /_/   \_\_|  |___| |_____|
#
#   A Perl Module Chain to faciliate the Creation and Modification
#   of High-Quality "Portable Document Format (PDF)" Files.
#
#=======================================================================
#
#   THIS IS A REUSED PERL MODULE, FOR PROPER LICENCING TERMS SEE BELOW:
#
#
#   Copyright Martin Hosken <Martin_Hosken@sil.org>
#
#   No warranty or expression of effectiveness, least of all regarding
#   anyone's safety, is implied in this software or documentation.
#
#   This specific module is licensed under the Perl Artistic License.
#
#
#   $Id: Number.pm,v 2.0 2005/11/16 02:16:00 areibens Exp $
#
#=======================================================================
package PDF::API3::Compat::API2::Basic::PDF::Number;

=head1 NAME

PDF::API3::Compat::API2::Basic::PDF::Number - Numbers in PDF. Inherits from L<PDF::API3::Compat::API2::Basic::PDF::String>

=head1 METHODS

=cut

use strict;
use vars qw(@ISA);
no warnings qw[ deprecated recursion uninitialized ];

use PDF::API3::Compat::API2::Basic::PDF::String;
@ISA = qw(PDF::API3::Compat::API2::Basic::PDF::String);


=head2 $n->convert($str)

Converts a string from PDF to internal, by doing nothing

=cut

sub convert
{ return $_[1]; }


=head2 $n->as_pdf

Converts a number to PDF format

=cut

sub as_pdf
{ $_[0]->{'val'}; }

sub outxmldeep
{
    my ($self, $fh, $pdf, %opts) = @_;

    $opts{-xmlfh}->print("<Number>".$self->val."</Number>\n");
}

