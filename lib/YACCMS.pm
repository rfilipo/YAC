package YACCMS;

=head1 NAME
YACCMS (Yet Another Catalyst CMS)

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
$VERSION = eval $VERSION;


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
A YAC can run or stop.

=cut

sub new {
  my $class = shift;
  my $self = {};
  bless ($self, $class);
}

=head2 run

Run the http daemon at param port
    
    my $port = 80 ;
    $web->run ($port) ;

=cut

sub run {
    system('script/yac_server.pl');
}

=head2 stop

    $web->stop();

Stops the daemon.

=cut

sub stop { 
    print 'Me implemente!';
}



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


=head1 Catalyst app implementation

YAC - Catalyst based application

=head1 SYNOPSIS

    script/yac_server.pl

=head1 DESCRIPTION

The YAC's engine is not so simple but who's care? Go Web!

=head1 SEE ALSO

L<YAC::Controller::Root>, L<Catalyst>


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
