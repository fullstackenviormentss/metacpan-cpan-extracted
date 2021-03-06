# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

######################### We start with some black magic to print on failure.

# Change 1..1 below to 1..last_test_to_print .
# (It may become useful if the test is moved to ./t subdirectory.)

BEGIN { $| = 1; print "1..1\n"; }
END {print "not ok 1\n" unless $loaded;}
use Business::BancaSella::Encode::Gestpay;

$gpe	= new Business::BancaSella::Encode::Gestpay(
										shopping 	=> '99987',
										currency 	=> 'eur',
										amount 		=> 5467.32,
										language 	=> 'italian',
										otp			=> '5667g231yg67fv',
										id			=> 'dsafsadf',
										cardnumber	=> 'aaaaaaa',
										expmonth	=> '05',
										expyear		=> '2001',
										name		=> 'Emiliano Bruni',
										mail		=> 'bruni\@micso.it',
										user_params => {
														'PRODUCT_ID'	=> 512,
														'PRODUCT_TYPE'	=> 'ADSL'
														}
										);
print $gpe->uri . "\n";
print $gpe->form . "\n";

$loaded = 1;
print "ok 1\n";

######################### End of black magic.

# Insert your test code below (better if it prints "ok 13"
# (correspondingly "not ok 13") depending on the success of chunk 13
# of the test code):

