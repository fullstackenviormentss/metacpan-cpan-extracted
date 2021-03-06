# This Makefile.PL for Ref-Util was generated by
# Dist::Zilla::Plugin::MakeMaker::Awesome 0.41.
# Don't edit it but the dist.ini and plugins used to construct it.

use strict;
use warnings;

use 5.006;
use ExtUtils::MakeMaker;

if (eval { require Ref::Util } && Ref::Util->VERSION < 0.114) {
  package MY;
  no warnings 'once';

  *install = sub {
    my $self = shift;
    return '
pure_site_install ::
	$(NOECHO) $(RM_F) ' . $self->quote_literal(
      $self->catfile('$(DESTINSTALLSITEARCH)', 'Ref', 'Util.pm')
    ) . "\n" . $self->SUPER::install;
  };
}

my %WriteMakefileArgs = (
  "ABSTRACT" => "Utility functions for checking references",
  "AUTHOR" => "Sawyer X <xsawyerx\@cpan.org>, Aaron Crane <arc\@cpan.org>, Vikenty Fesunov <vyf\@cpan.org>, Gonzalo Diethelm <gonzus\@cpan.org>, Karen Etheridge <ether\@cpan.org>",
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "Text::ParseWords" => 0
  },
  "DISTNAME" => "Ref-Util",
  "LICENSE" => "mit",
  "MIN_PERL_VERSION" => "5.006",
  "NAME" => "Ref::Util",
  "PREREQ_PM" => {
    "Exporter" => "5.57"
  },
  "TEST_REQUIRES" => {
    "ExtUtils::MakeMaker" => 0,
    "File::Spec" => 0,
    "Test::More" => "0.96"
  },
  "VERSION" => "0.204",
  "test" => {
    "TESTS" => "t/*.t"
  }
);

my %FallbackPrereqs = (
  "Exporter" => "5.57",
  "ExtUtils::MakeMaker" => 0,
  "File::Spec" => 0,
  "Test::More" => "0.96"
);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.034
if (!want_pp() && can_xs()) {
    test_requires('Ref::Util::XS');
    runtime_requires('Ref::Util::XS');
}

unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);

# inserted by Dist::Zilla::Plugin::DynamicPrereqs 0.034
sub _add_prereq {
  my ($mm_key, $module, $version_or_range) = @_;
  $version_or_range ||= 0;
  warn "$module already exists in $mm_key (at version $WriteMakefileArgs{$mm_key}{$module}) -- need to do a sane metamerge!"
    if exists $WriteMakefileArgs{$mm_key}{$module}
      and $WriteMakefileArgs{$mm_key}{$module} ne '0'
      and $WriteMakefileArgs{$mm_key}{$module} ne $version_or_range;
  warn "$module already exists in FallbackPrereqs (at version $WriteMakefileArgs{$mm_key}{$module}) -- need to do a sane metamerge!"
    if exists $FallbackPrereqs{$module} and $FallbackPrereqs{$module} ne '0'
        and $FallbackPrereqs{$module} ne $version_or_range;
  $WriteMakefileArgs{$mm_key}{$module} = $FallbackPrereqs{$module} = $version_or_range;
  return;
}

use lib 'inc';
use ExtUtils::HasCompiler 0.014 'can_compile_loadable_object';
{
  my $can_xs;
  sub can_xs {
    return $can_xs if defined $can_xs;
    $can_xs = can_compile_loadable_object(quiet => 1) ? 1 : 0;
  }
}

sub parse_args {
  require ExtUtils::MakeMaker;
  require Text::ParseWords;
  ExtUtils::MakeMaker::parse_args(
    my $tmp = {},
    Text::ParseWords::shellwords($ENV{PERL_MM_OPT} || ''),
    @ARGV,
  );
  return $tmp->{ARGS} || {};
}

sub runtime_requires {
  my ($module, $version_or_range) = @_;
  _add_prereq(PREREQ_PM => $module, $version_or_range);
}

sub test_requires {
  my ($module, $version_or_range) = @_;
  _add_prereq(TEST_REQUIRES => $module, $version_or_range);
}

{
  my $want_pp;
  sub want_pp {
    return $want_pp if defined $want_pp;
    $want_pp = parse_args()->{PUREPERL_ONLY} ? 1 : 0
  }
}
