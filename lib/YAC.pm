package YAC;

=head1 NAME
YAC (YACCMS (Yet Another Catalyst CMS))

B<Colofon:>

YAC resembles to Yeast artificial chromosome. Yeah!
Yeast is our mascote colofon.
See L<http://en.wikipedia.org/wiki/Yeast> 

=cut
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    -Debug
    ConfigLoader
    Static::Simple

    StackTrace
    Authentication
    Session
    Session::Store::FastMmap

    Session::State::Cookie
/;

extends 'Catalyst';

=head1 VERSION

Version 0.02

=cut

our $VERSION = '0.02';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in yac.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

__PACKAGE__->config(
    name => 'YAC',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
);

# Configure SimpleDB Authentication
    __PACKAGE__->config->{'Plugin::Authentication'} = {
            default => {
                class           => 'SimpleDB',
                user_model      => 'YAC::User',
                password_type   => 'clear',
            },
        };


# Start the application
__PACKAGE__->setup();

=head1 AUTHOR

Monsenhor, C<< <ricardo.filipo at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-yac at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=YAC>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SYNOPSIS

A realy killer CMS. So simple! So usefull!

    use YACCMS;

    my $web = new YACCMS;
    $web->run();
    # go to web!

=head1 METHODS

=head2 new

Return a new instance off app controler.
You now can run or stop the YAC.

=head2 run

Run the http daemon at param $port. Default to 80.
    
    my $port = 80 ;
    $web->run ($port) ;

=head2 stop

    $web->stop();

Stops the daemon.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc YAC


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=YAC>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/YAC>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/YAC>

=item * Search CPAN

L<http://search.cpan.org/dist/YAC/>

=back


=head1 YAC 

=head2 Catalyst app implementation

YAC - Catalyst based application

=head1 SYNOPSIS

    script/yac_server.pl

=head1 DESCRIPTION

=head2 Control Structure

YAC can instance one of this 4 machines when run the YAC:

    . Play
    . Edit
    . Admin
    . Hack

Each machine can be used at specific role and rigths.

To complement and perform that machines are the Ws and Plugin controls.

=over 4

=item * Play machine

The default run is always the Play machine or Root control. Here the user can view media content and access basic navigational menus. 

=item * Edit machine

A logged user with editorial rigths can access the Edit machine and change their work.

Edit machine presents the media content to edit. 
The default editor is pure text. 
Other media editor like html, widgets, code, image, animation, xml, svg, json and so on can be added by plugin hooks.

The menu is same as Play machine plus personal menus and editor menus. The adicional interface will be the personal data editor and menus editor. This new editors will be integrated in the same interface.


=item * Admin machine

If the user is logged with admin rigths he can access the Admin machine.

Admin machine presents interfaces for edit and administer users, their data and work. 
Brings CMS's administration tasks like startup and shutdown the server or enable/disable some plugins. 

YAC uses a file to store all users and stacks: the Container. It's a sqlite3 file and can be exchanged, uploaded, downloaded or merged among instances of the YAC at different sites.

The menu is same as Edit machine plus users and admin menus.

=item * Hack machine

With hacker rigths the user can access the Hack machine.

Hack machine presents interfaces to plugins, Catalyst hooks and some core helpers. Permit CMS's design and building tasks like create widgets, features or develop a new plugin. 

The menu is same as Edit machine plus users and admin menus.

=back

=head2 Model Structure

=over 4

=item * Stack

The content handler. The only must in YAC.

One can create cool stacks!! 

The core implemented stacks are: Content, Control and Widget.


=over 4 


=item Control

A menu manager  

=item Content

Handles html content.

=item Widget

Handles js code content.


=back


=item * Auth

The authentication class handle users, rules and rights.

=item * User

The user handler.

=item * Layout

The Layout objects are viewer Catalyst templates at database storage.

=item * Plugin

Plugins are Catalyst Plugins handlers.

=back

=head2 Core Plugins

=over 4

=item *

Media Player

=item *

Image slide and carroussel

=item *

Dialogs and some jqueryUI things

=item *

fkceditor

=item *

jsLinb visual editor 

=back 


=head1 SEE ALSO

L<YAC::Controller::Root>, L<YAC::Controller::Edit>,  L<YAC::Controller::Admin>,  L<YAC::Controller::Hack>,  L<YAC::Controller::Plugin>,  L<YAC::Controller::WS>, L<Catalyst>


=head1 ACKNOWLEDGEMENTS

=head2 Benefits to the Perl Community

A CMS (Content Management System) can be a web tool used in some internet business to help and administer media publication. As a market lider let's consider B<Drupal>, a php based CMS, reference product used by everywere, a key tool in Obama's USA president campaign. The B<Drupal>'s grow in users (designers and coders) and contributed addons bring up to community a lot of php programmer's work and all market demmand for their code. 

The media produced by CMS needs to integrate with other system like CRMs and ERPs or other enterprise legacy. The CMS's oportunity to programmers became from integration tools like a plugin system and addon facilities. It's the B<Drupal>'s case. That minimalistic simplicity is the strongest value. Programmers can hook systems in the CMS and final users can plug in at the website instantly.

The secret: The designer (or anybody) can do functional web without the coder. A CMS needs a simple and clear user interface. But the core integration to other systems where the coder works need to be simple too. Final result: Productivity.

In the Java, Python, Ruby or Asp world we will find similar tools like Typo, OpenCms, Django and Plone. Some simple, others powefull. 

At perl tools we consider MovableType. Our work will not compete directly with MovableType as it integrates in Catalyst's control level as our implementation and plugin basis. The YAC's paradigma differ in our simplicity and minimalistic goal. Will be ok to one begin in YAC and integrates MovableType anytime.

The Catalyst Project need a extensible, basic CMS Design Pattern with the eyes in the final user and the hooks that a programmer can play. A CMS more simple than B<Drupal> and with the power of B<CPAN> and B<Catalyst>.

We will consider cpan tools like Reaction, Mojo and Dancer. 

=head3 Biblio

L<http://en.wikipedia.org/wiki/Content_management_system>
L<http://en.wikipedia.org/wiki/List_of_content_management_systems>
L<http://www.movabletype.org>
L<http://search.cpan.org/~okko/Catalyst-Controller-MovableType-0.003/>
L<http://en.wikipedia.org/wiki/OpenCms>
L<http://en.wikipedia.org/wiki/Drupal>
L<http://en.wikipedia.org/wiki/Plone_(software)>
L<http://en.wikipedia.org/wiki/Typo_(software)>
L<http://search.cpan.org/dist/Reaction/>
L<http://search.cpan.org/dist/Mojolicious/>
L<http://search.cpan.org/dist/Dancer/>

=head2 Deliverables

* A so basic CMS Design Pattern on Catalyst with some helpers, tools and simple layout.

* Ajax user interface to some Catalyst core functions.

* CPAN module as the first implementation.


=head2 Project Details

YAC will be a basic CMS Design Pattern with a simple user interface.
No need to learn perl to play the YAC but a monger will play so well.

A CMS needs, at least, to create, edit and publish content and to link that content as web address (urls) to navigation or command menus and links. A good addon is a theme manager. The access to the CMS and this features need to be defined at Access Control List. 
The stronguest feature in the UI will be a simple plugin system integrated at cpan level.  

The idea, as the first implementation, will be an extensible and basic ajax structure around jquery from Catalyst. Consider Catalyst::View::Component::jQuery. 

As simple as an CMS can be, YAC will implement a simple user interface around Catalyst helpers, open hooks and plugins. This open design will encourage YAC's contributions grow.

The most important pattern to be done will be an open user interface paradigma.  The idea about web interfaces can't neglect Ajax and the HTML 5 protocol.

=head3 Features

=over 2

=item *

Media Player

=item *

Image slide and carroussel

=item *

Dialogs and some jqueryUI things

=item *

Access Control List Auth

=item *

HTML WYSIWYG content editor

=item *

Acces to Catalyst and Plugins hooks at WYSIWYG content editor level

=item *

Image, media and file upload at WYSIWYG content editor level

=item *

Virtual file manager at WYSIWYG content editor level

=item *

Plugin System, Catalyst compatible

=item *

Hooks to some Catalyst helpers: create View, create Model, create Control


=back





=head1 LICENSE AND COPYRIGHT

Copyright 2010 Monsenhor.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of YAC
