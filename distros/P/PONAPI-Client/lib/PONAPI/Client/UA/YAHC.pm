package PONAPI::Client::UA::YAHC;
# ABSTRACT: A wrapper for a YAHC UA

################################################################################
################################################################################

use strict;
use warnings;

use Moose;
use YAHC;

with 'PONAPI::Client::Role::UA';

################################################################################
################################################################################

has yahc => (
    is  => 'rw',
    isa => 'Ref',
    lazy_build => 1,
);

has yahc_storage => (
    is  => 'rw',
    isa => 'Ref',
);

has scheme => (
    is  => 'rw',
    isa => 'Str',
);

################################################################################
################################################################################

sub _build_yahc {
    my ($self) = @_;
    my ($yahc, $yahc_storage) = YAHC->new();

    $self->yahc_storage($yahc_storage);
    return $yahc;
}

################################################################################
################################################################################

sub send_http_request {
    my ($self, $request) = @_;

    my $ponapi_response;

    my $callback = sub {
        my ($conn) = @_;
        my $response = $conn->{response};
        $ponapi_response = {
            status => $response->{status},
            head   => $response->{head},
            body   => $response->{body},
        };
    };

    local $request->{callback} = $callback;
    local $request->{scheme} = $self->scheme;

    my $yahc = $self->yahc;

    $yahc->request($request);
    $yahc->run();

    return $ponapi_response;
}

################################################################################
################################################################################

sub before_request { }

################################################################################
################################################################################

sub after_request { }

################################################################################
################################################################################

no Moose;
__PACKAGE__->meta->make_immutable();

1;

################################################################################
################################################################################

__END__

=pod

=encoding UTF-8

=head1 NAME

PONAPI::Client::UA::YAHC - A wrapper for a YAHC UA

=head1 VERSION

version 0.002010

=head1 AUTHORS

=over 4

=item *

Mickey Nasriachi <mickey@cpan.org>

=item *

Stevan Little <stevan@cpan.org>

=item *

Brian Fraser <hugmeir@cpan.org>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2017 by Mickey Nasriachi, Stevan Little, Brian Fraser.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
