package YAC::Schema::Result::Substack;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use namespace::autoclean;
extends 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

YAC::Schema::Result::Substack

=cut

__PACKAGE__->table("substack");

=head1 ACCESSORS

=head2 stack_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stack_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id", "stack_id");

=head1 RELATIONS

=head2 id

Type: belongs_to

Related object: L<YAC::Schema::Result::Stack>

=cut

__PACKAGE__->belongs_to(
  "id",
  "YAC::Schema::Result::Stack",
  { id => "id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 stack

Type: belongs_to

Related object: L<YAC::Schema::Result::Stack>

=cut

__PACKAGE__->belongs_to(
  "stack",
  "YAC::Schema::Result::Stack",
  { id => "stack_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2011-01-22 20:40:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ELU02zVSRlk1TdufXN1Yzw


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
