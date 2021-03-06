#  You may distribute under the terms of either the GNU General Public License
#  or the Artistic License (the same terms as Perl itself)
#
#  (C) Paul Evans, 2016-2017 -- leonerd@leonerd.org.uk

package Device::Chip::HTU21D;

use strict;
use warnings;
use base qw( Device::Chip );

use Carp;

our $VERSION = '0.02';

use Data::Bitfield 0.02 qw( bitfield boolfield );
use Future::Utils qw( repeat );
use List::Util qw( first );

use constant PROTOCOL => "I2C";

=encoding UTF-8

=head1 NAME

C<Device::Chip::HTU21D> - chip driver for F<HTU21D>

=head1 SYNOPSIS

 use Device::Chip::HTU21D;

 my $chip = Device::Chip::HTU21D->new;
 $chip->mount( Device::Chip::Adapter::...->new )->get;

 printf "Current temperature is is %.2f C\n",
    $chip->read_temperature->get;

=head1 DESCRIPTION

This L<Device::Chip> subclass provides specific communication to a
F<TE Connectivity> F<HTU21D> attached to a computer via an I²C adapter.

The reader is presumed to be familiar with the general operation of this chip;
the documentation here will not attempt to explain or define chip-specific
concepts or features, only the use of this module to access them.

=cut

sub I2C_options
{
   my $self = shift;

   return (
      addr        => 0x40,
      max_bitrate => 400E3,
   );
}

=head1 ACCESSORS

The following methods documented with a trailing call to C<< ->get >> return
L<Future> instances.

=cut

use constant {
   # First-byte commands
   CMD_TRIGGER_TEMP_HOLD    => 0xE3,
   CMD_TRIGGER_HUMID_HOLD   => 0xE5,
   CMD_TRIGGER_TEMP_NOHOLD  => 0xF3,
   CMD_TRIGGER_HUMID_NOHOLD => 0xF5,
   CMD_WRITE_REG            => 0xE6,
   CMD_READ_REG             => 0xE7,
   CMD_SOFT_RESET           => 0xFE,
};

bitfield { format => "bytes-BE" }, REG_USER =>
   RES0       => boolfield( 0 ),
   OTPDISABLE => boolfield( 1 ),
   HEATER     => boolfield( 2 ),
   ENDOFBATT  => boolfield( 6 ),
   RES1       => boolfield( 7 );

=head2 read_config

   $config = $chip->read_config->get

Returns a C<HASH> reference of the contents of the user register.

   RES        => "12/14" | "11/11" | "10/13" | "8/12"
   OTPDISABLE => 0 | 1
   HEATER     => 0 | 1
   ENDOFBATT  => 0 | 1

=head2 change_config

   $chip->change_config( %changes )->get

Writes updates to the user register.

=cut

my @RES_VALUES = ( "12/14", "8/12", "10/13", "11/11" );

sub read_config
{
   my $self = shift;

   $self->protocol->write_then_read( pack( "C", CMD_READ_REG ), 1 )->then( sub {
      my %config = unpack_REG_USER( $_[0] );
      my $res = ( delete $config{RES0} ) | ( delete $config{RES1} ) << 1;
      $config{RES} = $RES_VALUES[$res];

      Future->done( \%config );
   });
}

sub change_config
{
   my $self = shift;
   my %changes = @_;

   $self->read_config->then( sub {
      my ( $config ) = @_;
      $config->{$_} = $changes{$_} for keys %changes;

      my $res = delete $config->{RES};

      $res = first { $RES_VALUES[$_] eq $res } 0 .. 3;
      defined $res or
         croak "Unrecognised new value for RES - '$changes{RES}'";

      my $val = pack_REG_USER(
         RES0 => $res & ( 1<<0 ),
         RES1 => $res & ( 1<<1 ),
         %$config,
      );

      $self->protocol->write( pack "C a", CMD_WRITE_REG, $val );
   });
}

sub _trigger_nohold
{
   my $self = shift;
   my ( $cmd ) = @_;

   my $protocol = $self->protocol;

   $self->protocol->write( pack "C", $cmd )->then( sub {
      my $attempts = 10;
      repeat {
         $protocol->read( 2 )
            ->else( sub {
               --$attempts ? ( $protocol->sleep( 0.01 )->then_done() )
                           : Future->fail( $_[0] );
            });
      } while => sub { !$_[0]->failure and !defined $_[0]->get }
   })->then( sub {
      my ( $bytes ) = @_;
      return Future->done( unpack "S>", $bytes );
   });
}

=head1 METHODS

=cut

=head2 read_temperature

   $temperature = $chip->read_temperature->get

Triggers a reading of the temperature sensor, returning a number in degrees C.

=cut

sub read_temperature
{
   my $self = shift;

   $self->_trigger_nohold( CMD_TRIGGER_TEMP_NOHOLD )->then( sub {
      my ( $val ) = @_;
      Future->done( -46.85 + 175.72 * ( $val / 2**16 ) );
   });
}

=head2 read_humidity

   $humidity = $chip->read_humidity->get

Triggers a reading of the humidity sensor, returning a number in % RH.

=cut

sub read_humidity
{
   my $self = shift;

   $self->_trigger_nohold( CMD_TRIGGER_HUMID_NOHOLD )->then( sub {
      my ( $val ) = @_;
      Future->done( -6 + 125 * ( $val / 2**16 ) );
   });
}

=head1 AUTHOR

Paul Evans <leonerd@leonerd.org.uk>

=cut

0x55AA;
