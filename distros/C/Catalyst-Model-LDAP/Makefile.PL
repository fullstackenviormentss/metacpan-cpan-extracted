# This file was automatically generated by Dist::Zilla::Plugin::MakeMaker v6.010.
use strict;
use warnings;



use ExtUtils::MakeMaker;

my %WriteMakefileArgs = (
  "ABSTRACT" => "LDAP model class for Catalyst",
  "AUTHOR" => "Gavin Henry <ghenry\@surevoip.co.uk>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0
  },
  "DISTNAME" => "Catalyst-Model-LDAP",
  "LICENSE" => "perl",
  "NAME" => "Catalyst::Model::LDAP",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Catalyst" => "5.62",
    "Catalyst::Model" => 0,
    "Class::Accessor::Fast" => 0,
    "Data::Dumper" => 0,
    "Data::Page" => 0,
    "MRO::Compat" => 0,
    "Module::Runtime" => "0.015",
    "Net::LDAP" => "0.65",
    "Net::LDAP::Constant" => 0,
    "Net::LDAP::Control::ProxyAuth" => "1.09",
    "Net::LDAP::Control::Sort" => 0,
    "Net::LDAP::Control::VLV" => 0,
    "Net::LDAP::Entry" => 0,
    "Net::LDAP::Search" => 0,
    "base" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Catalyst" => "5.62",
    "Catalyst::Controller" => 0,
    "Catalyst::Test" => 0,
    "FindBin" => 0,
    "Test::More" => 0,
    "lib" => 0
  },
  "VERSION" => "0.21",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Catalyst" => "5.62",
  "Catalyst::Controller" => 0,
  "Catalyst::Model" => 0,
  "Catalyst::Test" => 0,
  "Class::Accessor::Fast" => 0,
  "Data::Dumper" => 0,
  "Data::Page" => 0,
  "FindBin" => 0,
  "MRO::Compat" => 0,
  "Module::Runtime" => "0.015",
  "Net::LDAP" => "0.65",
  "Net::LDAP::Constant" => 0,
  "Net::LDAP::Control::ProxyAuth" => "1.09",
  "Net::LDAP::Control::Sort" => 0,
  "Net::LDAP::Control::VLV" => 0,
  "Net::LDAP::Entry" => 0,
  "Net::LDAP::Search" => 0,
  "Test::More" => 0,
  "base" => 0,
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
