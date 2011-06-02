package YAC::Controller::Edit;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

YAC::Controller::Edit - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

Implements the edit system for YAC. CUD as is.

At TT YAC implements the AJAX interface around jquery facilities.

=head1 SYNOPSIS
   
One can use the YAC edit interface in AJAX:

   <script>
   url_create, url

=head1 METHODS


=head2 auto

Check if there is a user and, if not, forward to login page

=cut

# Note that 'auto' runs after 'begin' but before your actions and that
# 'auto's "chain" (all from application path to most specific class are run)
# See the 'Actions' section of 'Catalyst::Manual::Intro' for more info.
sub auto : Private {
    my ( $self, $c ) = @_;

    # Allow unauthenticated users to reach the login page.  This
    # allows unauthenticated users to reach any action in the Login
    # controller.  To lock it down to a single action, we could use:
    #   if ($c->action eq $c->controller('Login')->action_for('index'))
    # to only allow unauthenticated access to the 'index' action we
    # added above.
    if ( $c->controller eq $c->controller('Login') ) {
        return 1;
    }

    # If a user doesn't exist, force login
    if ( !$c->user_exists ) {

        # Dump a log message to the development server debug output
        $c->log->debug('***Root::auto User not found, forwarding to /login');

        # Redirect the user to the login page
        $c->response->redirect( $c->uri_for('/login') );

      # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }

    # User found, so return 1 to continue with processing after this 'auto'
    return 1;
}

=head2 index 

If the user is loged in procced with editing interface for url, 
defaults for root.

Else presents the login page.

=cut

sub index : Path : Args(1) {
    my ( $self, $c, $url ) = @_;
    if   ( $url && $url ne "" ) { $c->forward( 'search', $url ) }
    else                        { $c->forward( 'search', 'index' ) }
}

=head2 search 

Private method. Works for this implementation.

Search the url
        * in CMS database
        * ???
presents the result

=cut

sub search : Private {
    my ( $self, $c, $url ) = @_;
    my $result =
      $c->model('YAC::Stack')->search( { id => { 'like' => $url } } );

    if ( $result->next ) {
        my @rs = $c->model('YAC::Stack')->search({ id => { 'like' => $url } });
        $c->stash( stacks => \@rs );
        $c->stash( template => 'admin/edit/index_edit.tt' );
        $c->forward( $c->view('Back') );
    }
    elsif ($url == 0) { 
        # edit a new stack
        my $stack = &default_stack;
        $c->stash( stacks => [$stack] );
        $c->stash( template => 'admin/edit/index_edit.tt' );
        $c->forward( $c->view('Back') );
    }
    else {
        $c->response->body( '<h1>What? :P  ...' 
              . $url
              . ' IDK what\'s it, sorry.</h1><br><a href="/">&lt;-- </a>' );
    }

}

sub editor : Local {
    my ( $self, $c, $url ) = @_;
    my @rs = [];
    my $stack = {};
    if ($url == 0) {  # edit a new stack
        $stack = &default_stack; 
    } else {
        @rs = $c->model('YAC::Stack')->search({ id => { 'like' => $url }});
        $stack = $rs[0];
    }
    $c->stash( stacks   => [$stack] );
    $c->stash( template => 'admin/edit/editor.tt' );
    $c->forward( $c->view('Back') );
}

=head2 create
    
    Create a stack with the supplied tipo, titulo, conteudo, and user
    
=cut

sub create : Local {
    my ( $self, $c, $user_id, $conteudo, $url, $titulo, $tipo ) = @_;
    my $stack = $c->model('YAC::Stack')->create(
        {
            tipo    => $tipo,
            url     => $url,
            titulo  => $titulo,
            content => $conteudo,
        }
    );
    $stack->add_to_stack_users( { user_id => $user_id } );
    $c->stash(
        stack    => $stack,
        template => 'html/create_done.tt'
    );
}


=head2 delete
    
    Deletes a stack with the supplied id
    
=cut

sub delete : Local {
    my ( $self, $c, $id) = @_;
    my $stack_rs = $c->model('YAC::Stack')->find(
            { id  => $id  }
    );
    $stack_rs->delete;
    # Redirect page to list content
    $c->response->redirect( $c->uri_for('/admin/list_content') );
}



sub update : Local {
    my ( $self, $c ) = @_;
    my $action  = $c->request->params->{action};
    my $userId  =  $c->session->{__user}->{id};
    my $stack = {
         content =>  $c->request->params->{content} ,
         titulo  =>  $c->request->params->{titulo}  ,
         tipo    =>  $c->request->params->{tipo}    ,
         url     =>  $c->request->params->{url}      
    };

    # do some dbic update
    my $id  =  $c->request->params->{stack_id};
    if ($id == 0){ 
       # default stack ... create one new on db!!!!
       my $m_stack = $c->model('YAC::Stack')->create($stack);
       $m_stack->add_to_stack_users( { user_id => $userId } );
    } else {
       # update the stack
       my $m_stack =  $c->model('YAC::Stack')->find($id);
       $m_stack->update( $stack);
    }
    # return view to client
    
    $stack->{id} = $id;
    if ($action eq "Cancel"){
       print "Editor Cancelado!!!\n";
        $c->stash(
            stack    => $stack,
            action   => $action,
            template => 'admin/edit/update_done.tt'
        );
    } else {
        $c->stash(
            stack    => $stack,
            action   => $action,
            template => 'admin/edit/update_done.tt'
        );
    }
    $c->forward( $c->view('Back') );
}

sub default_stack {
    my ( $self, $c ) = @_;
    return  {
          id      => 0,
          userId  => $c->session->{__user}->{id},
          tipo    => 'html',
          url     => 'undefined_url',
          titulo   => 'No Title',
          content => 'YAC by Monsenhor',
      };
}


=head1 AUTHOR

filipo,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
