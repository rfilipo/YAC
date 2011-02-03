package YAC::Schema::Result::Stack;

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

YAC::Schema::Result::Stack

=cut

__PACKAGE__->table("stack");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 tipo

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 titulo

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 content

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "tipo",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "titulo",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "content",
  { data_type => "text", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 stack_stack_stack2s

Type: has_many

Related object: L<YAC::Schema::Result::StackStack>

=cut

__PACKAGE__->has_many(
  "stack_stack_stack2s",
  "YAC::Schema::Result::StackStack",
  { "foreign.stack2_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stack_stack_stack1s

Type: has_many

Related object: L<YAC::Schema::Result::StackStack>

=cut

__PACKAGE__->has_many(
  "stack_stack_stack1s",
  "YAC::Schema::Result::StackStack",
  { "foreign.stack1_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 substacks

Type: has_many

Related object: L<YAC::Schema::Result::Substack>

=cut

__PACKAGE__->has_many(
  "substacks",
  "YAC::Schema::Result::Substack",
  { "foreign.id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 substacks_stack

Type: has_many

Related object: L<YAC::Schema::Result::Substack>

=cut

__PACKAGE__->has_many(
  "substacks_stack",
  "YAC::Schema::Result::Substack",
  { "foreign.stack_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 stack_users

Type: has_many

Related object: L<YAC::Schema::Result::StackUser>

=cut

__PACKAGE__->has_many(
  "stack_users",
  "YAC::Schema::Result::StackUser",
  { "foreign.stack_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2011-01-22 20:40:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8JLXKg6og3E2Ck+ajGdUjA


# You can replace this text with custom content, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
