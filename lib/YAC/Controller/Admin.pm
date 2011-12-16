package YAC::Controller::Admin;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

YAC::Controller::Admin - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 auto

Check if there is a user and, if not, forward to login page

=cut

# Note that 'auto' runs after 'begin' but before your actions and that
# 'auto's "chain" (all from application path to most specific class are run)
# See the 'Actions' section of 'Catalyst::Manual::Intro' for more info.
sub auto :Private {
    my ($self, $c) = @_;

    # Allow unauthenticated users to reach the login page.  This
    # allows unauthenticated users to reach any action in the Login
    # controller.  To lock it down to a single action, we could use:
    #   if ($c->action eq $c->controller('Login')->action_for('index'))
    # to only allow unauthenticated access to the 'index' action we
    # added above.
    if ($c->controller eq $c->controller('Login')) {
        return 1;
    }

    # If a user doesn't exist, force login
    if (!$c->user_exists) {
        # Dump a log message to the development server debug output
        $c->log->debug('***Root::auto User not found, forwarding to /login');
        # Redirect the user to the login page
        $c->response->redirect($c->uri_for('/login'));
        # Return 0 to cancel 'post-auto' processing and prevent use of application
        return 0;
    }

    # User found, so return 1 to continue with processing after this 'auto'
    return 1;
}




=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->stash( template => 'admin/index.tt' );
    $c->forward( $c->view('Back') );
}

=head2 list_users


Show a list of all users in this system

=cut


sub list_users: Local {
    my ( $self, $c ) = @_;

    $c->stash(users => [$c->model('YAC::User')->all]);
    $c->stash(template => 'admin/list_users.tt');
    $c->forward( $c->view('Back') );
}

=head2 list_roles


Show a list of all roles

=cut


sub list_roles: Local {
    my ( $self, $c ) = @_;

    $c->stash(roles => [$c->model('YAC::Role')->all]);
    $c->stash(template => 'admin/list_roles.tt');
    $c->forward( $c->view('Back') );
}

=head2 list_content


Show a list of all stacks

=cut


sub list_content: Local {
    my ( $self, $c ) = @_;

    $c->stash(stacks => [$c->model('YAC::Stack')->search(
                { tipo => { like => 'html' } },
                {
                    order_by => 'url ASC',
                   # group_by => [qw/ url/]
                }
        )]);
    $c->stash(template => 'admin/list_content.tt');
    $c->forward( $c->view('Back') );
}


=head2 list_plugins


Show a list of all plugins

=cut


sub list_plugins: Local {
    my ( $self, $c ) = @_;

    #$c->stash(plugins => $c->plugins());
    $c->stash(plugins => {
        'plugin1' => 'plugin1_data',
        'plugin2' => 'plugin2_data'
        });
    $c->stash(template => 'admin/list_plugins.tt');
    $c->forward( $c->view('Back') );
}



=head1 AUTHOR

filipo,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
