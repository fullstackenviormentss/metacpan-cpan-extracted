package Boxer::CLI::Command::About;

=encoding UTF-8

=cut

use v5.14;
use utf8;
use strictures 2;
use version;
use Role::Commons -all;

use Boxer::CLI -command;

use namespace::clean;

=head1 VERSION

Version v1.1.7

=cut

our $VERSION = version->declare("v1.1.7");

use constant {
	abstract   => q[list which boxer plugins are installed],
	usage_desc => q[%c about],
};

use constant FORMAT_STR => "%-36s%10s %s\n";

sub command_names
{
	qw(
		about
		credits
	);
}

sub opt_spec
{
	return;
}

sub execute
{
	my ( $self, $opt, $args ) = @_;

	my $auth = $self->app->can('AUTHORITY');
	printf(
		FORMAT_STR,
		ref( $self->app ),
		$self->app->VERSION,
		$auth ? $self->app->$auth : '???',
	);

	foreach my $cmd ( sort $self->app->command_plugins ) {
		my $auth = $cmd->can('AUTHORITY');
		printf(
			FORMAT_STR,
			$cmd,
			$cmd->VERSION,
			$auth ? $cmd->$auth : '???',
		);
	}
}

=head1 AUTHOR

Jonas Smedegaard C<< <dr@jones.dk> >>.

=cut

our $AUTHORITY = 'cpan:JONASS';

=head1 COPYRIGHT AND LICENCE

Copyright © 2013-2016 Jonas Smedegaard

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 DISCLAIMER OF WARRANTIES

THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.

=cut

1;
