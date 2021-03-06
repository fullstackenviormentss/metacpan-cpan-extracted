# NEVER EDIT this file.  It was generated and will be overwritten without
# notice upon regeneration of this application.  You have been warned.
package Apps::Checkbook::GEN::SchTbl;

use strict;
use warnings;

use base 'Apps::Checkbook';
use JSON;
use Gantry::Utils::TablePerms;

use Apps::Checkbook::Model::sch_tbl qw(
    $SCH_TBL
);

#-----------------------------------------------------------------
# $self->form( $row )
#-----------------------------------------------------------------
sub form {
    my ( $self, $row ) = @_;

    my $selections = $SCH_TBL->get_form_selections();

    return {
        row        => $row,
        fields     => [
            {
                name => 'name',
                is => 'varchar',
            },
        ],
    };
} # END form

1;

=head1 NAME

Apps::Checkbook::GEN::SchTbl - generated support module for Apps::Checkbook::SchTbl

=head1 SYNOPSIS

In Apps::Checkbook::SchTbl:

    use base 'Apps::Checkbook::GEN::SchTbl';

=head1 DESCRIPTION

This module was generated by bigtop and IS subject to regeneration.
Use it in Apps::Checkbook::SchTbl to provide the methods below.
Feel free to override them.

=head1 METHODS

=over 4

=item form


=back

=head1 AUTHOR

Generated by bigtop and subject to regeneration.

=cut

