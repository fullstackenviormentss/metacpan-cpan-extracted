###
### $Release: 0.0103 $
### $Copyright: copyright(c) 2010-2011 kuwata-lab.com all rights reserved $
### $License: MIT License $
###

use strict;
use warnings;
no warnings 'void';   # suppress 'Useless use of ... in void context'

use Oktest;


topic "Misc", sub {

    spec "ex", sub {
        OK (1+1) == 2;
    };

    ## example of 'skip_when()'
    spec "some cool feature is available", sub {
        #my $on_windows = $^O =~ /MSWin/;
        my $on_windows = 1;
        skip_when $on_windows, "Windows not supported";
        OK (`echo Haruhi | md5`) eq 'd7f76bdf93d3f59fba678b204fc4faa1';
    };

    ## example of 'TODO()'
    spec "another cool feature is available", sub {
        TODO "not implemented yet.";
    };

    ## Tips: if spec body is not specified then it is regarded as TODO.
    ## For example, the following line is equivarent to above.
    spec "another cool feature is available";

};


Oktest::main() if $0 eq __FILE__;
1;
