#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

use Future;
use Future::Mutex;

# done
{
   my $mutex = Future::Mutex->new;

   ok( $mutex->available, 'Mutex is available' );

   my $f;
   my $lf = $mutex->enter( sub { $f = Future->new } );

   ok( defined $lf, '->enter returns Future' );
   ok( defined $f, '->enter on new Mutex runs code' );

   ok( !$mutex->available, 'Mutex is unavailable' );

   ok( !$lf->is_ready, 'locked future not yet ready' );

   $f->done;
   ok( $lf->is_ready, 'locked future ready after $f->done' );
   ok( $mutex->available, 'Mutex is available again' );
}

# done chaining
{
   my $mutex = Future::Mutex->new;

   my $f1;
   my $lf1 = $mutex->enter( sub { $f1 = Future->new } );

   my $f2;
   my $lf2 = $mutex->enter( sub { $f2 = Future->new } );

   ok( !defined $f2, 'second enter not invoked while locked' );

   $f1->done;
   ok( defined $f2, 'second enter invoked after $f1->done' );

   $f2->done;
   ok( $lf2->is_ready, 'second locked future ready after $f2->done' );
   ok( $mutex->available, 'Mutex is available again' );
}

# fail chaining
{
   my $mutex = Future::Mutex->new;

   my $f1;
   my $lf1 = $mutex->enter( sub { $f1 = Future->new } );

   my $f2;
   my $lf2 = $mutex->enter( sub { $f2 = Future->new } );

   ok( !defined $f2, 'second enter not invoked while locked' );

   $f1->fail( "oops" );
   ok( defined $f2, 'second enter invoked after $f1->fail' );
   ok( $lf1->failure, 'first locked future fails after $f1->fail' );

   $f2->done;
   ok( $lf2->is_ready, 'second locked future ready after $f2->done' );
   ok( $mutex->available, 'Mutex is available again' );
}

# immediately done
{
   my $mutex = Future::Mutex->new;

   is( $mutex->enter( sub { Future->done( "result" ) } )->get,
       "result",
       '$mutex->enter returns immediate result' );

   ok( $mutex->available, 'Mutex is available again' );
}

# immediately fail
{
   my $mutex = Future::Mutex->new;

   is( $mutex->enter( sub { Future->fail( "oops" ) } )->failure,
       "oops",
       '$mutex->enter returns immediate failure' );

   ok( $mutex->available, 'Mutex is available again' );
}

# code dies
{
   my $mutex = Future::Mutex->new;

   is( $mutex->enter( sub { die "oopsie\n" } )->failure,
       "oopsie\n",
       '$mutex->enter returns immediate failure on exception' );

   ok( $mutex->available, 'Mutex is available again' );
}

# cancellation
{
   my $mutex = Future::Mutex->new;

   my $f = $mutex->enter( sub { Future->new } );
   $f->cancel;

   ok( $mutex->available, 'Mutex is available after cancel' );
}

# queueing
{
   my $mutex = Future::Mutex->new;

   my ( $f1, $f2, $f3 );
   my $f = Future->needs_all(
      $mutex->enter( sub { $f1 = Future->new } ),
      $mutex->enter( sub { $f2 = Future->new } ),
      $mutex->enter( sub { $f3 = Future->new } ),
   );

   ok( defined $f1, '$f1 defined' );
   $f1->done;

   ok( defined $f2, '$f2 defined' );
   $f2->done;

   ok( defined $f3, '$f3 defined' );
   $f3->done;

   ok( $f->is_done, 'Chain is done' );
   ok( $mutex->available, 'Mutex is available after chain done' );
}

# counting
{
   my $mutex = Future::Mutex->new( count => 2 );

   is( $mutex->available, 2, 'Mutex has 2 counts available' );

   my ( $f1, $f2, $f3 );
   my $f = Future->needs_all(
      $mutex->enter( sub { $f1 = Future->new } ),
      $mutex->enter( sub { $f2 = Future->new } ),
      $mutex->enter( sub { $f3 = Future->new } ),
   );

   ok( defined $f1 && defined $f2, '$f1 and $f2 defined with count 2' );

   $f1->done;
   ok( defined $f3, '$f3 defined after $f1 done' );

   $f2->done;
   $f3->done;

   ok( $f->is_done, 'Chain is done' );
   ok( $mutex->available, 'Mutex is available after chain done' );
}

done_testing;
