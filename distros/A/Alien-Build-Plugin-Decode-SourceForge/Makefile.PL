use strict; use warnings;
BEGIN {
  unless(eval q{ use 5.008001; 1}) {
    print "Perl 5.008001 or better required\n";
    exit;
  }
}
# This file was automatically generated by Dist::Zilla::Plugin::Author::Plicease::MakeMaker v2.20.
use strict;
use warnings;

use 5.008001;

use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "Alien::Build plugin to handle SourceForge links",
  "AUTHOR" => "Graham Ollis <plicease\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Alien-Build-Plugin-Decode-SourceForge",
  "LICENSE" => "perl",
  "MIN_PERL_VERSION" => "5.008001",
  "NAME" => "Alien::Build::Plugin::Decode::SourceForge",
  "PM" => {
    "lib/Alien/Build/Plugin/Decode/SourceForge.pm" => "\$(INST_LIB)/Alien/Build/Plugin/Decode/SourceForge.pm"
  },
  "PREREQ_PM" => {
    "Alien::Build" => "0.62",
    "Alien::Build::Plugin" => 0,
    "URI" => 0
  },
  "TEST_REQUIRES" => {
    "HTML::LinkExtor" => 0,
    "Test2::V0" => "0.000060",
    "Test::Alien::Build" => 0,
    "URI::Escape" => 0
  },
  "VERSION" => "0.01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Alien::Build" => "0.62",
  "Alien::Build::Plugin" => 0,
  "HTML::LinkExtor" => 0,
  "Test2::V0" => "0.000060",
  "Test::Alien::Build" => 0,
  "URI" => 0,
  "URI::Escape" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
