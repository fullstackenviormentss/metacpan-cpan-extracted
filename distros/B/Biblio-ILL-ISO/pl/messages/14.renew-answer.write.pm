#!/usr/bin/perl

BEGIN{push @INC, "./../blib/lib/"}

use Biblio::ILL::ISO::RenewAnswer;

#
# transaction-id
#
my $tid = new Biblio::ILL::ISO::TransactionId("PLS","001","", 
					      new Biblio::ILL::ISO::SystemId("MWPL"));

#
# service-date-time
#
my $sdt = new Biblio::ILL::ISO::ServiceDateTime( new Biblio::ILL::ISO::DateTime("20030623","114400"),
						 new Biblio::ILL::ISO::DateTime("20030623","114015")
						 );

#
# requester-id
#
my $reqid = new Biblio::ILL::ISO::SystemId();
$reqid->set_person_name("David A. Christensen");

#
# responder-id
#
my $resid = new Biblio::ILL::ISO::SystemId("MWPL");

#
# date-due
#
my $dd = new Biblio::ILL::ISO::DateDue("20030814","true");

#
# responder-note
#
my $rn = new Biblio::ILL::ISO::ILLString("This is a responder-note.");


#-------------------------------------------------------------------------------------------

my $msg = new Biblio::ILL::ISO::RenewAnswer();

# Minimum required:
$msg->set_protocol_version_num("version-2");
$msg->set_transaction_id( $tid );
$msg->set_service_date_time( $sdt );
$msg->set_answer("true");

# Extra, useful info:
$msg->set_responder_id( $reqid );
$msg->set_responder_id( $resid );
$msg->set_date_due( $dd );
$msg->set_responder_note( $rn );

#
#print "\n-as_pretty_string------------------------------------\n";
#print $msg->as_pretty_string();
#print "\n-----------------------------------------------------\n";
#
#print "\n-debug(ans->as_asn())--------------------------------\n";
#my $href = $msg->as_asn();
#print $msg->debug($href);
#print "\n-----------------------------------------------------\n";
#
#$msg->encode();
#

#print "\n-write-----------------------------------------------\n";
$msg->write("msg_14.renew-answer.ber");
#print "\n-----------------------------------------------------\n";

#print "---end---\n";

