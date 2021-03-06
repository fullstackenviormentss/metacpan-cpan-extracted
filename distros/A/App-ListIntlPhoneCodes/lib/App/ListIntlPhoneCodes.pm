package App::ListIntlPhoneCodes;

our $DATE = '2016-02-13'; # DATE
our $VERSION = '0.01'; # VERSION

use 5.010001;
use strict;
use warnings;

use Perinci::Sub::Gen::AccessTable qw(gen_read_table_func);

our %SPEC;
use Exporter qw(import);
our @EXPORT_OK = qw(list_countries);

our $data;
{
    require Locale::Codes::Country_Codes;
    require Number::Phone::CountryCode;
    $data = [];
    my $id2names  = $Locale::Codes::Data{'country'}{'id2names'};
    my $id2alpha2 = $Locale::Codes::Data{'country'}{'id2code'}{'alpha-2'};

    for my $id (keys %$id2names) {
        my $alpha2 = $id2alpha2->{$id};
        my $npc = Number::Phone::CountryCode->new($alpha2);
        push @$data, [
            $alpha2,
            $id2names->{$id}[0],
            $npc ? $npc->country_code : undef,
        ];
    }

    $data = [sort {$a->[0] cmp $b->[0]} @$data];
}

my $res = gen_read_table_func(
    name => 'list_intl_phone_codes',
    summary => 'List international phone calling codes',
    table_data => $data,
    table_spec => {
        summary => 'List of international phone calling codes',
        fields => {
            alpha2 => {
                summary => 'ISO 2-letter code',
                schema => 'str*',
                pos => 0,
                sortable => 1,
            },
            en_country_name => {
                summary => 'English country name',
                schema => 'str*',
                pos => 1,
                sortable => 1,
            },
            code => {
                summary => 'English country name',
                schema => 'int',
                pos => 2,
                sortable => 1,
            },
        },
        pk => 'alpha2',
    },
);
die "Can't generate function: $res->[0] - $res->[1]" unless $res->[0] == 200;

1;
# ABSTRACT: List international phone calling codes

__END__

=pod

=encoding UTF-8

=head1 NAME

App::ListIntlPhoneCodes - List international phone calling codes

=head1 VERSION

This document describes version 0.01 of App::ListIntlPhoneCodes (from Perl distribution App-ListIntlPhoneCodes), released on 2016-02-13.

=head1 SYNOPSIS

 # Use via list-intl-phone-codes CLI script

=head1 FUNCTIONS


=head2 list_intl_phone_codes(%args) -> [status, msg, result, meta]

List international phone calling codes.

REPLACE ME

This function is not exportable.

Arguments ('*' denotes required arguments):

=over 4

=item * B<alpha2> => I<str>

Only return records where the 'alpha2' field equals specified value.

=item * B<alpha2.contains> => I<str>

Only return records where the 'alpha2' field contains specified text.

=item * B<alpha2.in> => I<array[str]>

Only return records where the 'alpha2' field is in the specified values.

=item * B<alpha2.is> => I<str>

Only return records where the 'alpha2' field equals specified value.

=item * B<alpha2.isnt> => I<str>

Only return records where the 'alpha2' field does not equal specified value.

=item * B<alpha2.max> => I<str>

Only return records where the 'alpha2' field is less than or equal to specified value.

=item * B<alpha2.min> => I<str>

Only return records where the 'alpha2' field is greater than or equal to specified value.

=item * B<alpha2.not_contains> => I<str>

Only return records where the 'alpha2' field does not contain specified text.

=item * B<alpha2.not_in> => I<array[str]>

Only return records where the 'alpha2' field is not in the specified values.

=item * B<alpha2.xmax> => I<str>

Only return records where the 'alpha2' field is less than specified value.

=item * B<alpha2.xmin> => I<str>

Only return records where the 'alpha2' field is greater than specified value.

=item * B<code> => I<int>

Only return records where the 'code' field equals specified value.

=item * B<code.in> => I<array[int]>

Only return records where the 'code' field is in the specified values.

=item * B<code.is> => I<int>

Only return records where the 'code' field equals specified value.

=item * B<code.isnt> => I<int>

Only return records where the 'code' field does not equal specified value.

=item * B<code.max> => I<int>

Only return records where the 'code' field is less than or equal to specified value.

=item * B<code.min> => I<int>

Only return records where the 'code' field is greater than or equal to specified value.

=item * B<code.not_in> => I<array[int]>

Only return records where the 'code' field is not in the specified values.

=item * B<code.xmax> => I<int>

Only return records where the 'code' field is less than specified value.

=item * B<code.xmin> => I<int>

Only return records where the 'code' field is greater than specified value.

=item * B<detail> => I<bool> (default: 0)

Return array of full records instead of just ID fields.

By default, only the key (ID) field is returned per result entry.

=item * B<en_country_name> => I<str>

Only return records where the 'en_country_name' field equals specified value.

=item * B<en_country_name.contains> => I<str>

Only return records where the 'en_country_name' field contains specified text.

=item * B<en_country_name.in> => I<array[str]>

Only return records where the 'en_country_name' field is in the specified values.

=item * B<en_country_name.is> => I<str>

Only return records where the 'en_country_name' field equals specified value.

=item * B<en_country_name.isnt> => I<str>

Only return records where the 'en_country_name' field does not equal specified value.

=item * B<en_country_name.max> => I<str>

Only return records where the 'en_country_name' field is less than or equal to specified value.

=item * B<en_country_name.min> => I<str>

Only return records where the 'en_country_name' field is greater than or equal to specified value.

=item * B<en_country_name.not_contains> => I<str>

Only return records where the 'en_country_name' field does not contain specified text.

=item * B<en_country_name.not_in> => I<array[str]>

Only return records where the 'en_country_name' field is not in the specified values.

=item * B<en_country_name.xmax> => I<str>

Only return records where the 'en_country_name' field is less than specified value.

=item * B<en_country_name.xmin> => I<str>

Only return records where the 'en_country_name' field is greater than specified value.

=item * B<fields> => I<array[str]>

Select fields to return.

=item * B<query> => I<str>

Search.

=item * B<random> => I<bool> (default: 0)

Return records in random order.

=item * B<result_limit> => I<int>

Only return a certain number of records.

=item * B<result_start> => I<int> (default: 1)

Only return starting from the n'th record.

=item * B<sort> => I<array[str]>

Order records according to certain field(s).

A list of field names separated by comma. Each field can be prefixed with '-' to
specify descending order instead of the default ascending.

=item * B<with_field_names> => I<bool>

Return field names in each record (as hash/associative array).

When enabled, function will return each record as hash/associative array
(field name => value pairs). Otherwise, function will return each record
as list/array (field value, field value, ...).

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

Please visit the project's homepage at L<https://metacpan.org/release/App-ListIntlPhoneCodes>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-App-ListIntlPhoneCodes>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=App-ListIntlPhoneCodes>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 SEE ALSO

L<Locale::Codes>

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
