package YAC::Controller::Edit;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

YAC::Controller::Edit - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index 

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched YAC::Controller::Edit in Edit.');
}


=head2 url_create
    
    Create a stack with the supplied tipo, titulo, conteudo, and user
    
=cut

sub url_create :Local {
    # In addition to self & context, get the title, rating, &
    # author_id args from the URL.  Note that Catalyst automatically
    # puts extra information after the "/<controller_name>/<action_name/"
    # into @_.  The args are separated  by the '/' char on the URL.
    my ($self, $c, $tipo, $titulo, $conteudo, $user_id) = @_;

    # Call create() on the stack model object. Pass the table
    # columns/field values we want to set as hash values
    my $stack = $c->model('YAC::Stack')->create({
            tipo     =>  $tipo                , 
            titulo   =>  $titulo              , 
            url   =>  $titulo              , 
            conteudo =>  $conteudo            , 
            user_id  =>  $user_id
    });

    # Add a record to the join table for this stack, mapping to
    # appropriate author
    $stack->add_to_substacks({user_id => $user_id});
    # Note: Above is a shortcut for this:
    # $stack->create_related('stack_authors', {author_id => $author_id});

    # Assign the Stack object to the stash for display and set template
    $c->stash(stack     => $stack,
              template => 'src/stackscreate_done.tt');
}

=head1 AUTHOR

filipo,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
