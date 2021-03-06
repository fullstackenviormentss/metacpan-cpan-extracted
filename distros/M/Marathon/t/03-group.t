#!perl -w

use strict;
use Test::More tests => 6;

use Marathon;
use Marathon::Group;
use Marathon::App;

my $first_app = Marathon::App->new({id => 'app_1'});
my $second_app = Marathon::App->new({id => 'app_2'});

my $first_group = Marathon::Group->new({id => 'group_1'});
my $second_group = Marathon::Group->new({id => 'group_2'});

ok( $first_group->add( $first_app ), 'Can add an app to a group' );
ok( $first_group->add( $second_group ), 'Can add a group to a group' );
ok( !$first_group->add( bless({ i => 'am', something => 'else' }) ), 'Cannot add something else to a group' );

ok( !$first_group->add( $first_group ), 'Cannot add a group to itself.' );
ok( $first_group->add( $second_app ), 'Can add another app to a group' );
ok( !$first_group->add( $first_app ), 'Can not add the same app twice.' );
