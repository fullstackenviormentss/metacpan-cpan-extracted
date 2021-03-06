# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Interact with cryptoexchanges",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-cryp-exchange",
  "EXE_FILES" => [
    "script/cryp-exchange"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::cryp::exchange",
  "PREREQ_PM" => {
    "App::indodax" => 0,
    "Complete::Util" => "0.57",
    "Data::Sah::Compiler::perl::TH::bool" => 0,
    "Data::Sah::Compiler::perl::TH::str" => 0,
    "Finance::GDAX::Lite" => 0,
    "Finance::Indodax" => 0,
    "Log::Log4perl" => 0,
    "Log::Log4perl::Appender::LogGer" => 0,
    "Log::Log4perl::Layout::SimpleLayout" => 0,
    "Log::ger" => "0.023",
    "PERLANCAR::Module::List" => 0,
    "Perinci::CmdLine::cryp" => "0.004",
    "Role::Tiny" => 0,
    "Role::Tiny::With" => 0,
    "WebService::Cryptopia" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "App::indodax" => 0,
  "Complete::Util" => "0.57",
  "Data::Sah::Compiler::perl::TH::bool" => 0,
  "Data::Sah::Compiler::perl::TH::str" => 0,
  "File::Spec" => 0,
  "Finance::GDAX::Lite" => 0,
  "Finance::Indodax" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::Log4perl" => 0,
  "Log::Log4perl::Appender::LogGer" => 0,
  "Log::Log4perl::Layout::SimpleLayout" => 0,
  "Log::ger" => "0.023",
  "PERLANCAR::Module::List" => 0,
  "Perinci::CmdLine::cryp" => "0.004",
  "Role::Tiny" => 0,
  "Role::Tiny::With" => 0,
  "Test::More" => 0,
  "WebService::Cryptopia" => 0,
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
