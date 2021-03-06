#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use MVC::Neaf;

my @call;
MVC::Neaf->route( "/first/path", sub {
    my $req = shift;
    push @call, [ $req->script_name, "/first/path" ];
    return {};
}, path_info_regex => '.*');

MVC::Neaf->alias( "/second/path", "/first/path" );

# note explain (MVC::Neaf->get_routes);

my $app = MVC::Neaf->run;

is ($app->({ REQUEST_URI => '/first/path/and/more' })->[0], 200, "Path found");
is ($app->({ REQUEST_URI => '/second/path/and/more' })->[0], 200, "Path found (2)");

is_deeply( \@call, [[ "/first/path", "/first/path" ]
        , ["/second/path", "/first/path" ]], "Alias works as expected" );

done_testing;
