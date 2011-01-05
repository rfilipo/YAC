package YAC::Schema::Result::StackUser;

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

YAC::Schema::Result::StackUser

=cut

__PACKAGE__->table("stack_user");

=head1 ACCESSORS

=head2 stack_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "stack_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("stack_id", "user_id");

=head1 RELATIONS

=head2 user

Type: belongs_to

Related object: L<YAC::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "YAC::Schema::Result::User",
  { id => "user_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-24 21:43:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hAiXDQPDxCUCW85d+pqlcg


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
