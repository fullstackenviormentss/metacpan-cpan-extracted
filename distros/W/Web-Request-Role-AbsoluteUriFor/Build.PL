
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v5.029.
use strict;
use warnings;

use Module::Build 0.28;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.28"
  },
  "configure_requires" => {
    "Module::Build" => "0.28"
  },
  "dist_abstract" => "Construct an absolute URI honoring script_name",
  "dist_author" => [
    "Thomas Klausner <domm\@cpan.org>"
  ],
  "dist_name" => "Web-Request-Role-AbsoluteUriFor",
  "dist_version" => "1.001",
  "license" => "perl",
  "module_name" => "Web::Request::Role::AbsoluteUriFor",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Moose::Role" => 0,
    "Plack::Response" => 0,
    "perl" => "5.010"
  },
  "script_files" => [],
  "test_requires" => {
    "HTTP::Request" => 0,
    "HTTP::Request::Common" => 0,
    "Plack::Builder" => 0,
    "Plack::Test" => 0,
    "Test::More" => 0,
    "Web::Request" => 0,
    "strict" => 0,
    "utf8" => 0,
    "warnings" => 0
  }
);


my %fallback_build_requires = (
  "HTTP::Request" => 0,
  "HTTP::Request::Common" => 0,
  "Module::Build" => "0.28",
  "Plack::Builder" => 0,
  "Plack::Test" => 0,
  "Test::More" => 0,
  "Web::Request" => 0,
  "strict" => 0,
  "utf8" => 0,
  "warnings" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
