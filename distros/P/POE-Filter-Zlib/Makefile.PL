# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "A POE filter wrapped around Compress::Zlib",
  "AUTHOR" => "Chris Williams <chris\@bingosnet.co.uk>, Martijn van Beers",
  "BUILD_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.59",
    "POE::Filter::Line" => 0,
    "POE::Filter::Stackable" => 0,
    "Test::More" => "0.47"
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "POE-Filter-Zlib",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "POE::Filter::Zlib",
  "PREREQ_PM" => {
    "Compress::Raw::Zlib" => 2,
    "POE" => "0.38",
    "POE::Filter" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => "0.47"
  },
  "VERSION" => "2.04",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Compress::Raw::Zlib" => 2,
  "ExtUtils::MakeMaker" => "6.59",
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "POE" => "0.38",
  "POE::Filter" => 0,
  "POE::Filter::Line" => 0,
  "POE::Filter::Stackable" => 0,
  "Test::More" => "0.47"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
