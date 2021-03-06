# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.006.
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Command-line interface for RESTful web services",
  "AUTHOR" => "Brian Phillips <bphillips\@cpan.org>, Matt Perry <matt\@mattperry.com> (current maintainer)",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "App-Presto",
  "EXE_FILES" => [
    "bin/presto"
  ],
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "App::Presto",
  "PREREQ_PM" => {
    "Data::DPath" => 0,
    "Data::Dump" => 0,
    "Data::Dumper" => 0,
    "File::HomeDir" => 0,
    "File::Path" => "2.08",
    "File::Slurp" => 0,
    "JSON" => 0,
    "MIME::Base64" => 0,
    "Module::Pluggable" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "REST::Client" => 0,
    "Regexp::Common" => "2013030901",
    "Scalar::Util" => 0,
    "Term::ShellUI" => 0,
    "URI" => 0,
    "URI::QueryParam" => 0,
    "YAML" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "File::Basename" => 0,
    "File::Spec" => 0,
    "HTTP::Headers" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Test::MockObject" => 0,
    "Test::More" => 0,
    "blib" => "1.01"
  },
  "VERSION" => "0.010",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Data::DPath" => 0,
  "Data::Dump" => 0,
  "Data::Dumper" => 0,
  "File::Basename" => 0,
  "File::HomeDir" => 0,
  "File::Path" => "2.08",
  "File::Slurp" => 0,
  "File::Spec" => 0,
  "HTTP::Headers" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "JSON" => 0,
  "MIME::Base64" => 0,
  "Module::Pluggable" => 0,
  "Moo" => 0,
  "Moo::Role" => 0,
  "REST::Client" => 0,
  "Regexp::Common" => "2013030901",
  "Scalar::Util" => 0,
  "Term::ShellUI" => 0,
  "Test::MockObject" => 0,
  "Test::More" => 0,
  "URI" => 0,
  "URI::QueryParam" => 0,
  "YAML" => 0,
  "blib" => "1.01",
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
