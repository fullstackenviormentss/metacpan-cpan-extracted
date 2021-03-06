# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.010001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Corrupt files by writing random bytes/blocks to them",
  "AUTHOR" => "perlancar <perlancar\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-corruptor",
  "EXE_FILES" => [
    "script/corruptor"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010001",
  "NAME" => "App::corruptor",
  "PREREQ_PM" => {
    "Data::Sah::Coerce::perl::float::str_as_percent" => 0,
    "Data::Sah::Coerce::perl::str::str_strip_trailing_slash" => 0,
    "Data::Sah::Compiler::perl::TH::array" => 0,
    "Data::Sah::Compiler::perl::TH::float" => 0,
    "Data::Sah::Compiler::perl::TH::str" => 0,
    "Log::ger" => "0.023",
    "Perinci::CmdLine::Any" => 0,
    "Perinci::CmdLine::Base" => "1.79",
    "Sah::Schema::filename" => 0,
    "Sah::Schema::percent" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Spec" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::More" => 0
  },
  "VERSION" => "0.001",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::Sah::Coerce::perl::float::str_as_percent" => 0,
  "Data::Sah::Coerce::perl::str::str_strip_trailing_slash" => 0,
  "Data::Sah::Compiler::perl::TH::array" => 0,
  "Data::Sah::Compiler::perl::TH::float" => 0,
  "Data::Sah::Compiler::perl::TH::str" => 0,
  "File::Spec" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::ger" => "0.023",
  "Perinci::CmdLine::Any" => 0,
  "Perinci::CmdLine::Base" => "1.79",
  "Sah::Schema::filename" => 0,
  "Sah::Schema::percent" => 0,
  "Test::More" => 0,
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
