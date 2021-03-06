# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A Moose based SVG Timeline drawing class.",
  "AUTHOR" => "Vijayvithal <jvs\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "SVG-Timeline-Compact",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "SVG::Timeline::Compact",
  "PREREQ_PM" => {
    "DateTime" => 0,
    "DateTime::Duration" => 0,
    "DateTime::Format::Duration" => 0,
    "Moose" => 0,
    "POSIX" => 0,
    "SVG" => 0,
    "namespace::clean" => 0
  },
  "TEST_REQUIRES" => {
    "DateTime::Format::Natural" => 0,
    "Test::More" => 0,
    "diagnostics" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "DateTime" => 0,
  "DateTime::Duration" => 0,
  "DateTime::Format::Duration" => 0,
  "DateTime::Format::Natural" => 0,
  "Moose" => 0,
  "POSIX" => 0,
  "SVG" => 0,
  "Test::More" => 0,
  "diagnostics" => 0,
  "namespace::clean" => 0,
  "strict" => 0,
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
