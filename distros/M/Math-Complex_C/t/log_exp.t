use warnings;
use strict;
use Math::Complex_C qw(:all);

my $op = MCD(5, 4.5);
my $rop = MCD();

my $eps = 1e-12;

print "1..8\n";

exp_c($rop, $op);

if(approx(real_c($rop), -31.2848705190751, $eps)) {print "ok 1\n"}
else {
  warn "\n Expected approx -31.2848705190751\nGot ", real_c($rop), "\n";
  print "not ok 1\n";
}

if(approx(imag_c($rop), -145.07833288059, $eps)) {print "ok 2\n"}
else {
  warn "\n Expected approx -145.07833288059\nGot ", imag_c($rop), "\n";
  print "not ok 2\n";
}


log_c($rop, $op);

if(approx(real_c($rop), 1.90610133507297, $eps)) {print "ok 3\n"}
else {
  warn "\n Expected approx 1.90610133507297\nGot ", real_c($rop), "\n";
  print "not ok 3\n";
}

if(approx(imag_c($rop), 0.732815101786507, $eps)) {print "ok 4\n"}
else {
  warn "\n Expected approx 0.732815101786507\nGot ", imag_c($rop), "\n";
  print "not ok 4\n";
}

##############################
##############################

$rop = exp($op);

if(approx(real_c($rop), -31.2848705190751, $eps)) {print "ok 5\n"}
else {
  warn "\n Expected approx -31.2848705190751\nGot ", real_c($rop), "\n";
  print "not ok 5\n";
}

if(approx(imag_c($rop), -145.07833288059, $eps)) {print "ok 6\n"}
else {
  warn "\n Expected approx -145.07833288059\nGot ", imag_c($rop), "\n";
  print "not ok 6\n";
}

$rop = log($op);

if(approx(real_c($rop), 1.90610133507297, $eps)) {print "ok 7\n"}
else {
  warn "\n Expected approx 1.90610133507297\nGot ", real_c($rop), "\n";
  print "not ok 7\n";
}

if(approx(imag_c($rop), 0.732815101786507, $eps)) {print "ok 8\n"}
else {
  warn "\n Expected approx 0.732815101786507\nGot ", imag_c($rop), "\n";
  print "not ok 8\n";
}

##############################
##############################


sub approx {
    if(($_[0] > ($_[1] - $_[2])) && ($_[0] < ($_[1] + $_[2]))) {return 1}
    return 0;
}


