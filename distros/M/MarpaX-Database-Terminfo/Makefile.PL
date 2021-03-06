# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.007.
use strict;
use warnings;

use 5.010;

use ExtUtils::MakeMaker;

use File::ShareDir::Install;
$File::ShareDir::Install::INCLUDE_DOTFILES = 1;
$File::ShareDir::Install::INCLUDE_DOTDIRS = 1;
install_share dist => "share";


my %WriteMakefileArgs = (
  "ABSTRACT" => "Terminfo interface",
  "AUTHOR" => "jddurand <jeandamiendurand\@free.fr>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::ShareDir::Install" => "0.06"
  },
  "DISTNAME" => "MarpaX-Database-Terminfo",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.010",
  "NAME" => "MarpaX::Database::Terminfo",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Exporter" => 0,
    "File::ShareDir" => 0,
    "Log::Any" => 0,
    "Marpa::R2" => 0,
    "Sereal::Decoder" => "3.015",
    "Time::HiRes" => 0,
    "base" => 0,
    "constant" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "IO::Handle" => 0,
    "IPC::Open3" => 0,
    "Path::Tiny" => 0,
    "Test::File::ShareDir" => 0,
    "Test::More" => 0,
    "blib" => "1.01"
  },
  "VERSION" => "0.012",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Exporter" => 0,
  "ExtUtils::MakeMaker" => 0,
  "File::ShareDir" => 0,
  "File::Spec" => 0,
  "File::Temp" => 0,
  "IO::Handle" => 0,
  "IPC::Open3" => 0,
  "Log::Any" => 0,
  "Marpa::R2" => 0,
  "Path::Tiny" => 0,
  "Sereal::Decoder" => "3.015",
  "Test::File::ShareDir" => 0,
  "Test::More" => 0,
  "Time::HiRes" => 0,
  "base" => 0,
  "blib" => "1.01",
  "constant" => 0,
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

{
package
MY;
use File::ShareDir::Install qw(postamble);
}
