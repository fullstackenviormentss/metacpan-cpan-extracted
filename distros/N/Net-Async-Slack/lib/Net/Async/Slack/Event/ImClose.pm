package Net::Async::Slack::Event::ImClose;

use strict;
use warnings;

our $VERSION = '0.002'; # VERSION

use Net::Async::Slack::EventType;

=head1 NAME

Net::Async::Slack::Event::ImClose - You closed a DM

=head1 DESCRIPTION

Example input data:

    im:read

=cut

sub type { 'im_close' }

1;

