use strict;
use Test::Simple 'no_plan';
use lib './lib';

use HTML::Clean::Human;
#use Smart::Comments '###';



my $html = q|
<tr>
<td><font color="#000">Groups that Rent the Victory Youth Center for 200 hours or</font> more in a year: <br /> <em> 10% Discount on Hourly Rate</em></td> </tr>
<tr>
<td>Groups that Rent the Victory Youth Center for 300 hours or more in a year: <em><br /> 15% Discount on Hourly Rate</em></td> </tr>
<tr>
<td>Groups that Rent the Victory Youth Center for 400 hours or more in a year: <em><br /> 20% Discount on Hourly Rate</em> </td> </tr>
<tr>
<td><strong>The Katie Fitzgerald Recreation Center and Future Merrick Center in SE will include:</strong>&nbsp;

 <ul> <li> <div align="left">Regulation <a href="http://linkhere">high school</a> basketball courts with hardwood floors that can double as a volleyball court and can be partitioned into two separate "middle school sized" courts to optimize youth league competitions.</div>
 </li><li> <div align="left">A stage with adjacent storage areas</div>
 </li> <li> <div align="left">Meeting rooms</div>
<div align="left"></div>
<div align="left"><u><strong>Cardinal McCarrick Center in Wheaton is Gym only</strong></u></div>
<div align="left"></div>
 </li> </ul>
</td>
</tr>
</table>
<p align="center">Bla bla...</p>

<cite>Citatioun.</cite>
|;

### $html



my $c = new HTML::Clean::Human('./t/mess.html');
ok $c;
my $out = $c->clean;
ok $out;
### $out

