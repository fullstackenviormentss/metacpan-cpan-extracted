#
# This file is part of MooseX-TrackDirty-Attributes
#
# This software is Copyright (c) 2011 by Chris Weyl.
#
# This is free software, licensed under:
#
#   The GNU Lesser General Public License, Version 2.1, February 1999
#
package MooseX::TrackDirty::Attributes::Trait::Role;
BEGIN {
  $MooseX::TrackDirty::Attributes::Trait::Role::AUTHORITY = 'cpan:RSRCHBOY';
}
# Dist::Zilla: +PkgVersion
$MooseX::TrackDirty::Attributes::Trait::Role::VERSION = '2.003';
use Moose::Role;
use namespace::autoclean;

use MooseX::TrackDirty::Attributes::Util ':all';

# debugging...
#use Smart::Comments;

# ensure that future applications of a native trait will be handled correctly
after add_role => sub {
    my ($self, $other) = @_;

    ### checking: $self->name
    return unless $self->does_role('Moose::Meta::Attribute::Native::Trait');

    ### applying to self...
    TrackDirtyNativeTrait->meta->apply($self);
    return;
};

around composition_class_roles => sub {
    my ($orig, $self) = (shift, shift);

    ### in our composition_class_roles()...
    return ($self->$orig(@_), Composite);
};

!!42;

__END__

=pod

=encoding UTF-8

=for :stopwords Chris Weyl Ceccarelli Gianni attribute's

=for :stopwords Wishlist flattr flattr'ed gittip gittip'ed

=head1 NAME

MooseX::TrackDirty::Attributes::Trait::Role

=head1 VERSION

This document describes version 2.003 of MooseX::TrackDirty::Attributes::Trait::Role - released December 23, 2014 as part of MooseX-TrackDirty-Attributes.

=head1 SEE ALSO

Please see those modules/websites for more information related to this module.

=over 4

=item *

L<MooseX::TrackDirty::Attributes|MooseX::TrackDirty::Attributes>

=back

=head1 SOURCE

The development version is on github at L<http://https://github.com/RsrchBoy/moosex-trackdirty-attributes>
and may be cloned from L<git://https://github.com/RsrchBoy/moosex-trackdirty-attributes.git>

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/RsrchBoy/moosex-trackdirty-attributes/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Chris Weyl <cweyl@alumni.drew.edu>

=head2 I'm a material boy in a material world

=begin html

<a href="https://www.gittip.com/RsrchBoy/"><img src="https://raw.githubusercontent.com/gittip/www.gittip.com/master/www/assets/%25version/logo.png" /></a>
<a href="http://bit.ly/rsrchboys-wishlist"><img src="http://wps.io/wp-content/uploads/2014/05/amazon_wishlist.resized.png" /></a>
<a href="https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2Fmoosex-trackdirty-attributes&title=RsrchBoy's%20CPAN%20MooseX-TrackDirty-Attributes&tags=%22RsrchBoy's%20MooseX-TrackDirty-Attributes%20in%20the%20CPAN%22"><img src="http://api.flattr.com/button/flattr-badge-large.png" /></a>

=end html

Please note B<I do not expect to be gittip'ed or flattr'ed for this work>,
rather B<it is simply a very pleasant surprise>. I largely create and release
works like this because I need them or I find it enjoyable; however, don't let
that stop you if you feel like it ;)

L<Flattr this|https://flattr.com/submit/auto?user_id=RsrchBoy&url=https%3A%2F%2Fgithub.com%2FRsrchBoy%2Fmoosex-trackdirty-attributes&title=RsrchBoy's%20CPAN%20MooseX-TrackDirty-Attributes&tags=%22RsrchBoy's%20MooseX-TrackDirty-Attributes%20in%20the%20CPAN%22>,
L<gittip me|https://www.gittip.com/RsrchBoy/>, or indulge my
L<Amazon Wishlist|http://bit.ly/rsrchboys-wishlist>...  If you so desire.

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2011 by Chris Weyl.

This is free software, licensed under:

  The GNU Lesser General Public License, Version 2.1, February 1999

=cut
