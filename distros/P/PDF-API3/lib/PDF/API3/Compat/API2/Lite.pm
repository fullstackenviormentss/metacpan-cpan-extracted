#=======================================================================
#    ____  ____  _____              _    ____ ___   ____
#   |  _ \|  _ \|  ___|  _   _     / \  |  _ \_ _| |___ \
#   | |_) | | | | |_    (_) (_)   / _ \ | |_) | |    __) |
#   |  __/| |_| |  _|    _   _   / ___ \|  __/| |   / __/
#   |_|   |____/|_|     (_) (_) /_/   \_\_|  |___| |_____|
#
#   A Perl Module Chain to faciliate the Creation and Modification
#   of High-Quality "Portable Document Format (PDF)" Files.
#
#   Copyright 1999-2005 Alfred Reibenschuh <areibens@cpan.org>.
#
#=======================================================================
#
#   This library is free software; you can redistribute it and/or
#   modify it under the terms of the GNU Lesser General Public
#   License as published by the Free Software Foundation; either
#   version 2 of the License, or (at your option) any later version.
#
#   This library is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   Lesser General Public License for more details.
#
#   You should have received a copy of the GNU Lesser General Public
#   License along with this library; if not, write to the
#   Free Software Foundation, Inc., 59 Temple Place - Suite 330,
#   Boston, MA 02111-1307, USA.
#
#   $Id: Lite.pm,v 2.1 2007/05/08 18:32:09 areibens Exp $
#
#=======================================================================

package PDF::API3::Compat::API2::Lite;

BEGIN {

    use PDF::API3::Compat::API2;
    use PDF::API3::Compat::API2::Util;
    use PDF::API3::Compat::API2::Basic::PDF::Utils;

    use POSIX qw( ceil floor );

    use vars qw( $VERSION $hasWeakRef );

    ( $VERSION ) = sprintf '%i.%03i', split(/\./,('$Revision: 2.1 $' =~ /Revision: (\S+)\s/)[0]); # $Date: 2007/05/08 18:32:09 $

}

no warnings qw[ deprecated recursion uninitialized ];


=head1 NAME 

PDF::API3::Compat::API2::Lite - lite pdf creation

=head1 SYNOPSIS

    $pdf = PDF::API3::Compat::API2::Lite->new;
    $pdf->page(595,842);
    $img = $pdf->image('some.jpg');
    $font = $pdf->corefont('Times-Roman');
    $font = $pdf->ttfont('TimesNewRoman.ttf');

=head1 METHODS

=head2 PDF::API3::Compat::API2::Lite

=item $pdf = PDF::API::Lite->new

=cut

sub new {
    my $class=shift(@_);
    my %opt=@_;
    my $self={};
    bless($self,$class);
    $self->{api}=PDF::API3::Compat::API2->new(@_);
    return $self;
}

=item $pdf->page

=item $pdf->page $width,$height

=item $pdf->page $llx, $lly, $urx, $ury

Opens a new page.

=cut

sub page {
    my $self=shift;
    $self->{page}=$self->{api}->page;
    $self->{page}->mediabox(@_) if($_[0]);
    $self->{gfx}=$self->{page}->gfx;
#   $self->{gfx}->compressFlate;
    return $self;
}


=item $pdf->mediabox $w, $h

=item $pdf->mediabox $llx, $lly, $urx, $ury

Sets the global mediabox.

=cut

sub mediabox {
    my ($self,$x1,$y1,$x2,$y2) = @_;
    if(defined $x2) {
        $self->{api}->mediabox($x1,$y1,$x2,$y2);
    } else {
        $self->{api}->mediabox($x1,$y1);
    }
    $self;
}

=item $pdf->saveas $file

Saves the document (may not be modified later) and
deallocates the pdf-structures.

=cut

sub saveas {
    my ($self,$file)=@_;
    if($file eq '-') {
        return $self->{api}->stringify;
    } else {
        $self->{api}->saveas($file);
        return $self;
    }
    $self->{api}->end;
    foreach my $k (keys %{$self}) {
        if(UNIVERSAL::can($k,'release')) {
            $k->release(1);
        } elsif(UNIVERSAL::can($k,'end')) {
            $k->end;
        }
        $self->{$k}=undef;
        delete($self->{$k});
    }
    return undef;
}


=item $font = $pdf->corefont $fontname

Returns a new or existing adobe core font object.

B<Examples:>

    $font = $pdf->corefont('Times-Roman');
    $font = $pdf->corefont('Times-Bold');
    $font = $pdf->corefont('Helvetica');
    $font = $pdf->corefont('ZapfDingbats');

=cut

sub corefont {
    my ($self,$name,@opts)=@_;
    my $obj=$self->{api}->corefont($name,@opts);
    return $obj;
}

=item $font = $pdf->ttfont $ttfile

Returns a new or existing truetype font object.

B<Examples:>

    $font = $pdf->ttfont('TimesNewRoman.ttf');
    $font = $pdf->ttfont('/fonts/Univers-Bold.ttf');
    $font = $pdf->ttfont('../Democratica-SmallCaps.ttf');

=cut

sub ttfont {
    my ($self,$file,@opts)=@_;
    return $self->{api}->ttfont($file,@opts);
}

=item $font = $pdf->psfont $pfb, $afm, $encoding

Returns a new type1 font object.

B<Examples:>

    $font = $pdf->psfont('TimesRoman.pfb','TimesRoman.afm','latin1');
    $font = $pdf->psfont('/fonts/Univers.pfb','/fonts/Univers.afm','latin2');

=cut

sub psfont {
    my ($self,@args)=@_;
    return $self->{api}->psfont(@args);
}

#=item @color = $pdf->color $colornumber [, $lightdark ]
#
#=item @color = $pdf->color $basecolor [, $lightdark ]
#
#Returns a color.
#
#B<Examples:>
#
#    @color = $pdf->color(0);        # 50% grey
#    @color = $pdf->color(0,+4);     # 10% grey
#    @color = $pdf->color(0,-3);     # 80% grey
#    @color = $pdf->color('yellow');     # yellow, fully saturated
#    @color = $pdf->color('red',+1);     # red, +10% white
#    @color = $pdf->color('green',-2);   # green, +20% black
#
#=cut
#
#sub color {
#    my $self=shift @_;
#    return $self->{api}->businesscolor(@_);
#}

=item $egs = $pdf->create_egs

Returns a new extended-graphics-state object.

B<Examples:>

    $egs = $pdf->create_egs;

=cut

sub create_egs {
    my ($self)=@_;
    return $self->{api}->extgstate;
}

=item $img = $pdf->image_jpeg $file

Returns a new jpeg-image object.

=cut

sub image_jpeg {
    my ($self,$file)=@_;
    return $self->{api}->image_jpeg($file);
}

=item $img = $pdf->image_png $file

Returns a new png-image object.

=cut

sub image_png {
    my ($self,$file)=@_;
    return $self->{api}->image_png($file);
}

=item $img = $pdf->image_tiff $file

Returns a new tiff-image object.

=cut

sub image_tiff {
    my ($self,$file)=@_;
    return $self->{api}->image_tiff($file);
}

=item $img = $pdf->image_pnm $file

Returns a new pnm-image object.

=cut

sub image_pnm {
    my ($self,$file)=@_;
    return $self->{api}->image_pnm($file);
}

=item $pdf->savestate

Saves the state of the page.

=cut

sub savestate {
    my $self=shift @_;
    $self->{gfx}->save;
}

=item $pdf->restorestate

Restores the state of the page.

=cut

sub restorestate {
    my $self=shift @_;
    $self->{gfx}->restore;
}

=item $pdf->egstate $egs

Sets extended-graphics-state.

=cut

sub egstate {
    my $self=shift @_;
    $self->{gfx}->egstate(@_);
    return($self);
}

=item $pdf->fillcolor $color

Sets fillcolor.

=cut

sub fillcolor {
    my $self=shift @_;
    $self->{gfx}->fillcolor(@_);
    return($self);
}

=item $pdf->strokecolor $color

Sets strokecolor.

B<Defined color-names are:>

    aliceblue, antiquewhite, aqua, aquamarine, azure, beige, bisque, black, blanchedalmond,
    blue, blueviolet, brown, burlywood, cadetblue, chartreuse, chocolate, coral, cornflowerblue,
    cornsilk, crimson, cyan, darkblue, darkcyan, darkgoldenrod, darkgray, darkgreen, darkgrey,
    darkkhaki, darkmagenta, darkolivegreen, darkorange, darkorchid, darkred, darksalmon,
    darkseagreen, darkslateblue, darkslategray, darkslategrey, darkturquoise, darkviolet,
    deeppink, deepskyblue, dimgray, dimgrey, dodgerblue, firebrick, floralwhite, forestgreen,
    fuchsia, gainsboro, ghostwhite, gold, goldenrod, gray, grey, green, greenyellow, honeydew,
    hotpink, indianred, indigo, ivory, khaki, lavender, lavenderblush, lawngreen, lemonchiffon,
    lightblue, lightcoral, lightcyan, lightgoldenrodyellow, lightgray, lightgreen, lightgrey,
    lightpink, lightsalmon, lightseagreen, lightskyblue, lightslategray, lightslategrey,
    lightsteelblue, lightyellow, lime, limegreen, linen, magenta, maroon, mediumaquamarine,
    mediumblue, mediumorchid, mediumpurple, mediumseagreen, mediumslateblue, mediumspringgreen,
    mediumturquoise, mediumvioletred, midnightblue, mintcream, mistyrose, moccasin, navajowhite,
    navy, oldlace, olive, olivedrab, orange, orangered, orchid, palegoldenrod, palegreen,
    paleturquoise, palevioletred, papayawhip, peachpuff, peru, pink, plum, powderblue, purple,
    red, rosybrown, royalblue, saddlebrown, salmon, sandybrown, seagreen, seashell, sienna,
    silver, skyblue, slateblue, slategray, slategrey, snow, springgreen, steelblue, tan, teal,
    thistle, tomato, turquoise, violet, wheat, white, whitesmoke, yellow, yellowgreen

or the rgb-hex-notation:

    #rgb, #rrggbb, #rrrgggbbb and #rrrrggggbbbb

or the cmyk-hex-notation:

    %cmyk, %ccmmyykk, %cccmmmyyykkk and %ccccmmmmyyyykkkk

or the hsl-hex-notation:

    &hsl, &hhssll, &hhhssslll and &hhhhssssllll

and additionally the hsv-hex-notation:

    !hsv, !hhssvv, !hhhsssvvv and !hhhhssssvvvv

=cut

sub strokecolor {
    my $self=shift @_;
    $self->{gfx}->strokecolor(@_);
    return($self);
}

=item $pdf->linedash @dash

Sets linedash.

=cut

sub linedash {
    my ($self,@a)=@_;
    $self->{gfx}->linedash(@a);
    return($self);
}

=item $pdf->linewidth $width

Sets linewidth.

=cut

sub linewidth {
    my ($self,$linewidth)=@_;
    $self->{gfx}->linewidth($linewidth);
    return($self);
}

=item $pdf->transform %opts

Sets transformations (eg. translate, rotate, scale, skew) in pdf-canonical order.

B<Example:>

    $pdf->transform(
        -translate => [$x,$y],
        -rotate    => $rot,
        -scale     => [$sx,$sy],
        -skew      => [$sa,$sb],
    )

=cut

sub transform {
    my ($self,%opt)=@_;
    $self->{gfx}->transform(%opt);
    return($self);
}

=item $pdf->move $x, $y

=cut

sub move { # x,y ...
    my $self=shift @_;
    $self->{gfx}->move(@_);
    return($self);
}

=item $pdf->line $x, $y

=cut

sub line { # x,y ...
    my $self=shift @_;
    $self->{gfx}->line(@_);
    return($self);
}

=item $pdf->curve $x1, $y1, $x2, $y2, $x3, $y3

=cut

sub curve { # x1,y1,x2,y2,x3,y3 ...
    my $self=shift @_;
    $self->{gfx}->curve(@_);
    return($self);
}

=item $pdf->arc $x, $y, $a, $b, $alfa, $beta, $move

=cut

sub arc { # x,y,a,b,alf,bet[,mov]
    my $self=shift @_;
    $self->{gfx}->arc(@_);
    return($self);
}

=item $pdf->ellipse $x, $y, $a, $b

=cut

sub ellipse {
    my $self=shift @_;
    $self->{gfx}->ellipse(@_);
    return($self);
}

=item $pdf->circle $x, $y, $r

=cut

sub circle {
    my $self=shift @_;
    $self->{gfx}->circle(@_);
    return($self);
}

=item $pdf->rect $x,$y, $w,$h

=cut

sub rect { # x,y,w,h ...
    my $self=shift @_;
    $self->{gfx}->rect(@_);
    return($self);
}

=item $pdf->rectxy $x1,$y1, $x2,$y2

=cut

sub rectxy {
    my $self=shift @_;
    $self->{gfx}->rectxy(@_);
    return($self);
}

=item $pdf->poly $x1,$y1, ..., $xn,$yn

=cut

sub poly {
    my $self=shift @_;
    $self->{gfx}->poly(@_);
    return($self);
}

=item $pdf->close

=cut

sub close {
    my $self=shift @_;
    $self->{gfx}->close;
    return($self);
}

=item $pdf->stroke

=cut

sub stroke {
    my $self=shift @_;
    $self->{gfx}->stroke;
    return($self);
}

=item $pdf->fill

=cut

sub fill { # nonzero
    my $self=shift @_;
    $self->{gfx}->fill;
    return($self);
}

=item $pdf->fillstroke

=cut

sub fillstroke { # nonzero
    my $self=shift @_;
    $self->{gfx}->fillstroke;
    return($self);
}

=item $pdf->image $imgobj, $x,$y, $w,$h

=item $pdf->image $imgobj, $x,$y, $scale

=item $pdf->image $imgobj, $x,$y

B<Please Note:> The width/height or scale given
is in user-space coordinates which is subject to
transformations which may have been specified beforehand.

Per default this has a 72dpi resolution, so if you want an
image to have a 150 or 300dpi resolution, you should specify
a scale of 72/150 (or 72/300) or adjust width/height accordingly.

=cut

sub image {
    my $self=shift @_;
    $self->{gfx}->image(@_);
    return($self);
}

=item $pdf->textstart

=cut

sub textstart {
    my $self=shift @_;
    $self->{gfx}->textstart;
    return($self);
}

=item $pdf->textfont $fontobj,$size

=cut

sub textfont {
    my $self=shift @_;
    $self->{gfx}->font(@_);
    return($self);
}

=item $txt->textlead $leading

=cut

sub textlead {
    my $self=shift @_;
    $self->{gfx}->lead(@_);
    return($self);
}

=item $pdf->text $string

Applys the given text.

=cut

sub text {
    my $self=shift @_;
    return $self->{gfx}->text(@_)||$self;
}

=item $pdf->nl

=cut

sub nl {
    my $self=shift @_;
    $self->{gfx}->nl;
    return($self);
}

=item $pdf->textend

=cut

sub textend {
    my $self=shift @_;
    $self->{gfx}->textend;
    return($self);
}

=item $pdf->print $font, $size, $x, $y, $rot, $just, $text

Convenience wrapper for shortening the textstart..textend sequence.

=cut

sub print {
    my $self=shift @_;
    my ($font, $size, $x, $y, $rot, $just, @text)=@_;
    my $text=join(' ',@text);
    $self->textstart;
    $self->textfont($font, $size);
    $self->transform(
        -translate=>[$x, $y],
        -rotate=> $rot,
    );
    if($just==1) {
        $self->{gfx}->text_center($text);
    } elsif($just==2) {
        $self->{gfx}->text_right($text);
    } else {
        $self->text(@text);
    }
    $self->textend;
    return($self);
}

1;

__END__

=head1 AUTHOR

alfred reibenschuh

=head1 HISTORY

    $Log: Lite.pm,v $
    Revision 2.1  2007/05/08 18:32:09  areibens
    renamed compress to compressFlate

    Revision 2.0  2005/11/16 02:16:00  areibens
    revision workaround for SF cvs import not to screw up CPAN

    Revision 1.2  2005/11/16 01:27:48  areibens
    genesis2

    Revision 1.1  2005/11/16 01:19:24  areibens
    genesis

    Revision 1.12  2005/06/17 19:43:47  fredo
    fixed CPAN modulefile versioning (again)

    Revision 1.11  2005/06/17 18:53:33  fredo
    fixed CPAN modulefile versioning (dislikes cvs)

    Revision 1.10  2005/03/14 22:01:05  fredo
    upd 2005

    Revision 1.9  2005/02/28 18:00:06  fredo
    removed color method since businesscolor is not available anymore in PDF::API3::Compat::API2

    Revision 1.8  2004/12/16 00:30:51  fredo
    added no warn for recursion

    Revision 1.7  2004/06/15 09:11:38  fredo
    removed cr+lf

    Revision 1.6  2004/06/07 19:44:12  fredo
    cleaned out cr+lf for lf

    Revision 1.5  2004/05/21 15:04:43  fredo
    fixed NAME pod bug for cpan indexer

    Revision 1.4  2003/12/08 13:05:19  Administrator
    corrected to proper licencing statement

    Revision 1.3  2003/11/30 17:11:55  Administrator
    merged into default

    Revision 1.2.2.1  2003/11/30 16:56:21  Administrator
    merged into default

    Revision 1.2  2003/11/30 11:32:56  Administrator
    added CVS id/log


=cut


