package Business::EDI::CodeList::NondiscreteMeasurementNameCode;

use base 'Business::EDI::CodeList';
my $VERSION     = 0.02;
sub list_number {6155;}
my $usage       = 'B';

# 6155  Non-discrete measurement name code                      [B]
# Desc: Code specifying the name of a non-discrete
# measurement.
# Repr: an..17

my %code_hash = (
'1' => [ 'Clear',
    'The measurement has returned a clear result.' ],
'2' => [ 'Hazy',
    'The measurement has returned a hazy result.' ],
'3' => [ 'Excess',
    'The measurement has returned a result which is in excess of that expected.' ],
'4' => [ 'Some',
    'Some amount of the attribute being measured was found.' ],
'5' => [ 'Undetectable',
    'The attribute being measured was undetectable.' ],
'6' => [ 'Trace',
    'A trace of the attribute being measured was found.' ],
'7' => [ 'Yes',
    'The measurement returned a yes result.' ],
'8' => [ 'Closed',
    'The measurement returned a closed result.' ],
'9' => [ 'Passed',
    'The measurement passed the required criteria.' ],
'10' => [ 'Present',
    'The attribute being measured was present.' ],
'11' => [ 'Gel',
    'Indicates that the item measured is semi-solid colloidal.' ],
'13' => [ 'Slight',
    'A slight amount of the attribute being measured was found.' ],
'14' => [ 'No Good',
    'The result of the measurement was no good.' ],
'15' => [ 'Marginal',
    'The result of the measurement was marginal.' ],
'16' => [ 'Nil',
    'No amount of the attribute being measured was found.' ],
'17' => [ 'Positive',
    'A non-discrete value is positive.' ],
'18' => [ 'Open',
    'The result of the measurement was open.' ],
'19' => [ 'Free',
    'Indicates that the item measured unrestricted.' ],
'21' => [ 'Checked',
    'The measurement returned a checked result.' ],
'22' => [ 'Fail',
    'The measurement returned a fail result.' ],
'23' => [ 'Absent',
    'The attribute being measured was absent.' ],
'24' => [ 'Good',
    'The measurement returned a good result.' ],
'25' => [ 'Fair',
    'The measurement returned a fair result.' ],
'26' => [ 'Poor',
    'The measurement returned a poor result.' ],
'27' => [ 'Excellent',
    'The measurement returned an excellent result.' ],
'28' => [ 'Bright',
    'The result was intense and/or vivid.' ],
'29' => [ 'To be determined',
    'The measurement is to be determined.' ],
'30' => [ 'High',
    'The result of the measurement is high.' ],
'31' => [ 'Ambient temperature',
    'The temperature of the surrounding area or environment.' ],
'32' => [ 'Conditional, free',
    'Indicates that the item measured is conditionally unrestricted.' ],
'33' => [ 'Balance',
    'The measurement is balanced.' ],
'34' => [ 'Complete',
    'The measurement is complete.' ],
'35' => [ 'Low',
    'The attribute being measured had a low measurement.' ],
'36' => [ 'Not applicable',
    'The measurement is not applicable.' ],
'37' => [ 'Not determined',
    'The measurement has not been determined.' ],
'38' => [ 'Negligible',
    'A negligible amount of the attribute being measured was found.' ],
'39' => [ 'Moderate',
    'A moderate amount of the attribute being measured was found.' ],
'40' => [ 'Appreciable',
    'An appreciable amount of the attribute being measured was found.' ],
'41' => [ 'Not available',
    'The measurement was not available.' ],
'42' => [ 'Uncontrolled temperature',
    'Uncontrolled temperature conditions.' ],
'43' => [ 'Chilled',
    'Kept at a low temperature without freezing.' ],
'44' => [ 'Frozen',
    'Kept at a temperature below the freezing point.' ],
'45' => [ 'Temperature controlled',
    'Required temperature value.' ],
'46' => [ 'Negative',
    'A non-discrete value is negative.' ],
'47' => [ 'Variable',
    'A non-discrete value is variable.' ],
'48' => [ 'Partial',
    'A measurement that is partial.' ],
'49' => [ 'Dry ice',
    'The temperature of the goods being cooled by dry ice or solid carbon dioxide.' ],
'ZZZ' => [ 'Mutually defined',
    'A code assigned within a code list to be used on an interim basis and as defined among trading partners until a precise code can be assigned to the code list.' ],
);
sub get_codes { return \%code_hash; }

1;
