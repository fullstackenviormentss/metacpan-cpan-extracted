# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.007.
use strict;
use warnings;

use 5.014000;

use ExtUtils::MakeMaker 6.48;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A module to parse FIX market data.",
  "AUTHOR" => "binary.com <BINARY\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.48"
  },
  "DISTNAME" => "FIX-Parser",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.014000",
  "NAME" => "FIX::Parser",
  "PREREQ_PM" => {},
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::CheckDeps" => "0.010",
    "Test::FailWarnings" => 0,
    "Test::More" => "0.94",
    "Test::Most" => 0
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Test::CheckDeps" => "0.010",
  "Test::FailWarnings" => 0,
  "Test::More" => "0.94",
  "Test::Most" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
