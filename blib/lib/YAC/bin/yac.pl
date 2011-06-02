#!/usr/bin/perl 
#===============================================================================
#
#         FILE:  yac.pl
#
#        USAGE:  ./yac.pl  
#
#  DESCRIPTION:  /usr/bin/perl yac.pl
#
#      OPTIONS:  ---
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  Ricardo Filipo (rf), ricardo.filipo@mitologica.com.br
#      COMPANY:  Mito-Lógica design e soluções de comunicação ltda
#      VERSION:  1.0
#      CREATED:  30-07-2010 23:48:21
#     REVISION:  
#===============================================================================

use strict;
use warnings;
use lib 'lib';
use YACCMS;

my $web = new YACCMS;
$web->run();
# go web!

#system('links2 http://127.0.0.1:3000');
