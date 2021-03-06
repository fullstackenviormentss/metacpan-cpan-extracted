#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Test::Device::Chip::Adapter;

use Device::Chip::nRF24L01P;

my $chip = Device::Chip::nRF24L01P->new;
my $adapter = Test::Device::Chip::Adapter->new;

$adapter->expect_write_gpios( { CE => 0 } );

$chip->mount( $adapter )->get;

# ->observe_tx_counts
{
   # OBSERVE_TX
   $adapter->expect_readwrite( "\x08\x00" )->returns( "\x0E\x12" );

   is_deeply( $chip->observe_tx_counts->get,
      {
         ARC_CNT  => 2,
         PLOS_CNT => 1,
      },
      '$chip->observe_tx_counts'
   );

   $adapter->check_and_clear( '$chip->observe_tx_counts' );
}

# ->rpd
{
   # RPD
   $adapter->expect_readwrite( "\x09\x00" )->returns( "\x0E\x01" );

   is( $chip->rpd->get, 1, '$chip->rpd' );

   $adapter->check_and_clear( '$chip->rpd' );
}

# ->fifo_status
{
   # FIFO_STATUS
   $adapter->expect_readwrite( "\x17\x00" )->returns( "\x0E\x11" );

   is_deeply( $chip->fifo_status->get,
      {
         RX_EMPTY => 1,
         RX_FULL  => !!0,

         TX_EMPTY => 1,
         TX_FULL  => !!0,
         TX_REUSE => !!0,
      },
      '$chip->fifo_status'
   );

   $adapter->check_and_clear( '$chip->fifo_status' );
}

done_testing;
