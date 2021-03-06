package App::lcpan::Cmd::mod2dist;

our $DATE = '2018-02-08'; # DATE
our $VERSION = '1.022'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;

our %SPEC;

$SPEC{'handle_cmd'} = {
    v => 1.1,
    summary => 'Get distribution name of module(s)',
    args => {
        %App::lcpan::common_args,
        %App::lcpan::mods_args,
    },
};
sub handle_cmd {
    my %args = @_;

    my $state = App::lcpan::_init(\%args, 'ro');
    my $dbh = $state->{dbh};

    my $mods = $args{modules};

    my $mods_s = join(",", map {$dbh->quote($_)} @$mods);

    my $sth = $dbh->prepare("
SELECT
  module.name module,
  dist.name dist
FROM module
LEFT JOIN file ON module.file_id=file.id
LEFT JOIN dist ON file.id=dist.file_id
WHERE module.name IN ($mods_s)");

    my $res;
    if (@$mods == 1) {
        $sth->execute;
        (undef, $res) = $sth->fetchrow_array;
    } else {
        $sth->execute;
        $res = {};
        while (my $row = $sth->fetchrow_hashref) {
            $res->{$row->{module}} = $row->{dist};
        }
    }
    [200, "OK", $res];
}

1;
# ABSTRACT: Get distribution name of module(s)

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::mod2dist - Get distribution name of module(s)

=head1 VERSION

This document describes version 1.022 of App::lcpan::Cmd::mod2dist (from Perl distribution App-lcpan), released on 2018-02-08.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, result, meta]

Get distribution name of module(s).

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

=item * B<modules>* => I<array[perl::modname]>

=back

Returns an enveloped result (an array).

First element (status) is an integer containing HTTP status code
(200 means OK, 4xx caller error, 5xx function error). Second element
(msg) is a string containing error message, or 'OK' if status is
200. Third element (result) is optional, the actual result. Fourth
element (meta) is called result metadata and is optional, a hash
that contains extra information.

Return value:  (any)

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/App-lcpan>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-lcpan>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-lcpan>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018, 2017, 2016, 2015 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
