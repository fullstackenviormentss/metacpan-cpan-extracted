
# This file was automatically generated by Dist::Zilla::Plugin::ModuleBuild v5.015.
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Text::Template engine for Dancer2",
  "dist_author" => [
    "Thibaut Le Page <thilp\@cpan.org>"
  ],
  "dist_name" => "Dancer2-Template-TextTemplate",
  "dist_version" => "1.003",
  "license" => "perl",
  "module_name" => "Dancer2::Template::TextTemplate",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "CHI" => 0,
    "Carp" => 0,
    "Dancer2::Core::Role::Template" => 0,
    "Dancer2::Core::Types" => 0,
    "Moo" => 0,
    "MooX::Types::MooseLike::Base" => 0,
    "Safe" => "2.26",
    "Scalar::Util" => 0,
    "Text::Template" => "1.46",
    "namespace::clean" => 0,
    "perl" => "5.010_000",
    "strict" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "File::Temp" => 0,
    "IPC::System::Simple" => 0,
    "Test::API" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.88",
    "autodie" => 0
  }
);


my %fallback_build_requires = (
  "File::Temp" => 0,
  "IPC::System::Simple" => 0,
  "Module::Build" => "0.3601",
  "Test::API" => 0,
  "Test::Fatal" => 0,
  "Test::More" => "0.88",
  "autodie" => 0
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  delete $module_build_args{test_requires};
  $module_build_args{build_requires} = \%fallback_build_requires;
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
