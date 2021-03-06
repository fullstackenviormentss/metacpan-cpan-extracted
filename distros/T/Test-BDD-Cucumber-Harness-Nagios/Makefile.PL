
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;

use 5.008005;

use ExtUtils::MakeMaker ;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Nagios output for Test::BDD::Cucumber",
  "AUTHOR" => "Markus Benning <ich\@markusbenning.de>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Test-BDD-Cucumber-Harness-Nagios",
  "EXE_FILES" => [
    "bin/check_pherkin"
  ],
  "LICENSE" => "perl",
  "NAME" => "Test::BDD::Cucumber::Harness::Nagios",
  "PREREQ_PM" => {
    "App::pherkin" => 0,
    "Getopt::Long" => 0,
    "Moose" => 0,
    "Test::BDD::Cucumber::Harness::Data" => 0,
    "Test::BDD::Cucumber::Model::Result" => 0,
    "Time::HiRes" => 0,
    "Time::Piece" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Find" => 0,
    "Test::More" => 0
  },
  "VERSION" => "1.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "App::pherkin" => 0,
  "File::Find" => 0,
  "Getopt::Long" => 0,
  "Moose" => 0,
  "Test::BDD::Cucumber::Harness::Data" => 0,
  "Test::BDD::Cucumber::Model::Result" => 0,
  "Test::More" => 0,
  "Time::HiRes" => 0,
  "Time::Piece" => 0,
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



