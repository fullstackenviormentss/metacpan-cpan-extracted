# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };
use NCAR;
ok(1); # If we made it this far, we're ok.;

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.
unlink( 'gmeta' );

use PDL;
use NCAR::Test;
use strict;
   
&NCAR::gopks( 6, 1 );
&NCAR::gopwk( 1, 2, 1 );
&NCAR::gacwk( 1 );

my $ID=50;
my $XM1 = zeroes float, $ID;
my $YM1 = zeroes float, $ID;
my $XM2 = zeroes float, $ID;
my $YM2 = zeroes float, $ID;
my $XM3 = zeroes float, $ID;
my $YM3 = zeroes float, $ID;
#
#  Define colors.
#
&NCAR::gscr(1,0, 1.0, 1.0, 1.0);
&NCAR::gscr(1,1, 0.0, 0.0, 0.0);
&NCAR::gscr(1,2, 1.0, 0.0, 0.0);
&NCAR::gscr(1,3, 0.0, 0.0, 1.0);
&NCAR::gscr(1,4, 0.0, 1.0, 0.0);
&NCAR::gscr(1,5, 0.4, 0.0, 0.4);
&NCAR::gscr(1,6, 1.0, 0.0, 0.0);
#
#  Marker 1, dot (fill a large circular dot with markers of type 1).
#
#
#   Position and radius of the dot outline.
#
my $X0 = .5;
my $Y0 = .7;
my $R  = .08;
my $JL = 17;
my $AINC = $R/$JL;
&NCAR::gsmk(1);
my ( $X, $Y, $XE );
for my $J ( 0 .. $JL ) {
  $Y = $Y0+$J*$AINC;
  $XE = $X0+sqrt(max($R*$R-($Y-$Y0)*($Y-$Y0),0.));
#
#   Fill the circle with dot markers using symmetries.
#	
&NCAR::gpm(1,float( [ $X ] ), float( [ $Y ] ) );
&NCAR::gspmci(1);
&NCAR::gpm(1,float( [ $X ] ),float( [ 2*$Y0-$Y ] ));
&NCAR::gpm(1,float( [ 2*$X0-$X ] ),float( [ 2*$Y0-$Y ] ));
&NCAR::gpm(1,float( [ 2*$X0-$X ] ),float( [ $Y ] ));

$X = $X+$AINC;

if( $X > $XE ) { next; }

}
#
#   Label the dot.
#
&NCAR::pcseti( 'FN', 21 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq($X0,$Y0+$R+.05,'Marker 1 (dot)',.022,0.,0.);
#
#  Marker 2, plus (make a plus from the plus markers.)
#
#
#   Center of big plus.
#
$X0 = .83;
$Y0 = .5;
$R  = .1;
$JL = 7;
$AINC = $R/$JL;

for my $J ( -$JL .. $JL ) {
  my $Y = $Y0+$J*$AINC;
  my $IDX = $J+$JL+1;
  set( $XM1, $IDX - 1, $X0 );
  set( $YM1, $IDX - 1, $Y );
  my $X = $X0+$J*$AINC;
  set( $XM2, $IDX - 1, $X );
  set( $YM2, $IDX - 1, $Y0 );
  
}
&NCAR::gsmk(2);
&NCAR::gspmci(3);
#
#  Put plus markers along the two axes of the big plus.
#
&NCAR::gpm(2*$JL+1,$XM1,$YM1);
&NCAR::gpm(2*$JL+1,$XM2,$YM2);
#
#   Label the big plus.
#
&NCAR::pcseti( 'FN', 21 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq($X0,$Y0+$R+.05,'Marker 2 (plus)',.022,0.,0.);
#
#  Marker 3, asterisk (make an asterisk from the asterisk markers.)
#
$X0 = .7;
$Y0 = .15;
$R  = .1;
$JL = 5;
$AINC = $R/$JL;
for my $J ( -$JL .. $JL ) {
  my $Y = $Y0+$J*$AINC;
  my $IDX = $J+$JL+1;
  set( $XM1, $IDX - 1, $X0 );
  set( $YM1, $IDX - 1, $Y );
  my $P = 0.5*sqrt(2.)*($Y-$Y0);
  if( $Y >= 0 ) {
     set( $XM2, $IDX - 1, $X0+$P );
     set( $YM2, $IDX - 1, $Y0+$P );
     set( $XM3, $IDX - 1, $X0-$P );
     set( $YM3, $IDX - 1, $Y0+$P );
  } else {
     set( $XM2, $IDX - 1, $X0-$P );
     set( $YM2, $IDX - 1, $Y0-$P );
     set( $XM3, $IDX - 1, $X0+$P );
     set( $YM3, $IDX - 1, $Y0-$P );
  }
}
&NCAR::gsmk(3);
&NCAR::gspmci(4);
#
# Put asterisk markers along the axes of the big asterisk.;
#
&NCAR::gpm(2*$JL+1,$XM1,$YM1);
&NCAR::gpm(2*$JL+1,$XM2,$YM2);
&NCAR::gpm(2*$JL+1,$XM3,$YM3);
#
#   Label the big asterisk.
#
&NCAR::pcseti( 'FN', 21 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq($X0,$Y0+$R+.05,'Marker 3 (asterisk)',.022,0.,0.);
#
#  Marker 4, circle (make a big circle from the circle markers.)
#
$X0 = .3;
$Y0 = .15;
$R  = .1;
$JL = 50;
my $RADINC = 2.*3.1415926/$JL;

for my $J ( 1 .. $JL ) {
  my $X = $X0+$R*cos($J*$RADINC);
  my $Y = $Y0+$R*sin($J*$RADINC);
  set( $XM1, $J - 1, $X );
  set( $YM1, $J - 1, $Y );
}
&NCAR::gsmk(4);
&NCAR::gspmci(1);
&NCAR::gpm($JL,$XM1,$YM1);
#
#   Label the big circle.
#
&NCAR::pcseti( 'FN', 21 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq($X0,$Y0+$R+.05,'Marker 4 (circle)',.022,0.,0.);
#
#  Marker 5, cross (make a big cross from the cross markers.)
#
$X0 = .17;
$Y0 = .5;
$R  = .1;
$JL = 5;
$AINC = $R/$JL;
for my $J ( -$JL .. $JL ) {
  my $Y = $Y0+$J*$AINC;
  my $IDX = $J+$JL+1;
  my $P = 0.5*sqrt(2.)*($Y-$Y0);
  if( $Y >= 0 ) {
    set( $XM2, $IDX - 1, $X0+$P );
    set( $YM2, $IDX - 1, $Y0+$P );
    set( $XM3, $IDX - 1, $X0-$P );
    set( $YM3, $IDX - 1, $Y0+$P );
  } else {
    set( $XM2, $IDX - 1, $X0-$P );
    set( $YM2, $IDX - 1, $Y0-$P );
    set( $XM3, $IDX - 1, $X0+$P );
    set( $YM3, $IDX - 1, $Y0-$P );  
  }
}
&NCAR::gsmk(5);
&NCAR::gspmci(6);
#
#  Plot cross markers along the axes of the big cross.
#
&NCAR::gpm(2*$JL+1,$XM2,$YM2);
&NCAR::gpm(2*$JL+1,$XM3,$YM3);
#
#   Label the big cross.
#
&NCAR::pcseti( 'FN', 21 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq($X0,$Y0+$R+.05,'Marker 5 (cross)',.022,0.,0.);
#
#  Draw a big circle in the center by applying a large marker size
#  scale factor to the circle marker.
#
$X0 = .5;
$Y0 = .46;
&NCAR::gsmk(4);
&NCAR::gspmci(1);
&NCAR::gsmksc(15.);
&NCAR::gpm(1,float( [ $X0 ] ),float( [ $Y0 ] ));
#
&NCAR::pcseti( 'FN', 21 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq($X0,$Y0+.035,'Circle',.021,0.,0.);
&NCAR::plchhq($X0,$Y0     ,'Scaled',.021,0.,0.);
&NCAR::plchhq($X0,$Y0-.035,'by 15.',.021,0.,0.);
#
#  Label the plot using Plotchar.
#
&NCAR::pcseti( 'FN', 25 );
&NCAR::pcseti( 'CC', 5 );
&NCAR::plchhq(.5,.915,'Polymarkers',.035,0.,0.);



&NCAR::frame();
&NCAR::gdawk( 1 );
&NCAR::gclwk( 1 );
&NCAR::gclks();



rename 'gmeta', 'ncgm/pgkex07.ncgm';
