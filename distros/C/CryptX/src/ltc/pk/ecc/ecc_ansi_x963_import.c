/* LibTomCrypt, modular cryptographic library -- Tom St Denis
 *
 * LibTomCrypt is a library that provides various cryptographic
 * algorithms in a highly modular and flexible manner.
 *
 * The library is free for all purposes without any express
 * guarantee it works.
 */

#include "tomcrypt.h"

/**
  @file ecc_ansi_x963_import.c
  ECC Crypto, Tom St Denis
*/

#ifdef LTC_MECC

/** Import an ANSI X9.63 format public key
  @param in      The input data to read
  @param inlen   The length of the input data
  @param key     [out] destination to store imported key \
*/
int ecc_ansi_x963_import(const unsigned char *in, unsigned long inlen, ecc_key *key)
{
   return ecc_ansi_x963_import_ex(in, inlen, key, NULL);
}

int ecc_ansi_x963_import_ex(const unsigned char *in, unsigned long inlen, ecc_key *key, const ltc_ecc_curve *cu)
{
   int err;

   LTC_ARGCHK(in  != NULL);
   LTC_ARGCHK(key != NULL);

   /* must be odd */
   if ((inlen & 1) == 0) {
      return CRYPT_INVALID_ARG;
   }

   /* initialize key->dp */
   if (cu == NULL) {
      /* this case works only for uncompressed public keys  */
      if ((err = ecc_set_dp_by_size((inlen-1)>>1, key)) != CRYPT_OK)                { return err; }
   }
   else {
      /* this one works for both compressed / uncompressed pubkeys */
      if ((err = ecc_set_dp(cu, key)) != CRYPT_OK)                                  { return err; }
   }

   /* load public key */
   if ((err = ecc_set_key((unsigned char *)in, inlen, PK_PUBLIC, key)) != CRYPT_OK) { return err; }

   /* we're done */
   return CRYPT_OK;
}

#endif

/* ref:         $Format:%D$ */
/* git commit:  $Format:%H$ */
/* commit time: $Format:%ai$ */
