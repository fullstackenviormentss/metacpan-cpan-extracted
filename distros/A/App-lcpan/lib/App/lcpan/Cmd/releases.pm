package App::lcpan::Cmd::releases;

our $DATE = '2018-02-08'; # DATE
our $VERSION = '1.022'; # VERSION

use 5.010;
use strict;
use warnings;

require App::lcpan;

our %SPEC;

$SPEC{handle_cmd} = $App::lcpan::SPEC{releases};
*handle_cmd = \&App::lcpan::releases;

1;
# ABSTRACT: List releases/tarballs

__END__

=pod

=encoding UTF-8

=head1 NAME

App::lcpan::Cmd::releases - List releases/tarballs

=head1 VERSION

This document describes version 1.022 of App::lcpan::Cmd::releases (from Perl distribution App-lcpan), released on 2018-02-08.

=head1 FUNCTIONS


=head2 handle_cmd

Usage:

 handle_cmd(%args) -> [status, msg, result, meta]

List releases/tarballs.

The status field is the processing status of the file/release by lcpan. C<ok>
means file has been extracted and the meta files parsed, C<nofile> means file is
not found in mirror (possibly because the mirroring process excludes the file
e.g. due to file size too large), C<nometa> means file does not contain
META.{yml,json}, C<unsupported> means file archive format is not supported (e.g.
rar), C<err> means some other error in processing file.

This function is not exported.

Arguments ('*' denotes required arguments):

=over 4

=item * B<author> => I<str>

Filter by author.

=item * B<cpan> => I<dirname>

Location of your local CPAN mirror, e.g. /path/to/cpan.

Defaults to C<~/cpan>.

=item * B<detail> => I<bool>

=item * B<full_path> => I<bool>

=item * B<has_buildpl> => I<bool>

=item * B<has_makefilepl> => I<bool>

=item * B<has_metajson> => I<bool>

=item * B<has_metayml> => I<bool>

=item * B<index_name> => I<filename> (default: "index.db")

Filename of index.

=item * B<latest> => I<bool>

=item * B<no_path> => I<bool>

=item * B<or> => I<bool>

When there are more than one query, perform OR instead of AND logic.

=item * B<query> => I<array[str]>

Search query.

=item * B<query_type> => I<str> (default: "any")

=item * B<sort> => I<array[str]> (default: ["name"])

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
