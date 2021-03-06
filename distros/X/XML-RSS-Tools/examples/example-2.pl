#!/usr/bin/perl

#   $Id: example-2.pl 56 2008-06-23 16:54:31Z adam $

=head1 NAME

Example-2 - A Longer example

=head2 Example 2

This more complex example is designed to show a normal command line or CGI
application. After loading the normal modules, and unbuffering STDOUT, the URI
of the site, and the style sheet are grabbed from the command line (if present),
and the rss and cgi objects are created. Checking the request method to determine
if the application is running in CGI or command line mode, a HTML header is sent
if appropriate and then the application checks for required inputs.

Assuming the pre-requisites have all been met, then the rss object is loaded
with the source rss, xsl Template, and the transformation is performed. If at
any stage an error is detected, all calls return rss method calls return true
on success, an error message is generated, and sent to the user.

=cut

#
#	Example 2 for XML::RSS::Tools
#

use strict;
use warnings;
use CGI;
use CGI::Carp;
use XML::RSS::Tools;
$|++;
my $site  = shift || '';
my $style = shift || '';
my $q        = CGI->new;
my $rss      = XML::RSS::Tools->new;
my $path_xsl = "./";
undef $q unless $q->request_method();

if ($q) {
    $site  = $q->param("site")  if $q->param("site");
    $style = $q->param("style") if $q->param("style");
    print $q->header, $q->start_html( -title => "RSS News Feed" );
    tad( "Usage: newsfeed.pl?site=foo;style=bar\n", $q )
        unless $site && $style;
}
else {
    tad("Usage: newsfeed.pl (<RSS File> | <URI>) <XSLT stylesheet>\n")
        unless $site && $style;
}
$style = $path_xsl . $style;
if ( !$rss->xsl_file($style) ) { tad( $rss->as_string('error'), $q ) }
if ( $site =~ /^http/i ) {
    if ( !$rss->rss_uri($site) ) { tad( $rss->as_string('error'), $q ) }
}
else {
    if ( !$rss->rss_file($site) ) { tad( $rss->as_string('error'), $q ) }
}
if ( $rss->transform ) {
    print $rss->as_string;
}
else {
    tad( $rss->as_string('error'), $q );
}
exit;

#
#	Called after script ends.
#
END {
    %ENV = ();
    printf "\n<!-- Transformation complete in %d seconds. -->\n", time - $^T;
    print $q->end_html if $q;
}

#
#	Gracefully die, Terminate and Die
#
sub tad {
    my $error = shift || "Unknown Error";
    my $q = shift;
    if ($q) {
        print $q->hr, $q->h1("RSS 2 HTML via XSLT error:"), $q->h2($error),
            $q->hr;
        croak $error;
    }
    else {
        print "RSS 2 HTML via XSLT error:\n\t$error";
        exit;
    }
}
