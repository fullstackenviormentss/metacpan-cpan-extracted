#!/usr/bin/env perl

use Test::Most tests => 1;

use lib 't/lib';
use CurieTestHelper;

use Renard::Incunabula::Common::Setup;
use Glib 'TRUE', 'FALSE';
use Renard::Curie::App;

use Log::Any qw($log);

subtest "Check log buffer" => sub {
	plan tests => 3;
	my $c = CurieTestHelper->get_app_container;
	my $app = $c->app;

	my $sentinel_value = "My logging test";

	my $buffer = $c->log_window->builder
		->get_object('log-text')
		->get_buffer;

	sub retrieve_text_from_buffer {
		my ($buffer) = @_;
		$buffer->get_text(
			$buffer->get_start_iter,
			$buffer->get_end_iter,
			FALSE );
	}

	unlike( retrieve_text_from_buffer($buffer),
		qr/$sentinel_value/,
		'log does not contain target message' );

	# log a message
	$log->info( $sentinel_value );

	like( retrieve_text_from_buffer($buffer),
		qr/$sentinel_value/,
		'now contains the target logged text' );

	$c->log_window->builder
		->get_object('button-clear')
		->signal_emit('clicked');

	is( retrieve_text_from_buffer($buffer), '', 'text is empty after clearing' );
};

done_testing;
