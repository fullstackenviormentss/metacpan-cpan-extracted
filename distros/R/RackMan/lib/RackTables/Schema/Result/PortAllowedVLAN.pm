package RackTables::Schema::Result::PortAllowedVLAN;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';


=head1 NAME

RackTables::Schema::Result::PortAllowedVLAN

=cut

__PACKAGE__->table("PortAllowedVLAN");

=head1 ACCESSORS

=head2 object_id

  data_type: 'integer'
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=head2 port_name

  data_type: 'char'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 vlan_id

  data_type: 'integer'
  default_value: 0
  extra: {unsigned => 1}
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "object_id",
  {
    data_type => "integer",
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
  "port_name",
  { data_type => "char", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "vlan_id",
  {
    data_type => "integer",
    default_value => 0,
    extra => { unsigned => 1 },
    is_foreign_key => 1,
    is_nullable => 0,
  },
);
__PACKAGE__->set_primary_key("object_id", "port_name", "vlan_id");

=head1 RELATIONS

=head2 port_vlanmode

Type: belongs_to

Related object: L<RackTables::Schema::Result::PortVLANMode>

=cut

__PACKAGE__->belongs_to(
  "port_vlanmode",
  "RackTables::Schema::Result::PortVLANMode",
  { object_id => "object_id", port_name => "port_name" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 vlan

Type: belongs_to

Related object: L<RackTables::Schema::Result::VLANValidID>

=cut

__PACKAGE__->belongs_to(
  "vlan",
  "RackTables::Schema::Result::VLANValidID",
  { vlan_id => "vlan_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 port_native_vlan

Type: might_have

Related object: L<RackTables::Schema::Result::PortNativeVLAN>

=cut

__PACKAGE__->might_have(
  "port_native_vlan",
  "RackTables::Schema::Result::PortNativeVLAN",
  {
    "foreign.object_id" => "self.object_id",
    "foreign.port_name" => "self.port_name",
    "foreign.vlan_id"   => "self.vlan_id",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07010 @ 2011-10-26 11:34:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:a2VeoFvO6BkdoDYqKmjG4Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
