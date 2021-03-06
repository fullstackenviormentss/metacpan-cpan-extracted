use strict;
use warnings;
use FFI::Platypus::Declare;

lang 'Rust';
type 'opaque' => 'Point';
lib './libpoints.so';
attach make_point => [ 'i32', 'i32' ] => 'Point';
attach get_distance => ['Point', 'Point'] => 'f64';

print get_distance(make_point(2,2), make_point(4,4)), "\n";

