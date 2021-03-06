# This -*- perl -*- script makes the forwd_demo script
# $Id: forwd_demo.PL,v 1.2 1997/01/16 20:43:34 gbarr Exp $

use Config;
use Cwd;

$script = "./forwd_demo";
unlink($script);

open MIR, ">$script" or die "open for writing $script: $!";
print MIR $Config{'startperl'}," -w\n";
$cwd = Cwd::getcwd();
#print MIR "use lib qw($cwd/blib);\n";
print MIR <DATA>; 
chmod(0755, $script);

__DATA__
use Mail::Internet;

@mail = <>;

$mail = Mail::Internet->new(\@mail);

$mail->remove_sig;
$mail->tidy_body;

@reply = ();
if(open(HDR,"$ENV{HOME}/.mailhdr")) {
 @reply = <HDR>;
 close(HDR);
}

$rply = Mail::Internet->new(\@reply);

$subject = $mail->get('Subject');

$rply->replace('To', "");
$rply->replace('Cc', "");
$rply->replace('Subject',$subject);

$rply->body($body = $mail->body);

unshift @{$body},"---------- Begin Included Message ----------\n";
push    @{$body},"----------- End Included Message -----------\n";

$file = "/tmp/reply.$$";

open(FILE,">$file") || die "Cannot open $file:$!\n";

$rply->print(\*FILE);

close(FILE);

$editor = $ENV{"EDITOR"} || "/usr/bin/nvi";

warn "$editor :$!\n" if (system("$editor $file"));

unlink($file,$file . '%');

exit 0;

