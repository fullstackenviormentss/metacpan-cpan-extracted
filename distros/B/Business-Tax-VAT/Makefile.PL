# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.037.
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "perform European VAT calculations",
  "AUTHOR" => "Tony Bowden <kasei\@tmtm.com>",
  "BUILD_REQUIRES" => {
    "Module::Build" => "0.30"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "Module::Build" => "0.30"
  },
  "DISTNAME" => "Business-Tax-VAT",
  "EXE_FILES" => [],
  "LICENSE" => "gpl",
  "MIN_PERL_VERSION" => "5.008",
  "NAME" => "Business::Tax::VAT",
  "PREREQ_PM" => {},
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Pod::Coverage::TrustPod" => 0,
    "Test::Kwalitee" => "1.21",
    "Test::More" => "0.88",
    "Test::Pod" => "1.41",
    "Test::Pod::Coverage" => "1.08"
  },
  "VERSION" => "1.10",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Module::Build" => "0.30",
  "Pod::Coverage::TrustPod" => 0,
  "Test::Kwalitee" => "1.21",
  "Test::More" => "0.88",
  "Test::Pod" => "1.41",
  "Test::Pod::Coverage" => "1.08"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
