# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.005.
use strict;
use warnings;

use 5.010000;

use ExtUtils::MakeMaker 6.48;

my %WriteMakefileArgs = (
  "ABSTRACT" => "it will not be used for any further transaction requests via L</txn>.",
  "AUTHOR" => "binary.com <cpan\@binary.com>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.48"
  },
  "DISTNAME" => "DBIx-TransactionManager-Distributed",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010000",
  "NAME" => "DBIx::TransactionManager::Distributed",
  "PREREQ_PM" => {
    "Exporter" => 0,
    "List::UtilsBy" => 0,
    "Scalar::Util" => 0
  },
  "TEST_REQUIRES" => {
    "DBD::Mock" => "1.45",
    "DBI" => "1.634",
    "Devel::Refcount" => "0.10",
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::CheckDeps" => "0.010",
    "Test::Deep" => "1.120",
    "Test::Fatal" => "0.014",
    "Test::More" => "0.98",
    "Test::Refcount" => "0.08",
    "Test::Warnings" => "0.026"
  },
  "VERSION" => "0.02",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "DBD::Mock" => "1.45",
  "DBI" => "1.634",
  "Devel::Refcount" => "0.10",
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "List::UtilsBy" => 0,
  "Scalar::Util" => 0,
  "Test::CheckDeps" => "0.010",
  "Test::Deep" => "1.120",
  "Test::Fatal" => "0.014",
  "Test::More" => "0.98",
  "Test::Refcount" => "0.08",
  "Test::Warnings" => "0.026"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
