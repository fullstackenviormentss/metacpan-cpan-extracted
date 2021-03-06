# WWWTheme.pm - perl source for HTML::WWWTheme
# 
# Copyright (C) 2000 Chad Hogan <chogan@uvastro.phys.uvic.ca>
# Copyright (C) 2000 Joint Astronomy Centre
#
# All rights reserved.
# 
# This file is part of HTML::WWWTheme
# 
#
# HTML::WWWTheme is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by the
# Free Software Foundation; either version 2, or (at your option) any
# later version.
#
# HTML::WWWTheme is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with HTML::WWWTheme; see the file gpl.txt.  If not, write to the Free
# Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

package HTML::WWWTheme;

use strict;
use Carp;

use vars qw($VERSION);

$VERSION = '1.06';

# You're going to notice that $self->{"link"} is in quotation marks.
# that's because I get an ambiguity error if I use it.  So, I made
# some changes that will remove the error.  No big deal.

sub new {
  my $that = shift;
  my $type = ref($that) || $that;
  my $self = {
	      nextlink          => "",
              lastlink          => "",
              uplink            => "",

	      topbottomlinks    => [],

	      bgcolor           => "#FFFFFF",
	      bgpicture         => "",
	      alink             => "",
	      "link"            => "",     
              text              => "",
              vlink             => "",

	      sidebarcolor      => "#FFFFFF",
	      blankgif          => "/WWW/images/blank.gif",
              infolinks         => [],
              sidebartop        => "<A HREF=\"http://www.nowhere.com/\">Nowhere</a>",
              sidebarmenutitle  => "My Divisions",
              sidebarsearchbox  => "0", 
              sidebarmenulinks  => [],
	      sidebarwidth      => "150",
              shortwidth        => "120",
	      nosidebarextras   => "",
	      morelinkstitle    => "More links",
	      usenavbar         => "", 
	      configfile        => "", 
	      startstring       => "<HTML><HEAD><TITLE>Nothing</TITLE></HEAD>",
	      endstring         => "</HTML>",
	      searchtemplate    => "",
	      printablename     => "",

	     }; 
  my $config; 
  
  if (@_)
    {
      GetConfiguration($self, @_) || carp "configuration failed! probably bad files." && return 0;
    }
  
  bless $self, $type;
  return $self;
}

##############################################################################
#
# This subroutine will make the header that will wrap around the top of the page.
# Valid HTML should go between this and the end of the page, but *without* a 
# <BODY> tag, because we've already got one.
#
##############################################################################

sub MakeHeader
  {

   my $self = shift;

   my $bodystring = "<BODY ";         # first we'll create a body tag with the appropriate stuff in it.
   $self->{bgcolor}   && ( $bodystring .= "BGCOLOR=\"$self->{bgcolor}\" " );
   $self->{bgpicture} && ( $bodystring .= "BACKGROUND=\"$self->{bgpicture}\" " );
   $self->{alink}     && ( $bodystring .= "ALINK=\"$self->{alink}\" " );
   $self->{"link"}    && ( $bodystring .= "LINK=\"" . $self->{"link"} . "\" ");
   $self->{text}      && ( $bodystring .= "TEXT=\"$self->{text}\" ");
   $self->{vlink}     && ( $bodystring .= "VLINK=\"$self->{vlink}\" ");
   $bodystring .= ">";

   # now we'll create the meat of the header piece.
   # you'll notice the appropriate additions here and there, 
   # including the $bodystring that we just made.

    my $navbar =
q{
<!-- HTML GENERATED BY HTML::WWWTheme
***********************************************************
Copyright (C) 2000 Chad Hogan <chogan@uvastro.phys.uvic.ca>
Copyright (C) 2000 Joint Astronomy Centre
All Rights Reserved.
HTML::WWWTheme is free software, licensed under the GNU General
Public License as published by the Free Software Foundation.  Please
see the source code for details.
-->

} . $bodystring . q{
    <table cellpadding="0" cellspacing="0" border="0">
      <!--This is the main row of stuff-->
      <tr valign="top">
	<TD bgcolor="} . $self->{sidebarcolor} . q{">
	  <TABLE cellspacing="0" cellpadding="0">
	<!--a gutter for the left side-->
	<TD width="3">
	  <IMG SRC="} . $self->{blankgif} . q{" alt="" width="3" height="1">
	</TD>
	<!--end of the gutter-->
	
	<!--beginning of the sidebar element-->
	<TD width="} . $self->{sidebarwidth} . q{">
	  <IMG SRC="} . $self->{blankgif} . q{" alt="" width="1" height="1" vspace="5"><BR>
	  <B><A NAME="top"></a>} . $self->{sidebartop} . q{</B><BR>
	  <HR> 
	  
	  <!--a spacer-->
	  <IMG SRC="} . $self->{blankgif} . q{" alt="" width="1" height="1" vspace="17"><BR>
	  
	  <B>}. $self->{sidebarmenutitle} .q{</B><BR><HR>
	  
	  <TABLE CELLSPACING="0" CELLPADDING="0">
	    <TR>
	      <TD WIDTH="5"><IMG SRC="} . $self->{blankgif} . q{" ALT="" WIDTH="5" HEIGHT="1" VSPACE="3"></TD>
	      <TD WIDTH="} . $self->{shortwidth} . q{">
		<FONT SIZE="-1" FACE="TIMES NEW ROMAN, TIMES ROMAN, TIMES, SERIF">
		  <IMG SRC="} . $self->{blankgif} . q{" ALT="" WIDTH="} . $self->{shortwidth} . 
                     q{" HEIGHT="1" VSPACE="3"><BR>} . MakeSideBarMenuLinks($self) . q{
		</FONT>
	      </TD>
	    </TR>
	  </TABLE>};
 
   # now, unless we've set the "nosidebarextras" bit, we'll add in the other pieces of the sidebar.
   # including "more links" and the search bar.
 
   unless ($self->{nosidebarextras})
     {
       $navbar .= q{<!--a spacer-->
	  <IMG SRC="} . $self->{blankgif} . q{" alt="" width="1" height="1" vspace="17"><BR>
          <B>} . $self->{morelinkstitle} . q{</B><BR>
          <HR>
      	  <TABLE CELLSPACING="0" CELLPADDING="0">
	    <TR>
	      <TD WIDTH="5"><IMG SRC="} . $self->{blankgif} . q{" ALT="" WIDTH="5" HEIGHT="1" VSPACE="3">
              </TD>
	      <TD WIDTH="} . $self->{shortwidth} . q{">
		<FONT SIZE="-1" FACE="TIMES NEW ROMAN, TIMES ROMAN, TIMES, SERIF">} . 
		  join ("<IMG SRC=\"" . $self->{blankgif} . "\" ALT=\"\" WIDTH=\"" . 
                        $self->{shortwidth} . "\" HEIGHT=\"1\" VSPACE=\"3\"><BR>" , @{$self->{infolinks}}) 
              . q{<BR>
		  
		</FONT>
	      </TD>
	    </TR>
	  </TABLE>

	   <!--a spacer-->
	  <IMG SRC="} . $self->{blankgif} . q{" alt="" width="1" height="1" vspace="17"><BR>} .
	    MakeSearchBox($self);
     }  # end of the conditional addition of the sidebar extras!  yeah, I know, it's a mess.

   # Now we have to close everything off nicely.  This part must be added in every case.

   $navbar .= q{
        </TD>
       </TABLE>
      </TD>
       <!--That was the end of the sidebar element-->
	  <TD>
	    <TABLE background="" Cellspacing="0" cellpadding="0">
	      <TD WIDTH="25">
		<!-- This is just for space between the sidebar and the main body -->
		<IMG SRC="} . $self->{blankgif} . q{" alt="" width="25" height="1">
	      </TD>
		      
	      <!-- Now we make a table element for the real text!-->
	     <TD>

	       <!-- END OF GENERATED HTML
		 **********************************************************  
		   -->};  # end of the $navbar string

    return $navbar;


}


##############################################################################
#
# this subroutine creates the searching box at the side.  It's called from
# MakeHeader. If you want to use Isearch, you must download it from 
# http://www.cnidr.org/ir/isearch.html  (though there are zillions of 
# good search engines out there)


sub MakeSearchBox
  {
    my $self = shift;
    return "" unless $self->{sidebarsearchbox};
    return $self->{searchtemplate};
  }

#############################################################################
# 
# here we make all the sidebar menu links.  We call this routine from the
# MakeHeader subroutine.
#

sub MakeSideBarMenuLinks
  {
    my $self = shift;
    return '' unless (@{$self->{sidebarmenulinks}});
    my $menu =  shift @{$self->{sidebarmenulinks}};
    foreach my $link (@{$self->{sidebarmenulinks}})
      {
	$menu .= "<BR><IMG SRC=\"".$self->{blankgif}."\" ALT=\"\" WIDTH=\"1\" HEIGHT=\"1\" VSPACE=\"2\"><BR>";
	$menu .= $link;
      }
    
    $menu .= "<BR><IMG SRC=\"".$self->{blankgif}."\" ALT=\"\" WIDTH=\"1\" HEIGHT=\"1\" VSPACE=\"2\"><BR>";
    return $menu;
  }

#############################################################################
#
# This creates the top and bottom nav bars, if they're used.
# Again, this is called from the MakeHeader

sub MakeNavBar
  {
    my $self = shift;
    my $navthingy = "<CENTER><HR><NOBR>\n";
    $navthingy .= "<B>Previous:</B>$self->{lastlink}\n" if ($self->{lastlink});
    $navthingy .= "<B>Up:</B>$self->{uplink}\n"         if ($self->{uplink});
    $navthingy .= "<B>Next:</B>$self->{nextlink}\n"     if ($self->{nextlink});
    $navthingy .= "</NOBR><HR></CENTER>";
    return $navthingy;
  }

##############################################################################
#
# This creates the navigation bar to be found at the top and bottom of the 
# page.  It's usually called directly (eg. Apache::SetWWWTheme calls it directly)

sub MakeTopBottomBar
  {
    my $self = shift;
    return '' unless (@{$self->{topbottomlinks}});
    my $bar = "<!-- Beginning of top/bottom bar -->\n<CENTER>";
    foreach my $link (@{$self->{topbottomlinks}})
      {
	$bar .= "$link<BR>";
      }
    $bar .= "</CENTER>\n<!-- End of top/bottom bar -->";
    return $bar;
  }

##############################################################################
#
# This footer must always be used, since it closes off all the table stuff
# that we created in the MakeHeader.  It really doesn't do much else, except
# it throws in the "return to top...." bit.  
#

sub MakeFooter
  {
    my $self = shift;
    my $endbody;
    $endbody  = "</TD></TABLE></TD></TR></TABLE>";
    $endbody .= '<DIV ALIGN="left"><H6><A HREF=' . $self->{printablename};
    $endbody .= ">click here for a printable version...</A></H6></DIV>";
    $endbody .= '<DIV ALIGN="right"><H6><A HREF="#top">return to top...</A></H6></DIV>';
    $endbody .= "</BODY>";
    
    return $endbody;
  }
    


##############################################################################
#
# This allows us to read everything from a file, if so desired.  This way
# you can drop configs into a file, and then just edit the file instead of
# changing source code for any cgis that call this module.
#

sub GetConfiguration
  {
    my $self = shift;
    while (@_)
      {
	$self->{configfile} = shift;

	open (CONFIG, $self->{configfile}) || carp "couldn't open server config $self->{configfile}" && return 0;
	local $/ = "";
	
	while (<CONFIG>)
	  {
	    ( /\@BLANKGIF\s*=\s*(.*?);/s )           && ($self->{blankgif}         = $1);
	    ( /\@NAVBAR\s*=\s*(.*?);/s )             && ($self->{usenavbar}        = $1);
	    ( /\@NEXTLINK\s*?=\s*?(.*?);/s )         && ($self->{nextlink}         = $1);
	    ( /\@LASTLINK\s*?=\s*?(.*?);/s )         && ($self->{lastlink}         = $1);
	    ( /\@UPLINK\s*?=\s*?(.*?);/s )           && ($self->{uplink}           = $1);
	    
	    ( /\@BGCOLOR\s*=\s*(.*?);/s )            && ($self->{bgcolor}          = $1);
	    ( /\@BGPICTURE\s*=\s*(.*?);/s )          && ($self->{bgpicture}        = $1);
	    ( /\@BACKGROUND\s*=\s*(.*?);/s )         && ($self->{bgpicture}        = $1);	  
	    ( /\@ALINK\s*=\s*(.*?);/s )              && ($self->{alink}            = $1);
	    ( /\@LINK\s*=\s*(.*?);/s )               && ($self->{"link"}           = $1);
            ( /\@TEXT\s*=\s*(.*?);/s )               && ($self->{text}             = $1);
            ( /\@VLINK\s*=\s*(.*?);/s )              && ($self->{vlink}            = $1);
	    
	    ( /\@SIDEBARTOP\s*?=\s*?(.*?);/s )       && ($self->{sidebartop}       = $1);
	    ( /\@SIDEBARMENUTITLE\s*?=\s*?(.*?);/s ) && ($self->{sidebarmenutitle} = $1);
	    ( /\@MORELINKSTITLE\s*?=\s*?(.*?);/s )   && ($self->{morelinkstitle}   = $1);
	    ( /\@SEARCHTEMPLATE\s*?=\s*?(.*?);/s )   && ($self->{searchtemplate}   = $1);
	    ( /\@SIDEBARSEARCHBOX\s*?=\s*?(.*?);/s ) && ($self->{sidebarsearchbox} = $1);
	    ( /\@SIDEBARCOLOR\s*?=\s*?(.*?);/s )     && ($self->{sidebarcolor}     = $1);
	    ( /\@SIDEBARWIDTH\s*?=\s*?(.*?);/s )     && ($self->{sidebarwidth}     = $1);

	    ( /\@NOSIDEBAREXTRAS\s*?=\s*?(.*?);/s)   && ($self->{nosidebarextras}  = $1);

	    my (@links, @sides);
	    ( /\@INFO\s*?=\s*?(.*?);/s )             && (@links = split(',',$1)) && ($self->{infolinks} = \@links);	   
	    ( /\@SIDEBARMENULINKS\s*?=\s*?(.*?);/s ) && (@sides = split(',',$1)) && ($self->{sidebarmenulinks} = \@sides);
	  }
      }
    close CONFIG;
    return 1;
  } #GetConfiguration
		      
##############################
# all of my mutator methods.

sub SetSearchTemplate
  {
    my $self = shift;
    $self->{searchtemplate} = shift if (@_);
    return $self->{blankgif};
  }

sub SetBlankGif
  {
    my $self = shift;
    $self->{blankgif} = shift if (@_);
    return $self->{blankgif};
  }

sub SetNextLink
  {
    my $self = shift;
    $self->{nextlink} = shift if (@_);
    return $self->{nextlink};
  }

sub SetLastLink
  {
    my $self = shift;
    $self->{lastlink} = shift if (@_);
    return $self->{lastlink};
  }

sub SetPrintableName
  {
    my $self = shift;
    $self->{printablename} = shift if (@_);
    return $self->{printablename};
  }

sub SetUpLink
  {
    my $self = shift;
    $self->{uplink} = shift if (@_);
    return $self->{uplink};
  }

sub SetBGColor
  {
    my $self = shift;
    $self->{bgcolor} = shift if (@_);
    return $self->{bgcolor};
  }

sub SetBGPicture
  {
    my $self = shift;
    $self->{bgpicture} = shift if (@_);
    return $self->{bgpicture}
  }

sub SetALink
  {
    my $self = shift;
    $self->{alink} = shift if (@_);
    return $self->{alink};
  }

sub SetLink
  {
    my $self = shift;
    $self->{link} = shift if (@_);
    return $self->{link};
  }

sub SetVLink
  {
    my $self = shift;
    $self->{vlink} = shift if (@_);
    return $self->{vlink};
  }

sub SetMoreLinksTitle
  {
    my $self = shift;
    $self->{morelinkstitle} = shift if (@_);
    return $self->{morelinkstitle};
  }

sub SetSideBarTop
  {
    my $self = shift;
    $self->{sidebartop} = shift if (@_);
    return $self->{vlink};
  }

sub SetSideBarMenuTitle
  {
    my $self = shift;
    $self->{sidebarmenutitle} = shift if (@_);
    return $self->{sidebarmenutitle};
  }

sub SetSideBarSearchBox
  {
    my $self = shift;
    $self->{sidebarsearchbox} = shift if (@_);
    return $self->{sidebarsearchbox};
  }

sub SetSideBarColor
  {
    my $self = shift;
    $self->{sidebarcolor} = shift if (@_);
    return $self->{sidebarcolor};
  }

sub SetSideBarWidth
  {
    my $self = shift;
    $self->{sidebarwidth} = shift if (@_);
    $self->{shortwidth} = $self->{sidebarwidth} - 30;
    ($self->{shortwidth} < 0) && ($self->{shortwidth} = 0); 
    return $self->{sidebarwidth};
  }

sub SetNoSideBarExtras
  {
    my $self = shift;
    $self->{nosidebarextras} = shift if (@_);
    return $self->{nosidebarextras};
  }


sub SetInfoLinks
  {
    my $self = shift;
    $self->{infolinks} = shift if (@_);
    return $self->{infolinks};
  }

sub SetSideBarMenuLinks
  {
    my $self = shift;
    $self->{sidebarmenulinks} = shift if (@_);
    return $self->{sidebarmenulinks};
  }

sub SetTopBottomLinks
  {
    my $self = shift;
    $self->{topbottomlinks} = shift if (@_);
    return $self->{topbottomlinks};
  }

sub SetUseNavBar
  {
    my $self = shift;
    $self->{usenavbar} = shift if (@_);
    return $self->{usenavbar};
  }

sub SetHTMLStartString
  {
    my $self = shift;
    $self->{startstring} = shift if (@_);
    return $self->{startstring};
  }

sub SetHTMLEndString
  {
    my $self = shift;
    $self->{endstring} = shift if (@_);
    return $self->{endstring};
  }

sub SetText
  {
    my $self = shift;
    $self->{text} = shift if (@_);
    return $self->{text};
  }

sub StartHTML
  {
    my $self = shift;
    return $self->{startstring};
  }

sub EndHTML
  {
    my $self = shift;
    return $self->{endstring};
  }



1;


# bah.  A pox on pod.

=head1 NAME

HTML::WWWTheme - Standard theme generation, including sidebars and navigation bars

=head1 SYNOPSIS

 use HTML::WWWTheme;
 my $Theme = new HTML::WWWTheme(@args);

=head1 REQUIREMENTS

Nothing special -- Perl 5 or newer.

=head1 DESCRIPTION

HTML::WWWTheme is a module that creates a standard sidebar and implements local colour conventions.  
It is used by the Apache::SetWWWTheme module to enforce this through the server.  In fact, 
the code in this module was originally contained within the SetWWWTheme module, but at the
suggestion of Tim Jenness, I separated this module to allow CGI programs to create standard
pages that would fit in with the static pages that are automatically rewritten by the Apache
module.  So, static pages in the web tree are filtered through Apache::SetWWWTheme, and
CGI-generated pages are generated with the help of HTML::WWWTheme.  In this manner, a consistent
look and feel can be maintained in all pages.  Any changes in the structure of WWWTheme are
automatically reflected in both the CGI-generated and static pages.

The new() function will return a reference to a Theme object.  It will accept an
array of arbitrary length as arguments.  Each element of this array must be a fully 
qualified path to a configuration file.  

Configuration is accomplished in three ways.  First, one may pass arguments to the
new() function.  These arguments must be fully qualified paths to a configuration file.
The syntax of the directives in this file is simple:  

 @DIRECTIVE=value;
  
for example,

 @BGCOLOR=#FFFFFF;

or, in the case of a directive that accepts a list, the values are comma-separated and 
semi-colon terminated.  Escaped semi-colons will be transformed into semi-colons, and
will not terminate the directive.

 @DIRECTIVE=value1, value2, value3;

 @DIRECTIVE=value1, value2\; still going, value3;

In the second example, the value2\; will be replaced with value2; in the parsed text.

for example,

 @INFO=<A HREF="here.html">Here</a>, <A HREF="there.html">There</a>;

Second, the GetConfiguration() function may be passed a list of full-paths to configuration 
files.  The GetConfiguration() function will parse these files and set the appropriate values.

Finally, one may use methods to directly change the settings of the page before it is
produced.  This is the recommended method, because it is the most intuitive and the
easiest to figure out when you're trying to figure out someone else's code.  I use these
methods extensively in my Apache::SetWWWTheme module.  

=head2 METHODS

The following are all the methods that may be used to control the behaviour of the
module.

=over 4

=item GetConfiguration()

This method takes the names of configuration files as arguments, and parses them one
by one.  The configuration files contain a series of directives of the form

 @DIRECTIVE=value;

or, in the case of a list-value (for example, with the infolinks that make up the
links on the sidebar under "More Links" or "More Info")

 @DIRECTIVE=value1, value2, value3;

Valid directives are listed, along with the corresponding method that performs
the same method:

 @BLANKGIF          (see SetBlankGif() )
 @NAVBAR            (see SetUseNavBar() )
 @NEXTLINK          (see SetNextLink() )
 @LASTLINK          (see SetLastLink() )
 @UPLINK            (see SetUpLink() )
 @BGCOLOR           (see SetBGColor() )
 @BGPICTURE         (see SetBGPicture() )
 @BACKGROUND        (see SetBGPicture() )
 @ALINK             (see SetALink() )
 @LINK              (see SetLink() )
 @VLINK             (see SetVLink() )
 @SIDEBARTOP        (see SetSideBarTop() )
 @SIDEBARMENUTITLE  (see SetSidebarMenuTitle() )
 @SIDEBARSEARCHBOX  (see SetSideBarSearchBox() )
 @SIDEBARCOLOR      (see SetSideBarColor() )
 @SIDEBARWIDTH      (see SetSideBarWidth() )
 @NOSIDEBAREXTRAS   (see SetNoSideBarExtras() )
 @MORELINKSTITLE    (see SetMoreLinksTitle() )
 @INFO              (see SetInfoLinks() )
 @SIDEBARMENULINKS  (see SetSideBarMenuLinks() )

=item MakeFooter()

Returns a footer to end the document.  Should be the last part of a dynamically
generated HTML page.  See the example.

=item MakeHeader()

Returns the header to the page.  Should be the first part of a dynamically 
generated HTML page.  See the example.

=item MakeNavBar()

Returns a "previous/up/next" navigation bar.  This bar is designed to be
sandwiched between the Header and the main body, and then later on between
the end of the main body and the Footer.  See the example.

=item SetNextLink()

Sets the "Next" link on the top/bottom nav bars.  Valid entries must be in the form
of an HTML link,

 $Theme->SetNextLink('<A HREF="http://somewhere.com">somewhere</a>');

=item SetLastLink()

Sets the "Last" or "Previous" link on the top/bottom nav bars.  Valid entries must be
in the form of an HTML link,

 $Theme->SetLastLink('<A HREF="http://here.com">here</a>');

=item SetUpLink()

Sets the "Up" link on the top/bottom nav bars.  Valid entries must be in the form of an 
HTML link, 

 $Theme->SetUpLink('<A HREF="http://there.com">there</a>');

=item SetBGColor()

Sets the background color for the page generated.  Valid entries must be in the form of
a hex color code,

 $Theme->SetBGColor("#CCFFFF");

=item SetBGPicture()

Sets the background image for the page generated.  Valid entries must be in the form of
an absolute URL or URI.

 $Theme->SetBGPicture("/WWW/images/wallpaper.gif");

=item SetALink(), SetLink(), SetVLink()

Sets the [a|v]link color for the E<lt>BODYE<gt> tag.  Valid entries must be in the form of
a hex color code.

 $Theme->SetALink("#FFCCFF");
 $Theme->SetVLink("#FFCCFF");
 $Theme->SetLink ("#FFCCFF");

=item SetMoreLinksTitle()

Sets the "More links" title on the sidebar.  By default it says "More
links", but you may want to change it something else.

 $Theme->SetMoreLinksTitle("More useful links");

=item SetNoSideBarExtras()

If this is true, it turns off the sidebar extras -- those parts of the 
sidebar that aren't in the "SidebarMenuLinks" bit.

 $Theme->SetNoSideBarExtras("1");

=item SetHTMLStartString()

Sets the HTML starting string.  This string should include the <HTML> opening tag,
the <HEAD></HEAD> tags (and anything inbetween).  Essentially, it should contain 
everything before the <BODY> tag.  If you are using this module for a CGI program,
you should probably include the usual Content-Type: text/html sort of thing.  

 $Theme->SetHTMLStartString("<HTML><HEAD><TITLE>This is my page.</TITLE></HEAD>");

=item SetHTMLEndString()

Sets the HTML ending string.  This string should contain everything after the
</BODY> tag, including such things as </HTML>.

 $Theme->SetHTMLEndString("</HTML>");

=item SetPrintableName()

Sets the URL that is used to produce a printable version of the
page.  This is used to generate the small "click here to produce a printable
version" link on the themed page.  How this is implemented is left to the caller.
Apache::SetWWWTheme produces an un-themed page, with all the link tags stripped
out to discourage people from browsing in the printable pages and thus subverting
the theming.

 $Theme->SetPrintableName("/printable/path/to/file.html");

=item SetText()

Sets the text color for the E<lt>BODYE<gt> tag.  Valid entries must be in the form of
a hex color code.

 $Theme->SetText("#000000");

=item SetSideBarColor()

Sets the color of the generated sidebar.  Valid entries must be in the form of a hex
color code.  

 $Theme->SetSideBarColor("#FFCCFF");

=item SetSideBarWidth()

Sets the width of the sidebar in pixels.  The default is 150.

 $Theme->SetSideBarWidth("120");

=item SetBlankGif()

Sets the location of the blank gif.  A blank gif (blank.gif) is included in the distribution
of this package.  Valid entries must be in the form of a URL or URI pointing to this file.

 $Theme->SetBlankGif("/WWW/images/blank.gif");

=item SetInfoLinks()

Sets the value of the "info links".  Info links are designed to be user-configurable and
fall under the "More Links" or "More information" section of the sidebar.  Valid entries must
be in the form of a reference to an array of valid links.

 @array = ('<a href="here.html">here</a>', '<a href="there.html">there</a>');
 $Theme->SetInfoLinks(\@array);

=item SetSideBarTop()

Sets the name appearing at the top of the sidebar.  This may be a link, if desired. Valid
entries are strings.

 $Theme->SetSideBarTop('<A HREF="/">My Webserver</a>');

=item SetSearchTemplate()

Sets the template to insert into the HTML for the side searchbox.  It should be self-contained
HTML with the appropriate form methods etc. to interface with your local search engine.  Here 
is an example of a template:

 <B>Search JAC</B><BR><HR>
 <DIV align="center">
 <form method="POST" action="/cgi-bin/isearch">
 <input name="SEARCH_TYPE" type=hidden  value="ADVANCED">
 <input name="HTTP_PATH" type=hidden value="/WWW"> 
 <input name="DATABASE" type=hidden value="webindex">
 <input name="FIELD_1" type=hidden value="FULLTEXT">
 <input name="WEIGHT_1" type=hidden value= "1">
 <input name="ELEMENT_SET" type=hidden value="TITLE">
 <input name="MAXHITS" type=hidden value="50">
 <input name="ISEARCH_TERM" size="14" border="0">
 </form>
 </DIV>
 <H6><a href="http://www.yoursite.edu/search.html">More searching....</a></h6>

Your template must be customized as appropriate for your engine, of course.  This template
should be passed to the SetSearchTemplate function as one big string.  

=item SetSideBarMenuLinks()

Sets the value of the main sidebar links.  Valid entries must be in the form of a reference
to an array of valid links.

 @array = ('<a href="here.html">here</a>', '<a href="there.html">there</a>');
 $Theme->SetSideBarMenuLinks(\@array);

=item SetSideBarMenuTitle()

Sets the name of the main sidebar links.  Valid entries must be in the form of a string,

 $Theme->SetSideBarMenuTitle("Main Sections");

=item SetSideBarSearchBox()

Sets the state of the sidebar searchbox.  If this value is set to anything true (in the perl sense),
the searchbox will appear on the sidebar.

 $Theme->SetSideBarSearchBox("1");

=item SetUseNavBar()

Sets the state of the top/bottom navbars.  If this value is set to anything true (in the perl sense),
the top/bottom navbars will be place on the page.  These navbars will be created with
the values set in the Set__Link() methods.  

 $Theme->SetUseNavBar("1");

=item SetTopBottomLinks()

Sets the links used in the top/bottom link bars.  It takes an array reference as data.

 @array = ('<a href="here.html">here</a>', '<a href="there.html">there</a>');
 $Theme->SetTopBottomLinks(\@array);

=item StartHTML()

Returns the contents of the string set in SetHTMLStartString.  This is mostly just a placeholder
for some time in the future when I get around to fully implementing this module to mimic the
abilities of some other well-known modules.  

 print $Theme->StartHTML();

=item EndHTML()

Returns the contents of the string set in SetHTMLEndString.  This is mostly just a placeholder
for some time in the future when I get around to fully implementing this module to mimic the
abilities of some other well-known modules.  

 print $Theme->EndHTML();

The MakeNavBar() function may be used to create the top/bottom navigation bar.  This bar contains
the previous/up/next links.  It takes no arguments, but uses the [next|last|up]link keys in the hash.  

Finally, the MakeFooter() function is used to end the html file.  This function is absolutely necessary, as 
the page won't render without it!  The tables will not be finished, and very few browswers can deal with this.

Here is a simple but functional example.  Notice that there are no E<lt>BODYE<gt> tags.  The header and 
footer take care of this.  Write your HTML as if you were writing between the E<lt>BODYE<gt> and 
E<lt>/BODYE<gt> tags.:

 #!/usr/bin/perl -w

 use strict;
 use HTML::WWWTheme;

 # read in a few defaults
 my $Theme = new HTML::WWWTheme("/WWW/LookAndFeel", "/home/chogan/Lookandfeel");

 # set a few things by hand
 $Theme->SetBlankGif("/WWW/images/blank.gif");
 $Theme->SetBGColor("#FFFFFF");
 $Theme->SetHTMLStartString("<HTML><HEAD><TITLE>My Example.</TITLE></HEAD>");
 $Theme->SetHTMLEndString("</HTML>");

 # make the header, navbar, body, navbar, footer.  
 print $Theme->StartHTML();
 print $Theme->MakeHeader();
 print $Theme->MakeTopBottomBar();
 print $Theme->MakeNavBar();
 print "This is the body of my file.  Isn't it groovy?";
 print $Theme->MakeNavBar();
 print $Theme->MakeTopBottomBar();
 print $Theme->MakeFooter();
 print $Theme->EndHTML();
 exit 0;

=head1 SEE ALSO

L<Apache::SetWWWTheme>

=head1 AUTHOR

Copyright (C) 2000 Chad Hogan (chogan@uvastro.phys.uvic.ca).  
Copyright (C) 2000 Joint Astronomy Centre

All rights reserved.  HTML::WWWTheme is free software;
you can redistribute it and/or modify it under the terms of the GNU General Public
License as published by the Free Software Foundation; either version 2 or
(at your option) any later version.

HTML::WWWTheme is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
details.  

You should have received a copy of the GNU General Public License along
with HTML::WWWTheme; see the file gpl.txt.  If not, write to the Free
Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
