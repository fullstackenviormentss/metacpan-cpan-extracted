package WebService::DigitalOcean::Role::Images;
# ABSTRACT: Images role for DigitalOcean WebService
use utf8;
use Moo::Role;
use feature 'state';
use Types::Standard qw/Object/;
use Type::Utils;
use Type::Params qw/compile/;

requires 'make_request';

our $VERSION = '0.026'; # VERSION

sub image_list {
    state $check = compile(Object);
    my ($self, $opts) = $check->(@_);

    return $self->make_request(GET => "/images");
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

WebService::DigitalOcean::Role::Images - Images role for DigitalOcean WebService

=head1 VERSION

version 0.026

=head1 DESCRIPTION

Implements the Images resource.

=head1 METHODS

=head2 image_list

See main documentation in L<WebService::DigitalOcean>.

=head1 AUTHOR

André Walker <andre@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2015 by André Walker.

This is free software, licensed under:

  The GNU General Public License, Version 2, June 1991

=cut
