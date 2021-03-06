package Sah::Schema::example::recurse2b;

our $DATE = '2016-12-09'; # DATE
our $VERSION = '0.005'; # VERSION

our $schema = ["example::recurse2a" => {
    summary => 'Recursive schema',
}, {}];

1;
# ABSTRACT: Recursive schema

__END__

=pod

=encoding UTF-8

=head1 NAME

Sah::Schema::example::recurse2b - Recursive schema

=head1 VERSION

This document describes version 0.005 of Sah::Schema::example::recurse2b (from Perl distribution Sah-Schemas-Examples), released on 2016-12-09.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Sah-Schemas-Examples>.

=head1 SOURCE

Source repository is at L<https://github.com/perlancar/perl-Sah-Schemas-Examples>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Sah-Schemas-Examples>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

perlancar <perlancar@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by perlancar@cpan.org.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
