# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.041.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "JSON serialization support",
  "AUTHOR" => "John Napiorkowski <jjnapiork\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "HTML-Formhandler-Role-ToJSON",
  "LICENSE" => "perl",
  "NAME" => "HTML::Formhandler::Role::ToJSON",
  "PREREQ_PM" => {
    "Moose" => "2.1403"
  },
  "TEST_REQUIRES" => {
    "HTML::Formhandler" => 0,
    "Test::Most" => "0.34"
  },
  "VERSION" => "0.002",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "HTML::Formhandler" => 0,
  "Moose" => "2.1403",
  "Test::Most" => "0.34"
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);
