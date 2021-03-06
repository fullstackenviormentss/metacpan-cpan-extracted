# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.032.
use strict;
use warnings;

use 5.014000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Parses Callgrind output file into a hashref representing the call tree of the source program",
  "AUTHOR" => "Dave Mueller <dave\@perljedi.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Callgrind-Parser",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.014000",
  "NAME" => "Callgrind::Parser",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "base" => 0,
    "strict" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::Exception" => 0,
    "Test::Spec" => 0
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "Test::Exception" => 0,
  "Test::Spec" => 0,
  "base" => 0,
  "strict" => 0,
  "vars" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
