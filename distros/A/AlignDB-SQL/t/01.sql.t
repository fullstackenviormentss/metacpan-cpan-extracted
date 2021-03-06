#!/usr/bin/perl
use strict;
use warnings;

use Test::More tests => 59;

BEGIN {
    use_ok('AlignDB::SQL');
}

sub ns {
    AlignDB::SQL->new;
}

sub strip {
    $_[0] =~ s/\s+/ /g;
    $_[0] =~ s/ $//s;
    return $_[0];
}

my $stmt = ns();
ok $stmt, 'Created SQL object';

## Testing FROM
$stmt->from( ['foo'] );
is strip( $stmt->as_sql ), "FROM foo";

$stmt->from( [ 'foo', 'bar' ] );
is strip( $stmt->as_sql ), "FROM foo, bar";

## Testing JOINs
$stmt->from(  [] );
$stmt->joins( [] );
$stmt->add_join(
    foo => {
        type      => 'inner',
        table     => 'baz',
        condition => 'foo.baz_id = baz.baz_id'
    }
);
is( strip( $stmt->as_sql ),
    "FROM foo INNER JOIN baz ON foo.baz_id = baz.baz_id" );

$stmt->from( ['bar'] );
is strip( $stmt->as_sql ),
    "FROM foo INNER JOIN baz ON foo.baz_id = baz.baz_id, bar";

$stmt->from(  [] );
$stmt->joins( [] );
$stmt->add_join(
    foo => [
        {   type      => 'inner',
            table     => 'baz b1',
            condition => 'foo.baz_id = b1.baz_id AND b1.quux_id = 1'
        },
        {   type      => 'left',
            table     => 'baz b2',
            condition => 'foo.baz_id = b2.baz_id AND b2.quux_id = 2'
        },
    ]
);
is strip( $stmt->as_sql ),
    "FROM foo INNER JOIN baz b1 ON foo.baz_id = b1.baz_id AND b1.quux_id = 1 LEFT JOIN baz b2 ON foo.baz_id = b2.baz_id AND b2.quux_id = 2";

# test case for bug found where add_join is called twice
$stmt->joins( [] );
$stmt->add_join(
    foo => [
        {   type      => 'inner',
            table     => 'baz b1',
            condition => 'foo.baz_id = b1.baz_id AND b1.quux_id = 1'
        },
    ]
);
$stmt->add_join(
    foo => [
        {   type      => 'left',
            table     => 'baz b2',
            condition => 'foo.baz_id = b2.baz_id AND b2.quux_id = 2'
        },
    ]
);
is strip( $stmt->as_sql ),
    "FROM foo INNER JOIN baz b1 ON foo.baz_id = b1.baz_id AND b1.quux_id = 1 LEFT JOIN baz b2 ON foo.baz_id = b2.baz_id AND b2.quux_id = 2";

# test case adding another table onto the whole mess
$stmt->add_join(
    quux => [
        {   type      => 'inner',
            table     => 'foo f1',
            condition => 'f1.quux_id = quux.q_id'
        }
    ]
);

is strip( $stmt->as_sql ),
    "FROM foo INNER JOIN baz b1 ON foo.baz_id = b1.baz_id AND b1.quux_id = 1 LEFT JOIN baz b2 ON foo.baz_id = b2.baz_id AND b2.quux_id = 2 INNER JOIN foo f1 ON f1.quux_id = quux.q_id";

## Testing GROUP BY
$stmt = ns();
$stmt->from( ['foo'] );
$stmt->group( { column => 'baz' } );
is strip( $stmt->as_sql ), "FROM foo GROUP BY baz", 'single bare group by';

$stmt = ns();
$stmt->from( ['foo'] );
$stmt->group( { column => 'baz', desc => 'DESC' } );
is strip( $stmt->as_sql ),
    "FROM foo GROUP BY baz DESC",
    'single group by with desc';

$stmt = ns();
$stmt->from( ['foo'] );
$stmt->group( [ { column => 'baz' }, { column => 'quux' }, ] );
is strip( $stmt->as_sql ), "FROM foo GROUP BY baz, quux", 'multiple group by';

$stmt = ns();
$stmt->from( ['foo'] );
$stmt->group(
    [   { column => 'baz',  desc => 'DESC' },
        { column => 'quux', desc => 'DESC' },
    ]
);
is strip( $stmt->as_sql ),
    "FROM foo GROUP BY baz DESC, quux DESC",
    'multiple group by with desc';

## Testing ORDER BY
$stmt = ns();
$stmt->from( ['foo'] );
$stmt->order( { column => 'baz', desc => 'DESC' } );
is strip( $stmt->as_sql ), "FROM foo ORDER BY baz DESC", 'single order by';

$stmt = ns();
$stmt->from( ['foo'] );
$stmt->order(
    [   { column => 'baz',  desc => 'DESC' },
        { column => 'quux', desc => 'ASC' },
    ]
);
is strip( $stmt->as_sql ),
    "FROM foo ORDER BY baz DESC, quux ASC",
    'multiple order by';

## Testing GROUP BY plus ORDER BY
$stmt = ns();
$stmt->from( ['foo'] );
$stmt->group( { column => 'quux' } );
$stmt->order( { column => 'baz', desc => 'DESC' } );
is strip( $stmt->as_sql ),
    "FROM foo GROUP BY quux ORDER BY baz DESC",
    'group by with order by';

## Testing LIMIT and OFFSET
$stmt = ns();
$stmt->from( ['foo'] );
$stmt->limit(5);
is strip( $stmt->as_sql ), "FROM foo LIMIT 5";
$stmt->offset(10);
is strip( $stmt->as_sql ), "FROM foo LIMIT 5 OFFSET 10";

{    ## Non-numerics should cause an error
    my $sql = eval { $stmt->limit("  15g"); strip( $stmt->as_sql ) };
    like $@, qr/Int/, "bogus limit causes as_sql assertion";
}

## Testing WHERE
$stmt = ns();
$stmt->add_where( foo => 'bar' );
is( strip( $stmt->as_sql_where ), "WHERE (foo = ?)" );
is( scalar @{ $stmt->bind },      1 );
is( $stmt->bind->[0],             'bar' );

$stmt = ns();
$stmt->add_where( foo => [ 'bar', 'baz' ] );
is( strip( $stmt->as_sql_where ), "WHERE (foo IN (?,?))" );
is( scalar @{ $stmt->bind },      2 );
is( $stmt->bind->[0],             'bar' );
is( $stmt->bind->[1],             'baz' );

$stmt = ns();
$stmt->add_where( foo => { op => '!=', value => 'bar' } );
is( strip( $stmt->as_sql_where ), "WHERE (foo != ?)" );
is( scalar @{ $stmt->bind },      1 );
is( $stmt->bind->[0],             'bar' );

$stmt = ns();
$stmt->add_where( foo => { column => 'bar', op => '!=', value => 'bar' } );
is( strip( $stmt->as_sql_where ), "WHERE (bar != ?)" );
is( scalar @{ $stmt->bind },      1 );
is( $stmt->bind->[0],             'bar' );

$stmt = ns();
$stmt->add_where( foo => \'IS NOT NULL' );
is( strip( $stmt->as_sql_where ), "WHERE (foo IS NOT NULL)" );
is( scalar @{ $stmt->bind },      0 );

$stmt = ns();
$stmt->add_where( foo => 'bar' );
$stmt->add_where( baz => 'quux' );
is( strip( $stmt->as_sql_where ), "WHERE (foo = ?) AND (baz = ?)" );
is( scalar @{ $stmt->bind },      2 );
is( $stmt->bind->[0],             'bar' );
is( $stmt->bind->[1],             'quux' );

$stmt = ns();
$stmt->add_where(
    foo => [ { op => '>', value => 'bar' }, { op => '<', value => 'baz' } ] );
is( strip( $stmt->as_sql_where ), "WHERE ((foo > ?) OR (foo < ?))" );
is( scalar @{ $stmt->bind },      2 );
is( $stmt->bind->[0],             'bar' );
is( $stmt->bind->[1],             'baz' );

$stmt = ns();
$stmt->add_where(
    foo => [
        -and => { op => '>', value => 'bar' },
        { op => '<', value => 'baz' }
    ]
);
is( strip( $stmt->as_sql_where ), "WHERE ((foo > ?) AND (foo < ?))" );
is( scalar @{ $stmt->bind },      2 );
is( $stmt->bind->[0],             'bar' );
is( $stmt->bind->[1],             'baz' );

$stmt = ns();
$stmt->add_where( foo => [ -and => 'foo', 'bar', 'baz' ] );
is( strip( $stmt->as_sql_where ),
    "WHERE ((foo = ?) AND (foo = ?) AND (foo = ?))" );
is( scalar @{ $stmt->bind }, 3 );
is( $stmt->bind->[0],        'foo' );
is( $stmt->bind->[1],        'bar' );
is( $stmt->bind->[2],        'baz' );

## regression bug. modified parameters
my %terms = ( foo => [ -and => 'foo', 'bar', 'baz' ] );
$stmt = ns();
$stmt->add_where(%terms);
is( strip( $stmt->as_sql_where ),
    "WHERE ((foo = ?) AND (foo = ?) AND (foo = ?))" );
$stmt->add_where(%terms);
is( strip( $stmt->as_sql_where ),
    "WHERE ((foo = ?) AND (foo = ?) AND (foo = ?)) AND ((foo = ?) AND (foo = ?) AND (foo = ?))"
);

$stmt = ns();
$stmt->add_select( foo => 'foo' );
$stmt->add_select('bar');
$stmt->from( [qw( baz )] );
is( strip( $stmt->as_sql ), "SELECT foo, bar FROM baz" );

$stmt = ns();
$stmt->add_select( 'f.foo'    => 'foo' );
$stmt->add_select( 'COUNT(*)' => 'count' );
$stmt->from( [qw( baz )] );
is( strip( $stmt->as_sql ), "SELECT f.foo, COUNT(*) count FROM baz" );
my $map = $stmt->select_map;
is( scalar( keys %$map ), 2 );
is( $map->{'f.foo'},      'foo' );
is( $map->{'COUNT(*)'},   'count' );

# HAVING
$stmt = ns();
$stmt->add_select( foo        => 'foo' );
$stmt->add_select( 'COUNT(*)' => 'count' );
$stmt->from( [qw(baz)] );
$stmt->add_where( foo => 1 );
$stmt->group( { column => 'baz' } );
$stmt->order( { column => 'foo', desc => 'DESC' } );
$stmt->limit(2);
$stmt->add_having( count => 2 );

is( strip( $stmt->as_sql ),
    "SELECT foo, COUNT(*) count FROM baz WHERE (foo = ?) GROUP BY baz HAVING (COUNT(*) = ?) ORDER BY foo DESC LIMIT 2"
);

