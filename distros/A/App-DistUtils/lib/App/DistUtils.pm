package App::DistUtils;

our $DATE = '2017-01-16'; # DATE
our $VERSION = '0.14'; # VERSION

use 5.010001;

our %dist_arg_single = (
    dist => {
        schema => 'perl::distname*',
        req => 1,
        pos => 0,
        completion => sub {
            require Complete::Dist;
            my %args = @_;
            Complete::Dist::complete_dist(word=>$args{word});
        },
    },
);

our %dist_arg_multiple = (
    dist => {
        schema => ['array*', of=>'perl::distname*', min_len=>1],
        req => 1,
        pos => 0,
        greedy => 1,
        element_completion => sub {
            require Complete::Dist;
            my %args = @_;
            Complete::Dist::complete_dist(word=>$args{word});
        },
    },
);

1;
# ABSTRACT: Collection of utilities related to Perl distributions

__END__

=pod

=encoding UTF-8

=head1 NAME

App::DistUtils - Collection of utilities related to Perl distributions

=head1 VERSION

This document describes version 0.14 of App::DistUtils (from Perl distribution App-DistUtils), released on 2017-01-16.

=head1 SYNOPSIS

This distribution provides the following command-line utilities related to Perl
distributions:

=over

=item * L<dir2dist>

=item * L<dir2mod>

=item * L<dist-dir>

=item * L<dist-has-deb>

=item * L<dist2deb>

=item * L<dist2mod>

=item * L<list-dist-contents>

=item * L<list-dist-modules>

=item * L<list-dists>

=item * L<mod2dist>

=item * L<packlist-for>

=item * L<parse-release-file-name>

=item * L<pwd2dist>

=item * L<pwd2mod>

=item * L<uninstall-dist>

=back

The main feature of these utilities is tab completion.

=head1 FAQ

=head2 What is the purpose of this distribution? Haven't other similar utilities existed?

For example, L<mpath> from L<Module::Path> distribution is similar to L<pmpath>
in L<App::PMUtils>, and L<mversion> from L<Module::Version> distribution is
similar to L<pmversion> from L<App::PMUtils> distribution, and so on.

True. The main point of these utilities is shell tab completion, to save
typing.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-DistUtils>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-DistUtils>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-DistUtils>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

Below is the list of distributions that provide CLI utilities for various
purposes, with the focus on providing shell tab completion feature.

L<App::DistUtils>, utilities related to Perl distributions.

L<App::DzilUtils>, utilities related to L<Dist::Zilla>.

L<App::GitUtils>, utilities related to git.

L<App::IODUtils>, utilities related to L<IOD> configuration files.

L<App::LedgerUtils>, utilities related to Ledger CLI files.

L<App::PlUtils>, utilities related to Perl scripts.

L<App::PMUtils>, utilities related to Perl modules.

L<App::ProgUtils>, utilities related to programs.

L<App::WeaverUtils>, utilities related to L<Pod::Weaver>.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
