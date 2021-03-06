## This file generated by InlineX::C2XS (version 0.22) using Inline::C (version 0.53)
package Math::Float128;
use warnings;
use strict;

require Exporter;
*import = \&Exporter::import;
require DynaLoader;

use overload
  '+'     => \&_overload_add,
  '*'     => \&_overload_mul,
  '-'     => \&_overload_sub,
  '/'     => \&_overload_div,
  '**'    => \&_overload_pow,
  '+='    => \&_overload_add_eq,
  '*='    => \&_overload_mul_eq,
  '-='    => \&_overload_sub_eq,
  '/='    => \&_overload_div_eq,
  '**='   => \&_overload_pow_eq,
  '=='    => \&_overload_equiv,
  '""'    => \&_overload_string,
  '!='    => \&_overload_not_equiv,
  'bool'  => \&_overload_true,
  '!'     => \&_overload_not,
  '='     => \&_overload_copy,
  '<'     => \&_overload_lt,
  '<='    => \&_overload_lte,
  '>'     => \&_overload_gt,
  '>='    => \&_overload_gte,
  '<=>'   => \&_overload_spaceship,
  'abs'   => \&_overload_abs,
  'int'   => \&_overload_int,
  'sqrt'  => \&_overload_sqrt,
  'log'   => \&_overload_log,
  'exp'   => \&_overload_exp,
  'sin'   => \&_overload_sin,
  'cos'   => \&_overload_cos,
  'atan2' => \&_overload_atan2,
  '++'    => \&_overload_inc,
  '--'    => \&_overload_dec,
;

use subs qw(FLT128_DIG FLT128_MANT_DIG FLT128_MIN_EXP FLT128_MAX_EXP FLT128_MIN_10_EXP FLT128_MAX_10_EXP
            M_Eq M_LOG2Eq M_LOG10Eq M_LN2q M_LN10q M_PIq M_PI_2q M_PI_4q M_1_PIq M_2_PIq
            M_2_SQRTPIq M_SQRT2q M_SQRT1_2q
            FLT128_MAX FLT128_MIN FLT128_EPSILON FLT128_DENORM_MIN);

$Math::Float128::VERSION = '0.12';

DynaLoader::bootstrap Math::Float128 $Math::Float128::VERSION;

@Math::Float128::EXPORT = ();
@Math::Float128::EXPORT_OK = qw(
    flt128_set_prec flt128_get_prec InfF128 NaNF128 ZeroF128 UnityF128 is_NaNF128
    is_InfF128 is_InfF128 is_ZeroF128 STRtoF128 NVtoF128 IVtoF128 UVtoF128 F128toSTR
    F128toSTRP F128toF128 F128toNV
    FLT128_DIG FLT128_MANT_DIG FLT128_MIN_EXP FLT128_MAX_EXP FLT128_MIN_10_EXP FLT128_MAX_10_EXP
    M_Eq M_LOG2Eq M_LOG10Eq M_LN2q M_LN10q M_PIq M_PI_2q M_PI_4q M_1_PIq M_2_PIq
    M_2_SQRTPIq M_SQRT2q M_SQRT1_2q
    FLT128_MAX FLT128_MIN FLT128_EPSILON FLT128_DENORM_MIN
    cmp2NV f128_bytes
    acos_F128 acosh_F128 asin_F128 asinh_F128 atan_F128 atanh_F128 atan2_F128 cbrt_F128 ceil_F128
    copysign_F128 cosh_F128 cos_F128 erf_F128 erfc_F128 exp_F128 expm1_F128 fabs_F128 fdim_F128
    finite_F128 floor_F128 fma_F128 fmax_F128 fmin_F128 fmod_F128 frexp_F128 hypot_F128 isinf_F128
    ilogb_F128 isnan_F128 j0_F128 j1_F128 jn_F128 ldexp_F128 lgamma_F128 llrint_F128 llround_F128
    log_F128 log10_F128 log2_F128 log1p_F128 lrint_F128 lround_F128 modf_F128 nan_F128
    nearbyint_F128 nextafter_F128 pow_F128 remainder_F128 remquo_F128 rint_F128 round_F128
    scalbln_F128 scalbn_F128 signbit_F128 sincos_F128 sinh_F128 sin_F128 sqrt_F128 tan_F128
    tanh_F128 tgamma_F128 trunc_F128 y0_F128 y1_F128 yn_F128
    );

%Math::Float128::EXPORT_TAGS = (all => [qw(
    flt128_set_prec flt128_get_prec InfF128 NaNF128 ZeroF128 UnityF128 is_NaNF128
    is_InfF128 is_InfF128 is_ZeroF128 STRtoF128 NVtoF128 IVtoF128 UVtoF128 F128toSTR
    F128toSTRP F128toF128 F128toNV
    FLT128_DIG FLT128_MANT_DIG FLT128_MIN_EXP FLT128_MAX_EXP FLT128_MIN_10_EXP FLT128_MAX_10_EXP
    M_Eq M_LOG2Eq M_LOG10Eq M_LN2q M_LN10q M_PIq M_PI_2q M_PI_4q M_1_PIq M_2_PIq
    M_2_SQRTPIq M_SQRT2q M_SQRT1_2q
    FLT128_MAX FLT128_MIN FLT128_EPSILON FLT128_DENORM_MIN
    cmp2NV f128_bytes
    acos_F128 acosh_F128 asin_F128 asinh_F128 atan_F128 atanh_F128 atan2_F128 cbrt_F128 ceil_F128
    copysign_F128 cosh_F128 cos_F128 erf_F128 erfc_F128 exp_F128 expm1_F128 fabs_F128 fdim_F128
    finite_F128 floor_F128 fma_F128 fmax_F128 fmin_F128 fmod_F128 frexp_F128 hypot_F128 isinf_F128
    ilogb_F128 isnan_F128 j0_F128 j1_F128 jn_F128 ldexp_F128 lgamma_F128 llrint_F128 llround_F128
    log_F128 log10_F128 log2_F128 log1p_F128 lrint_F128 lround_F128 modf_F128 nan_F128
    nearbyint_F128 nextafter_F128 pow_F128 remainder_F128 remquo_F128 rint_F128 round_F128
    scalbln_F128 scalbn_F128 signbit_F128 sincos_F128 sinh_F128 sin_F128 sqrt_F128 tan_F128
    tanh_F128 tgamma_F128 trunc_F128 y0_F128 y1_F128 yn_F128
    )]);

$Math::Float128::NOK_POK = 0; # Set to 1 to allow warnings in new() and overloaded operations when
                              # a scalar that has set both NOK (NV) and POK (PV) flags is encountered

sub dl_load_flags {0} # Prevent DynaLoader from complaining and croaking

sub _overload_string {

    if(is_ZeroF128($_[0])) {
      return '-0' if is_ZeroF128($_[0]) < 0;
      return '0';
    }

    if(is_NaNF128($_[0])) {return 'NaN'}

    my $inf = is_InfF128($_[0]);
    return '-Inf' if $inf < 0;
    return 'Inf'  if $inf > 0;

    my @p = split /e/i, F128toSTR($_[0]);
    while(substr($p[0], -1, 1) eq '0' && substr($p[0], -2, 1) ne '.') {
      chop $p[0];
    }
    return $p[0] . 'e' . $p[1];
}

sub new {

    # This function caters for 2 possibilities:
    # 1) that 'new' has been called as a method - in which
    #    case there will be a maximum of 2 args
    # 2) that 'new' has been called as a function - in
    #    which case there will be a maximum of 1 arg.
    # If there are no args, then we just want to return a
    # Math::Float128 object that's a NaN.

    if(!@_) {return NaNF128()}

    if(@_ > 2) {die "More than 2 arguments supplied to new()"}

    # If 'new' has been called OOP style, the first arg is the string
    # "Math::Float128" which we don't need - so let's remove it. However,
    # if the first arg is a Math::Float128 object (which is a possibility),
    # then we'll get a fatal error when we check it for equivalence to
    # the string "Math::Float128". So we first need to check that it's
    # not an object - which we'll do by using the ref() function:
    if(!ref($_[0]) && $_[0] eq "Math::Float128") {
      shift;
      if(!@_) {return NaNF128()}
      }

    if(@_ > 1) {die "Too many arguments supplied to new() - expected no more than 1"}

    my $arg = shift;
    my $type = _itsa($arg);

    return UVtoF128 ($arg) if $type == 1; #UV
    return IVtoF128 ($arg) if $type == 2; #IV

    if($type == 4) { #PV
      if(_SvNOK($arg)) {
        set_nok_pok(nok_pokflag() + 1);
        if($Math::MPFR::NOK_POK) {
          warn "Scalar passed to new() is both NV and PV. Using PV (string) value";
        }
      }
      return STRtoF128($arg);
    }

    if($type == 3) {                      # NV
      if($arg == 0) {return NVtoF128($arg)}
      if($arg != $arg) { return NaNF128()}
      if(($arg / $arg) != 1) { # Inf
        if($arg < 0) {return InfF128(-1)}
        return InfF128(1);
      }
      return NVtoF128($arg);
    }

    if($type == 113) { # Math::Float128
      return F128toF128($arg);
    }

    die "Bad argument given to new";
}


sub f128_bytes {
  my @ret = _f128_bytes($_[0]);
  return join '', @ret;
}

sub FLT128_DIG        {return _FLT128_DIG()}
sub FLT128_MAX        {return _FLT128_MAX()}
sub FLT128_MIN        {return _FLT128_MIN()}
sub FLT128_EPSILON    {return _FLT128_EPSILON()}
sub FLT128_DENORM_MIN {return _FLT128_DENORM_MIN()}
sub FLT128_MANT_DIG   {return _FLT128_MANT_DIG()}
sub FLT128_MIN_EXP    {return _FLT128_MIN_EXP()}
sub FLT128_MAX_EXP    {return _FLT128_MAX_EXP()}
sub FLT128_MIN_10_EXP {return _FLT128_MIN_10_EXP()}
sub FLT128_MAX_10_EXP {return _FLT128_MAX_10_EXP()}
sub M_Eq              {return _M_Eq()}
sub M_LOG2Eq          {return _M_LOG2Eq()}
sub M_LOG10Eq         {return _M_LOG10Eq()}
sub M_LN2q            {return _M_LN2q()}
sub M_LN10q           {return _M_LN10q()}
sub M_PIq             {return _M_PIq()}
sub M_PI_2q           {return _M_PI_2q()}
sub M_PI_4q           {return _M_PI_4q()}
sub M_1_PIq           {return _M_1_PIq()}
sub M_2_PIq           {return _M_2_PIq()}
sub M_2_SQRTPIq       {return _M_2_SQRTPIq()}
sub M_SQRT2q          {return _M_SQRT2q()}
sub M_SQRT1_2q        {return _M_SQRT1_2q()}

1;

__END__

=head1 NAME

Math::Float128 - perl interface to C's (quadmath) __float128 operations


=head1 DESCRIPTION


   use Math::Float128 qw(:all);

   $arg = ~0; # largest UV
   $f1 = Math::Float128->new($arg); # Assign the UV ~0 to $f2.
   $f2 = UVtoF128($arg);            # Assign the UV ~0 to $f2.

   $arg = -21;
   $f1 = Math::Float128->new($arg); # Assign the IV -21 to $f2.
   $f2 = IVtoF128($arg);            # Assign the IV -21 to $f2.

   $arg = 32.1;
   $f1 = Math::Float128->new($arg); # Assign the NV 32.1 to $f2.
   $f2 = NVtoF128($arg);            # Assign the NV 32.1 to $f2.

   $arg = "32.1";
   $f1 = Math::Float128->new($arg); # Assign strtoflt128("32.1") to $f2.
   $f2 = STRtoF128($arg);           # Assign strtoflt128("32.1") to $f2.

   $f3 = Math::Float128->new($f1); # Assign the value of $f1 to $f3.
   $f4 = F128toF128($f1);          # Assign the value of $f1 to $f4.
   $f5 = $f1;                      # Assign the value of $f1 to $f5.

   This behaviour has changed from 0.04 and earlier.

   A number of the functions below accept string arguments. These arguments
   are passed to strtoflt128() and checked for the presence of non-numeric
   characters. If any such non-numeric characters are detected, then the
   global non-numeric flag (which is initially set to 0) will be incremented.
   Neither leading nor trailing whitespace is deemed non-numeric, but any
   other (ie internal) whitespace *is* regarded as non-numeric.
   You can query the value held by the global non-numeric flag by running
   Math::Float128::nnumflag() and you can manually alter the value of this
   global using Math::Float128::set_nnum and Math::Float128::clear_nnum.
   These functions are documented below.

   NOTE:
    Math::Float128->new(32.1) != Math::Float128->new('32.1') unless
    $Config{nvtype} reports __float128. The same holds for many (but not
    all) numeric values. In general, it's not always true (and is often
    untrue) that Math::Float128->new($n) == Math::Float128->new("$n")


=head1 OVERLOADING

   The following operations are overloaded:
    + - * / **
    += -= *= /= **=
    != == <= >= <=> < >
    ++ --
    =
    abs bool ! int print
    sqrt log exp
    sin cos atan2

    In those situations where the overload subroutine operates on 2
    perl variables, then obviously one of those perl variables is
    a Math::Float128 object. To determine the value of the other
    variable the subroutine works through the following steps (in
    order), using the first value it finds, or croaking if it gets
    to step 6:

    1. If the variable is a UV (unsigned integer value) then that
       value is used. The variable is considered to be a UV if
       (perl 5.8) the UOK flag is set or if (perl 5.6) SvIsUV()
       returns true.

    2. If the variable is an IV (signed integer value) then that
       value is used. The variable is considered to be an IV if the
       IOK flag is set.

    3. If the variable is a string (ie the POK flag is set) then the
       value of that string is used.

    4. If the variable is an NV (floating point value) then that
       value is used. The variable is considered to be an NV if the
       NOK flag is set.

    5. If the variable is a Math::Float128 object then the value
       encapsulated in that object is used.

    6. If none of the above is true, then the second variable is
       deemed to be of an invalid type. The subroutine croaks with
       an appropriate error message.


=head1 ASSIGNMENT FUNCTIONS

   The following functions return a Math::Float128 object ($f).

    $f = Math::Float128->new($arg);
     Returns a Math::Float128 object to which the numeric value of $arg
     has been assigned.
     If no arg is supplied then $f will be NaN.

    $f = UVtoF128($arg);
     Returns a Math::Float128 object to which the numeric (unsigned
     integer) value of $arg has been assigned.

    $f = IVtoF128($arg);
     Returns a Math::Float128 object to which the numeric (signed
     integer) value of $arg has been assigned.

    $f = NVtoF128($arg);
     Returns a Math::Float128 object to which the numeric (floating
     point) value of $arg has been assigned.

    $f2 = F128toF128($f1);
     Returns a Math::Float128 object that is a copy of the
     Math::Float128 object provided as the argument.
     Courtesy of overloading, this is in effect no different to doing:
     $f2 = $f1;

    $f = STRtoF128($str);
     Returns a Math::Float128 object that has the value of the string
     $str.


=head1 ASSIGNMENT OF INF, NAN, UNITY and ZERO

    $f = InfF128($sign);
     If $sign < 0, returns a Math::Float128 object set to
     negative infinity; else returns a Math::Float128 object set
     to positive infinity.

    $f = NaNF128();
     Returns a Math::Float128 object set to NaN (Not a Number).

    $f = ZeroF128($sign);
     If $sign < 0, returns a Math::Float128 object set to
     negative zero; else returns a Math::Float128 object set to
     zero.

    $f = UnityF128($sign);
     If $sign < 0, returns a Math::Float128 object set to
     negative one; else returns a Math::Float128 object set to
     one.

    flt128_set_prec($precision);
     Sets the precision of stringified values to $precision decimal
     digits.

    $precision = flt128_get_prec();
     Returns the precision (in decimal digits) that will be used
     when stringifying values (by printing them, or calling
     F128toSTR).


=head1 ASSIGNMENT OF QUADMATH.H CONSTANTS

   The following functions return their values as either normal
   perl scalar integer values ($iv) or Math::Float128 objects
   ($f), as appropriate.

    $iv = FLT128_DIG;
     Returns FLT128_DIG or croaks if FLT128_DIG is not defined.

    $f = FLT128_MAX;
     Returns FLT128_MAX or croaks if FLT128_MAX is not defined.

    $f = FLT128_MIN;
     Returns FLT128_MIN or croaks if FLT128_MIN is not defined.

    $f = FLT128_EPSILON;
     Returns FLT128_EPSILON or croaks if FLT128_EPSILON is not
     defined.

    $f = FLT128_DENORM_MIN;
     Returns FLT128_DENORM_MIN or croaks if FLT128_DENORM_MIN is
     not defined.

    $iv = FLT128_MANT_DIG;
     Returns FLT128_MANT_DIG or croaks if FLT128_MANT_DIG is not
    defined.

    $iv = FLT128_MIN_EXP;
     Returns FLT128_MIN_EXP or croaks if FLT128_MIN_EXP is not
     defined.

    $iv = FLT128_MAX_EXP;
     Returns FLT128_MAX_EXP or croaks if FLT128_MAX_EXP is not
     defined.

    $iv = FLT128_MIN_10_EXP;
     Returns FLT128_MIN_10_EXP or croaks if FLT128_MIN_10_EXP is
     not defined.

    $iv = FLT128_MAX_10_EXP;
     Returns FLT128_MAX_10_EXP or croaks if FLT128_MAX_10_EXP is
     not defined.

    $f = M_Eq;
     Returns M_Eq (e) or expq(1.0) if M_Eq is not defined.

    $f = M_LOG2Eq;
     Returns M_LOG2Eq or log2q(expq(1.0)) if M_LOG2Eq is not
     defined.

    $f = M_LOG10Eq;
     Returns M_LOG10Eq or log10q(expq(1.0)) if M_LOG10Eq is not
     defined.

    $f = M_LN2q;
     Returns M_LN2q or logq(2) if M_LN2q is not defined.

    $f = M_LN10q;
     Returns M_LN10q or logq(10) if M_LN10q is not defined.

    $f = M_PIq;
     Returns M_PIq (pi) or 2 * asinq(1) if M_PIq is not defined.

    $f = M_PI_2q;
     Returns M_PI_2q (pi/2) or asinq(1) if M_PI_2q is not defined.

    $f = M_PI_4q;
     Returns M_PI_4q (pi/4) or asinq(1)/2 if M_PI_4q is not defined.

    $f = M_1_PIq;
     Returns M_1_PIq (1/pi) or 0.5/asinq(1) if M_1_PIq is not
     defined.

    $f = M_2_PIq;
     Returns M_2_PIq (2/pi) or 1/asinq(1) if M_2_PIq is not defined.

    $f = M_2_SQRTPIq;
     Returns M_2_SQRTPIq (2/sqrt(pi)) or 2/sqrtq(pi) if M_2_SQRTPIq
     is not defined.

    $f = M_SQRT2q;
     Returns M_SQRT2q or sqrtq(2)) if M_SQRT2q is not defined.

     $f = M_SQRT1_2q;
    Returns M_SQRT1_2q or 1/sqrtq(2)) if M_SQRT1_2q is not defined.



=head1 RETRIEVAL FUNCTIONS

   The following functions provide ways of seeing the value of
   Math::Float128 objects.

    $string = F128toSTR($f);
     Returns the value of the Math::Float128 object as a string.
     The returned string will contain the same as is displayed by
     "print $f", except that print() will strip the trailing zeroes
     in the mantissa (significand) whereas F128toSTR won't.
     By default, provides 36 decimal digits of precision. This can be
     altered by specifying the desired precision (in decimal digits)
     in a call to flt128_set_prec.

    $string = F128toSTRP(f, $precision);
     Same as F128toSTR, but takes an additional arg that specifies the
     precision (in decimal digits) of the stringified return value.

    $nv = F128toNV($f);
     This function returns the value of the Math::Float128 object to
     a perl scalar (NV). It may not translate the value accurately,
     depending, of course, upon both the value that the object holds
     and the precision of the NV's mantissa.


=head1 MATH LIBRARY FUNCTIONS

   With the following functions, "$rop" and "$op" are Math::Float128
   objects, and "$iv" is just a normal perl scalar that either
   holds a signed integer value (rhs), or to which a signed integer value
   will be returned (lhs).
   These are just interfaces to the quadmath equivalents to the (fairly
   standard) math library functions. I'm assuming you already have
   access to the documentation of those math library functions.
   These functions do not check their argument types - if you get
   a segfault, check that you've supplied the correct argument type(s).

    acos_F128($rop, $op);
     acos($op) is assigned to $rop.

    acosh_F128($rop, $op);
     acosh($op) is assigned to $rop.

    asin_F128($rop, $op);
     asin($op) is assigned to $rop.

    asinh_F128($rop, $op);
     asinh($op) is assigned to $rop.

    atan_F128($rop, $op);
     atan($op) is assigned to $rop.

    atanh_F128($rop, $op);
     atanh($op) is assigned to $rop.

    atan2_F128($rop, $op1, $op2);
     atan2($op1, $op2) is assigned to $rop.

    cbrt_F128($rop, $op);
     cbrt($op) is assigned to $rop.

    ceil_F128($rop, $op);
     ceil($op) is assigned to $rop.

    copysign_F128($rop, $op1, $op2);
     copysign($op1, $op2) is assigned to $rop.

    cosh_F128($rop, $op);
     cosh($op) is assigned to $rop.
     On mingw-w64 compilers, coshq() crashes, so for those compilers
     we assign sqrt((sinh($op) ** 2) + 1) to $rop.

    cos_F128($rop, $op);
     cos($op) is assigned to $rop.

    erf_F128($rop, $op);
     erf($op) is assigned to $rop.

    erfc_F128($rop, $op);
     erfc($op) is assigned to $rop.

    exp_F128($rop, $op);
     exp($op) is assigned to $rop.
     On mingw-w64 compilers, expq() crashes, so for those compilers
     we assign pow(M_Eq, $op), ie e**$op, to $rop.

    expm1_F128($rop, $op);
     expm1($op) is assigned to $rop.

    fabs_F128($rop, $op);
     fabs($op) is assigned to $rop.

    fdim_F128($rop, $op1, $op2);
     fdim($op1, $op2) is assigned to $rop.

    $iv = finite_F128($op);
     finite($op) is assigned to $iv.

    floor_F128($rop, $op);
     floor($op) is assigned to $rop.

    fma_F128($rop, $op1, $op2, $op3);
     fma($op1, $op2, $op3) is assigned to $rop.
     On mingw-w64 compilers, fmaq() crashes, so for those compilers
     we assign ($op1 * $op2)+$op3 to $rop.

    fmax_F128($rop, $op1, $op2);
     fmax($op1, $op2) is assigned to $rop.

    fmin_F128($rop, $op1, $op2);
     fmin($op1, $op2) is assigned to $rop.

    fmod_F128($rop, $op1, $op2);
     fmod($op1, $op2) is assigned to $rop.

    frexp_F128($rop, $iv, $op);
     frexp($op) is assigned to ($rop, $iv)

    hypot_F128($rop, $op1, $op2);
     hypot($op1, $op2) is assigned to $rop.

    $iv = isinf_F128($op);
     isinf($op) is assigned to $iv.

    $iv = ilogb_F128($op);
     ilogb($op) is assigned to $iv.

    $iv = isnan_F128($op);
     isnan($op) is assigned to $iv.

    j0_F128($rop, $op);
     j0($op) is assigned to $rop.

    j1_F128($rop, $op);
     j1($op) is assigned to $rop.

    jn_F128($rop, $iv, $op);
     jn($iv, $op) is assigned to $rop.
     $iv should not contain a value that won't fit into a signed int.

    ldexp_F128($rop, $op, $iv);
     ldexp($op, $iv) is assigned to $rop.
     $iv should not contain a value that won't fit into a signed int

    lgamma_F128($rop, $op);
     lgamma($op) is assigned to $rop.

    $iv = llrint_F128($op);
     llrint($op) is assigned to $iv.
     This requires that perl's IV is large enough to hold a longlong
     int. Otherwise attempts to use this function will result in a fatal
     error, accompanied by a message stating that the function is
     unimplemented.

    $iv = llround_F128($op);
     llround($op) is assigned to $rop.
     This requires that perl's IV is large enough to hold a longlong
     int. Otherwise attempts to use this function will result in a fatal
     error, accompanied by a message stating that the function is
     unimplemented.

    log_F128($rop, $op);
     log($op) is assigned to $rop. # base e

    log10_F128($rop, $op);
     log($op) is assigned to $rop. # base 10

    log2_F128($rop, $op);
     log($op) is assigned to $rop. # base 2

    log1p_F128($rop, $op);
     log1p($op) is assigned to $rop. # base e

    $iv = lrint_F128($op);
     lrint($op) is assigned to $iv.
     This requires that perl's IV is large enough to hold a long int.
     Otherwise attempts to use this function will result in a fatal
     error, accompanied by a message stating that the function is
     unimplemented.

    $iv = lround_F128($op);
     lround($op) is assigned to $iv
     This requires that perl's IV is large enough to hold a long int.
     Otherwise attempts to use this function will result in a fatal
     error, accompanied by a message stating that the function is
     unimplemented.

    modf_F128($rop1, $rop2, $op);
     modf($op) is assigned to ($rop1, $rop2).

    nan_F128($rop, $op);
     nan($op) is assigned to $rop.

    nearbyint_F128($rop, $op);
     nearbyint($op) is assigned to $rop.
     On mingw-w64 compilers, nearbyintq() crashes, so for those compilers
     we manually go through the procedure of assigning the correct value
     (for the current rounding mode) to $rop.

    nextafter_F128($rop, $op1, $op2);
     nextafter($op1, $op2) is assigned to $rop.

    pow_F128($rop, $op1, $op2);
     pow($op1, $op2) is assigned to $rop.

    remainder_F128($rop, $op1, $op2);
     remainder($op1, $op2) is assigned to $rop.

    remquo_F128($rop1, $rop2, $op1, $op2);
     remquo($op1, $op2) is assigned to ($rop1, $rop2).

    $iv = rint_F128($op);
     rint($op) is assigned to $rop.

    $iv = round_F128($op);
     round($op) is assigned to $iv.

    scalbln_F128($rop, $op, $iv);
    scalbln($op, $iv) is assigned to $rop.
    $iv should not contain a value that won't fit into a signed
    long int.

    scalbn_F128($rop, $op, $iv);
     scalbn($op, $iv) is assigned to $rop.
     $iv should not contain a value that won't fir into a signed int.

    $iv = signbit_F128($op);
     signbit($op) is assigned to $iv.

    sincos_F128($rop1, $rop2, $op);
     sin($op) is assigned to $rop1.
     cos($op) is assigned to $rop2.

    sinh_F128($rop, $op);
     sinh($op) is assigned to $rop.

    sin_F128($rop, $op);
     sin($op) is assigned to $rop.

    sqrt_F128($rop, $op);
     sqrt($op) is assigned to $rop.

    tan_F128($rop, $op);
     tan($op) is assigned to $rop.

    tanh_F128($rop, $op);
     tanh($op) is assigned to $rop.

    tgamma_F128($rop, $op);
     gamma($op) is assigned to $rop.
     On mingw-w64 compilers, tgammaq() crashes, so for those compilers
     we assign pow(M_Eq, lgamma($op)), ie e**lgamma($op), to $rop.

    trunc_F128($rop, $op);
     trunc($op) is assigned to $rop.

    y0_F128($rop, $op);
     y0($op) is assigned to $rop.

    y1_F128($rop, $op);
     y1($op) is assigned to $rop.

    yn_F128 ($rop, $iv, $op);
     yn($iv, $op) is assigned to $rop.
     $iv should not contain a value that won't fit into a signed int.


=head1 OTHER FUNCTIONS

    $iv = Math::Float128::nnumflag(); # not exported
     Returns the value of the non-numeric flag. This flag is
     initialized to zero, but incemented by 1 whenever a function
     is handed a string containing non-numeric characters. The
     value of the flag therefore tells us how many times functions
     have been handed such a string. The flag can be reset to 0 by
     running Math::Float128::clear_nnum().

    Math::Float128::set_nnum($iv); # not exported
     Resets the global non-numeric flag to the value specified by
     $iv.

    Math::Float128::clear_nnum(); # not exported
     Resets the global non-numeric flag to 0.(Essentially the same
     as running Math::Float128::set_nnum(0).)

    $bool = is_NaNF128($f);
     Returns 1 if $f is a Math::Float128 NaN.
     Else returns 0

    $int = is_InfF128($f)
     If the Math::Float128 object $f is -inf, returns -1.
     If it is +inf, returns 1.
     Otherwise returns 0.

    $int = is_ZeroF128($f);
     If the Math::Float128 object $f is -0, returns -1.
     If it is zero, returns 1.
     Otherwise returns 0.

    $int = cmp2NV($f, $nv);
     $nv can be any perl number - ie NV, UV or IV.
     If the Math::Float128 object $f < $nv returns -1.
     If it is > $nv, returns 1.
     Otherwise returns 0.

    $hex = f128_bytes($f);
     Returns the hex representation of the _float128 value
     as a string of 32 hex characters.

   $iv = Math::Float128::nok_pokflag(); # not exported
    Returns the value of the nok_pok flag. This flag is
    initialized to zero, but incemented by 1 whenever a
    scalar that is both a float (NOK) and string (POK) is passed
    to new() or to an overloaded operator. The value of the flag
    therefore tells us how many times such events occurred . The
    flag can be reset to 0 by running clear_nok_pok().


   Math::Float128::set_nok_pok($iv); # not exported
    Resets the nok_pok flag to the value specified by $iv.

   Math::Float128::clear_nok_pok(); # not exported
    Resets the nok_pok flag to 0.(Essentially the same
    as running set_nok_pok(0).)


=head1 BUGS

   The mingw64 compilers have buggy coshq(), expq(), fmaq(), tgammaq()
   and nearbyintq() functions that crash when called. When a mingw64
   compiler is detected, this module uses workarounds for those problem
   functions. See the documentation (above) for cosh_F128(), exp_F128(),
   fma_F128(), nearbyint_F128() and tgamma_F128() for an outline of the
   workarounds involved.


=head1 LICENSE

   This program is free software; you may redistribute it and/or modify
   it under the same terms as Perl itself.
   Copyright 2013-17 Sisyphus


=head1 AUTHOR

   Sisyphus <sisyphus at(@) cpan dot (.) org>

=cut


