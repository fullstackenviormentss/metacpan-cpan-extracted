#!/usr/bin/perl

use strict;
use warnings;

use Test::More;

BEGIN {
  eval { require Catalyst::Plugin::Charsets::Japanese; Catalyst::Plugin::Charsets::Japanese->VERSION(0.06) }
    or plan skip_all => "Catalyst::Plugin::Charsets::Japanese 0.06 or higher is required for this test";
  eval { require Test::WWW::Mechanize::Catalyst }
    or plan skip_all => "Test::WWW::Mechanize::Catalyst is required for this test";
    plan tests => 4;
}

use lib 't/lib';
use Jcode;
use Test::WWW::Mechanize::Catalyst 'CharsetsTest::SjisToSjis';

my $ua = Test::WWW::Mechanize::Catalyst->new;

my $sjis = Jcode->new("日本語", 'utf8')->sjis;
$ua->get_ok("http://localhost/foo?bar=".$sjis);
$ua->content_is("bar is Shift_JIS");

$ua->get_ok("http://localhost/buz");
$ua->content_is(Jcode->new('日本語', 'utf8')->sjis);

