
# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v5.020.
use strict;
use warnings;



use ExtUtils::MakeMaker ;



my %WriteMakefileArgs = (
  "ABSTRACT" => "WebService::Saasu - an interface to saasu.com's RESTful accounting API using Web::API",
  "AUTHOR" => "Tobias Kirschstein <lev\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "WebService-Saasu",
  "EXE_FILES" => [],
  "LICENSE" => "bsd",
  "NAME" => "WebService::Saasu",
  "PREREQ_PM" => {
    "Modern::Perl" => 0,
    "Mouse" => 0,
    "Web::API" => 0,
    "XML::Simple" => 0
  },
  "VERSION" => "0.5",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Modern::Perl" => 0,
  "Mouse" => 0,
  "Web::API" => 0,
  "XML::Simple" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



