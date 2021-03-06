package DBIx::SpatialKey;

require DynaLoader;

@ISA = 'DynaLoader';
$VERSION = '0.031';

use Carp;

bootstrap DBIx::SpatialKey $VERSION;

sub new {
   my $self = shift;
   my $type = shift;
   if ($type eq "binary_morton") {
      new DBIx::SpatialKey::BinaryMorton @_;
   } else {
      croak "Unknown spatial key type '$type'";
   }
}

1;
__END__

=head1 NAME

DBIx::SpatialKeys - Perl module for the management of spatial keys.

=head1 SYNOPSIS

  use DBIx::SpatialKey;

  $key = new DBIx::SpatialKey 'binary_morton', 99, 99;

  $index = $key->index(45, 60);

  $upperleft  = $key->index(40, 50);
  $lowerright = $key->index(50, 70);

  # now $upperleft lt $index lt $lowerright

=head1 DESCRIPTION

Ever had the problem of managing multi-dimensional (spatial) data but your
database only had one-dimensional indices (b-tree etc.)? Queries like

 select data from table where latitude > 40 and latitude < 50
                          and longitude> 50 and longitude< 70;

are quite inefficient, unless longitude and latitude are part of the same
spatial index (e.g. a r-tree).

Spatial keys are a method to map multi-dimensional data into
single-dimensional indices that most databases support. This module only
support one very specialised mapping method which is very fast but only
efficient on integer data. (If you need other indexing methods, like
two-dimensional Hilbert indices just ask). It works like this:

First, generate a key object that is used to map data into the index. Every argument specifies a dimension,
and its value is the higest value allowed for that dimension (i.e. "num-1"). To index rgb556 data you would use the following key:

 $key = new DBIx::SpatialKey 'binary_morton', 31, 31, 63;

If you want to generate the key for the colour <10,11,40> you call the index function:
 
 $idx = $key->index(10,11,40);

The returned string will take just as much bits as is necessary to
represent one key value (in this example, 5+5+6 bits, i.e. two bytes), and
could in theory be used to recover the data again (but I haven't written
such function yet).

If you want to search for a colour that is similar to this one in the database you would use two keys, one
for the lower bound and one for the upper bound:

 $lo = $key->index( 9,10,39);
 $hi = $key->index(11,12,41);

 possible_keys = select ... where idx >= $lo and idx <= $hi;

This would return all similar colours (and some additional ones, so you
still have to test each one seperately!). If you had millions of colours
in your database this would be very efficient, as it saves on the number
of database operations (just a single range op) and can cut down the
number of disk accesses considerably.

In the future I plan to add other keys (like normal morton keys). If you
know how to generalize hilbert curves to the n-dimensional case please
contact me, as I'm too dumb to know.

Also, a range function that would return more than one range (to give more
precise searches) will be added in the future.

=head1 KEY TYPES

=head2 BINARY MORTON

=over 4

=item $obj = new 'binary_morton', max, max...

Create new key object of type 'binary_morton'. The trailing arguments give the maximum value for each dimension.

=item $key = $obj->index(dim1, dim2...)

Return a key (a binary string) containing the packed dimensions.

=item @dims = $obj->unpack($key)

Unpack the key into its components again.

=back

=head1 AUTHOR

Marc Lehmann <schmorp@schmorp.de>.

=head1 SEE ALSO

perl(1).

=cut
