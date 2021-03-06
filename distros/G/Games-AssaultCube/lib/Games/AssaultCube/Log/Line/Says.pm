# Declare our package
package Games::AssaultCube::Log::Line::Says;

# import the Moose stuff
use Moose;

# Initialize our version
use vars qw( $VERSION );
$VERSION = '0.04';

extends 'Games::AssaultCube::Log::Line::Base';

with	'Games::AssaultCube::Log::Line::Base::NickIP';

# TODO improve validation for everything here, ha!

has 'text' => (
	isa		=> 'Str',
	is		=> 'ro',
	required	=> 1,
);

has 'isteam' => (
	isa		=> 'Bool',
	is		=> 'ro',
	default		=> 0,
);

has 'spam' => (
	isa		=> 'Bool',
	is		=> 'ro',
	default		=> 0,
);

has 'tostr' => (
	isa		=> 'Str',
	is		=> 'ro',
	lazy		=> 1,
	default		=> sub {
		my $self = shift;
		return $self->nick . " said" . ( $self->isteam ? " to team: " : ": " ) . $self->text;
	},
);

no Moose;
__PACKAGE__->meta->make_immutable;

1;
__END__

=for stopwords isteam ip

=head1 NAME

Games::AssaultCube::Log::Line::Says - Describes the Says event in a log line

=head1 ABSTRACT

Describes the Says event in a log line

=head1 DESCRIPTION

This module holds the "Says" event data from a log line. Normally, you would not use this class directly
but via the L<Games::AssaultCube::Log::Line> class.

This line is emitted when somebody said something in the game.

=head2 Attributes

Those attributes hold information about the event. As this class extends the L<Games::AssaultCube::Log::Line::Base>
class, you can also use it's attributes too.

=head3 nick

The nick of the client who said something

=head3 text

The text of what the client said ( sometimes it's a zero-length string... )

=head3 ip

The ip of the client

=head3 isteam

Boolean signifying if the client said it to the team or the public

=head3 spam

Boolean signifying if the server detected this text as SPAM ( repeated text in N seconds )

=head1 AUTHOR

Apocalypse E<lt>apocal@cpan.orgE<gt>

Props goes to the BS clan for the support!

This project is sponsored by L<http://cubestats.net>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 by Apocalypse

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
