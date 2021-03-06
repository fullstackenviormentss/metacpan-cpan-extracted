use strict;
use warnings;

use Test::Bits;
use Test::More;

use Data::IEEE754 qw(
    pack_double_be
    pack_float_be
    unpack_double_be
    unpack_float_be
);

{
    my @floats = (
        [ 0.0      => [ 0x00, 0x00, 0x00, 0x00 ] ],
        [ 1.0      => [ 0x3f, 0x80, 0x00, 0x00 ] ],
        [ 1.1      => [ 0x3f, 0x8c, 0xcc, 0xcd ] ],
        [ 3.14     => [ 0x40, 0x48, 0xf5, 0xc3, ] ],
        [ 9999.99  => [ 0x46, 0x1c, 0x3f, 0xf6 ] ],
        [ -1.0     => [ 0xbf, 0x80, 0x00, 0x00 ] ],
        [ -1.1     => [ 0xbf, 0x8c, 0xcc, 0xcd ] ],
        [ -3.14    => [ 0xc0, 0x48, 0xf5, 0xc3, ] ],
        [ -9999.99 => [ 0xc6, 0x1c, 0x3f, 0xf6 ] ],
    );

    for my $pair (@floats) {
        my ( $input, $expect ) = @{$pair};

        bits_is(
            pack_float_be($input), $expect,
            "$input packed as big-endian float"
        );

        cmp_ok(
            abs( unpack_float_be( pack( 'C*', @{$expect} ) ) - $input ),
            '<',
            0.001,
            "unpacked big-endian float is (close enough to) $input"
        );
    }
}

{
    my @doubles = (
        [ 0.0       => [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ] ],
        [ 1.0       => [ 0x3f, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ] ],
        [ 1.1111111 => [ 0x3f, 0xf1, 0xc7, 0x1c, 0x6e, 0xcb, 0x8f, 0xb6 ] ],
        [ 3.14      => [ 0x40, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f ] ],
        [
            3.14159265359 =>
                [ 0x40, 0x09, 0x21, 0xfb, 0x54, 0x44, 0x2e, 0xea ]
        ],
        [ 9999.99 => [ 0x40, 0xc3, 0x87, 0xfe, 0xb8, 0x51, 0xeb, 0x85 ] ],
        [
            ( ( 2**31 ) + 0.01 ) =>
                [ 0x41, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x51, 0xec ]
        ],
        [ 0.0        => [ 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ] ],
        [ -1.0       => [ 0xbf, 0xf0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 ] ],
        [ -1.1111111 => [ 0xbf, 0xf1, 0xc7, 0x1c, 0x6e, 0xcb, 0x8f, 0xb6 ] ],
        [ -3.14      => [ 0xc0, 0x09, 0x1e, 0xb8, 0x51, 0xeb, 0x85, 0x1f ] ],
        [
            -3.14159265359 =>
                [ 0xc0, 0x09, 0x21, 0xfb, 0x54, 0x44, 0x2e, 0xea ]
        ],
        [ -9999.99 => [ 0xc0, 0xc3, 0x87, 0xfe, 0xb8, 0x51, 0xeb, 0x85 ] ],
        [
            -( ( 2**31 ) + 0.01 ) =>
                [ 0xc1, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x51, 0xec ]
        ],
    );

    for my $pair (@doubles) {
        my ( $input, $expect ) = @{$pair};

        bits_is(
            pack_double_be($input), $expect,
            "$input packed as big-endian double"
        );

        cmp_ok(
            abs( unpack_double_be( pack( 'C*', @{$expect} ) ) - $input ),
            '<',
            0.001,
            "unpacked big-endian double is (close enough to) $input"
        );
    }
}

done_testing();
