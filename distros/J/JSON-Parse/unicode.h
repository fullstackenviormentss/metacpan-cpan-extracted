/*
This file was generated by the following command:

/home/ben/software/install/bin/cfunctions unicode.c

*/
#ifndef CFH_UNICODE_H
#define CFH_UNICODE_H

#line 8 "unicode.c"
#define UTF8_MAX_LENGTH 5
#define UNICODE_MAXIMUM 0x10ffff
#define UNICODE_UTF8_4 0x1fffff
#define UNICODE_OK 0
#define UTF8_BAD_LEADING_BYTE -1
#define UNICODE_SURROGATE_PAIR -2
#define UNICODE_NOT_SURROGATE_PAIR -3
#define UTF8_BAD_CONTINUATION_BYTE -4
#define UNICODE_EMPTY_INPUT -5
#define UTF8_NON_SHORTEST -6
#define UNICODE_TOO_BIG -7
#define UNICODE_NOT_CHARACTER -8
#define UTF8_VALID 1
#define UTF8_INVALID 0

#line 98 "unicode.c"
extern const uint8_t utf8_sequence_len[];

#line 103 "unicode.c"
int32_t utf8_bytes (unsigned char c);

#line 124 "unicode.c"
int32_t utf8_no_checks (const unsigned char* input, const unsigned char** end_ptr);

#line 159 "unicode.c"
int32_t utf8_to_ucs2 (const unsigned char* input, const unsigned char** end_ptr);

#line 248 "unicode.c"
int32_t ucs2_to_utf8 (int32_t ucs2, unsigned char* utf8);

#line 293 "unicode.c"
int32_t unicode_to_surrogates (unsigned unicode, int32_t* hi_ptr, int32_t* lo_ptr);

#line 312 "unicode.c"
int32_t surrogates_to_unicode (int32_t hi, int32_t lo);

#line 334 "unicode.c"
int32_t surrogate_to_utf8 (int32_t hi, int32_t lo, unsigned char* utf8);

#line 347 "unicode.c"
int32_t unicode_chars_to_bytes (const unsigned char* utf8, int32_t n_chars);

#line 366 "unicode.c"
int32_t unicode_count_chars_fast (const unsigned char* utf8);

#line 387 "unicode.c"
int32_t unicode_count_chars (const unsigned char* utf8);

#line 410 "unicode.c"
#define BYTE_80_8F							\
    0x80: case 0x81: case 0x82: case 0x83: case 0x84: case 0x85: case 0x86: \
 case 0x87: case 0x88: case 0x89: case 0x8A: case 0x8B: case 0x8C: case 0x8D: \
 case 0x8E: case 0x8F
#define BYTE_80_9F							\
    0x80: case 0x81: case 0x82: case 0x83: case 0x84: case 0x85: case 0x86: \
 case 0x87: case 0x88: case 0x89: case 0x8A: case 0x8B: case 0x8C: case 0x8D: \
 case 0x8E: case 0x8F: case 0x90: case 0x91: case 0x92: case 0x93: case 0x94: \
 case 0x95: case 0x96: case 0x97: case 0x98: case 0x99: case 0x9A: case 0x9B: \
 case 0x9C: case 0x9D: case 0x9E: case 0x9F
#define BYTE_80_BF							\
    0x80: case 0x81: case 0x82: case 0x83: case 0x84: case 0x85: case 0x86: \
 case 0x87: case 0x88: case 0x89: case 0x8A: case 0x8B: case 0x8C: case 0x8D: \
 case 0x8E: case 0x8F: case 0x90: case 0x91: case 0x92: case 0x93: case 0x94: \
 case 0x95: case 0x96: case 0x97: case 0x98: case 0x99: case 0x9A: case 0x9B: \
 case 0x9C: case 0x9D: case 0x9E: case 0x9F: case 0xA0: case 0xA1: case 0xA2: \
 case 0xA3: case 0xA4: case 0xA5: case 0xA6: case 0xA7: case 0xA8: case 0xA9: \
 case 0xAA: case 0xAB: case 0xAC: case 0xAD: case 0xAE: case 0xAF: case 0xB0: \
 case 0xB1: case 0xB2: case 0xB3: case 0xB4: case 0xB5: case 0xB6: case 0xB7: \
 case 0xB8: case 0xB9: case 0xBA: case 0xBB: case 0xBC: case 0xBD: case 0xBE: \
 case 0xBF
#define BYTE_90_BF							\
    0x90: case 0x91: case 0x92: case 0x93: case 0x94: case 0x95: case 0x96: \
 case 0x97: case 0x98: case 0x99: case 0x9A: case 0x9B: case 0x9C: case 0x9D: \
 case 0x9E: case 0x9F: case 0xA0: case 0xA1: case 0xA2: case 0xA3: case 0xA4: \
 case 0xA5: case 0xA6: case 0xA7: case 0xA8: case 0xA9: case 0xAA: case 0xAB: \
 case 0xAC: case 0xAD: case 0xAE: case 0xAF: case 0xB0: case 0xB1: case 0xB2: \
 case 0xB3: case 0xB4: case 0xB5: case 0xB6: case 0xB7: case 0xB8: case 0xB9: \
 case 0xBA: case 0xBB: case 0xBC: case 0xBD: case 0xBE: case 0xBF
#define BYTE_A0_BF							\
    0xA0: case 0xA1: case 0xA2: case 0xA3: case 0xA4: case 0xA5: case 0xA6: \
 case 0xA7: case 0xA8: case 0xA9: case 0xAA: case 0xAB: case 0xAC: case 0xAD: \
 case 0xAE: case 0xAF: case 0xB0: case 0xB1: case 0xB2: case 0xB3: case 0xB4: \
 case 0xB5: case 0xB6: case 0xB7: case 0xB8: case 0xB9: case 0xBA: case 0xBB: \
 case 0xBC: case 0xBD: case 0xBE: case 0xBF
#define BYTE_C2_DF							\
    0xC2: case 0xC3: case 0xC4: case 0xC5: case 0xC6: case 0xC7: case 0xC8: \
 case 0xC9: case 0xCA: case 0xCB: case 0xCC: case 0xCD: case 0xCE: case 0xCF: \
 case 0xD0: case 0xD1: case 0xD2: case 0xD3: case 0xD4: case 0xD5: case 0xD6: \
 case 0xD7: case 0xD8: case 0xD9: case 0xDA: case 0xDB: case 0xDC: case 0xDD: \
 case 0xDE: case 0xDF
#define BYTE_E1_EC							\
    0xE1: case 0xE2: case 0xE3: case 0xE4: case 0xE5: case 0xE6: case 0xE7: \
 case 0xE8: case 0xE9: case 0xEA: case 0xEB: case 0xEC
#define BYTE_EE_EF				\
    0xEE: case 0xEF
#define BYTE_F1_F3				\
    0xF1: case 0xF2: case 0xF3

#line 474 "unicode.c"
int32_t valid_utf8 (const unsigned char* input, int32_t input_length);

#line 611 "unicode.c"
int32_t trim_to_utf8_start (unsigned char** ptr);

#line 632 "unicode.c"
const char* code_to_error (int32_t code);

#line 668 "unicode.c"

#ifdef TEST
void print_bytes (const unsigned char* bytes);

#line 679 "unicode.c"
void test_ucs2_to_utf8 ();

#endif /* def TEST */

#endif /* CFH_UNICODE_H */
