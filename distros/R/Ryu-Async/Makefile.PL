# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.014000;

use ExtUtils::MakeMaker 6.48;

my %WriteMakefileArgs = (
  "ABSTRACT" => "IO::Async support for Ryu stream management",
  "AUTHOR" => "Tom Molesworth <TEAM\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.48"
  },
  "DISTNAME" => "Ryu-Async",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.014000",
  "NAME" => "Ryu::Async",
  "PREREQ_PM" => {
    "Future" => "0.37",
    "IO::Async" => "0.71",
    "IO::Socket::IP" => "0.37",
    "Log::Any" => "1.000",
    "Ryu" => "0.026",
    "Syntax::Keyword::Try" => 0,
    "URI::tcp" => 0,
    "URI::udp" => 0,
    "curry" => "1.001",
    "namespace::clean" => 0,
    "parent" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::CheckDeps" => "0.010",
    "Test::Deep" => "1.126",
    "Test::Fatal" => "0.010",
    "Test::More" => "0.98",
    "Test::Refcount" => "0.07",
    "Variable::Disposition" => "0.004",
    "indirect" => 0
  },
  "VERSION" => "0.009",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "Future" => "0.37",
  "IO::Async" => "0.71",
  "IO::Handle" => 0,
  "IO::Socket::IP" => "0.37",
  "IPC::Open3" => 0,
  "Log::Any" => "1.000",
  "Ryu" => "0.026",
  "Syntax::Keyword::Try" => 0,
  "Test::CheckDeps" => "0.010",
  "Test::Deep" => "1.126",
  "Test::Fatal" => "0.010",
  "Test::More" => "0.98",
  "Test::Refcount" => "0.07",
  "URI::tcp" => 0,
  "URI::udp" => 0,
  "Variable::Disposition" => "0.004",
  "curry" => "1.001",
  "indirect" => 0,
  "namespace::clean" => 0,
  "parent" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
