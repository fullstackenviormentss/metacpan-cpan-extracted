# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.008.
use strict;
use warnings;

use 5.012000;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "a scalable distributed batch processing framework using MongoDB.",
  "AUTHOR" => "Ashley Willis <ashleyw\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "disbatch",
  "EXE_FILES" => [
    "bin/disbatch",
    "bin/disbatch-create-users",
    "bin/disbatch.pl",
    "bin/disbatchd",
    "bin/task_runner"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.012000",
  "NAME" => "disbatch",
  "PREREQ_PM" => {
    "Cpanel::JSON::XS" => 0,
    "Data::Dumper" => 0,
    "Encode" => 0,
    "File::Slurp" => 0,
    "Getopt::Long" => 0,
    "IO::Wrap" => 0,
    "JSON" => 0,
    "LWP::UserAgent" => 0,
    "Limper" => 0,
    "Limper::Engine::PSGI" => 0,
    "Limper::SendFile" => 0,
    "Limper::SendJSON" => 0,
    "Log::Log4perl" => 0,
    "MongoDB" => "1.0.4",
    "MongoDB::OID" => "1.0.4",
    "POSIX" => 0,
    "Pod::Usage" => 0,
    "Safe::Isa" => 0,
    "Starman" => 0,
    "Sys::Hostname" => 0,
    "Term::ReadKey" => 0,
    "Text::CSV_XS" => 0,
    "Text::Table" => 0,
    "Time::Moment" => 0,
    "Try::Tiny" => 0,
    "Try::Tiny::Retry" => 0,
    "URL::Encode" => 0,
    "boolean" => "0.25",
    "lib" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Path" => 0,
    "Net::HTTP::Client" => 0,
    "Test::More" => 0
  },
  "VERSION" => "3.990",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Cpanel::JSON::XS" => 0,
  "Data::Dumper" => 0,
  "Encode" => 0,
  "File::Path" => 0,
  "File::Slurp" => 0,
  "Getopt::Long" => 0,
  "IO::Wrap" => 0,
  "JSON" => 0,
  "LWP::UserAgent" => 0,
  "Limper" => 0,
  "Limper::Engine::PSGI" => 0,
  "Limper::SendFile" => 0,
  "Limper::SendJSON" => 0,
  "Log::Log4perl" => 0,
  "MongoDB" => "1.0.4",
  "MongoDB::OID" => "1.0.4",
  "Net::HTTP::Client" => 0,
  "POSIX" => 0,
  "Pod::Usage" => 0,
  "Safe::Isa" => 0,
  "Starman" => 0,
  "Sys::Hostname" => 0,
  "Term::ReadKey" => 0,
  "Test::More" => 0,
  "Text::CSV_XS" => 0,
  "Text::Table" => 0,
  "Time::Moment" => 0,
  "Try::Tiny" => 0,
  "Try::Tiny::Retry" => 0,
  "URL::Encode" => 0,
  "boolean" => "0.25",
  "lib" => 0,
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
