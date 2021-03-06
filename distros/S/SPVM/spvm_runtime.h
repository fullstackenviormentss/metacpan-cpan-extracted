#ifndef SPVM_RUNTIME_H
#define SPVM_RUNTIME_H

#include "spvm_base.h"
#include "spvm_api.h"

#define SPVM_RUNTIME_C_OBJECT_HEADER_BYTE_SIZE sizeof(SPVM_OBJECT)
#define SPVM_RUNTIME_C_OBJECT_TYPE_ID_BYTE_OFFSET ((int32_t)offsetof(SPVM_OBJECT, type_id))
#define SPVM_RUNTIME_C_OBJECT_LENGTH_BYTE_OFFSET ((int32_t)offsetof(SPVM_OBJECT, length))
#define SPVM_RUNTIME_C_OBJECT_REF_COUNT_BYTE_OFFSET ((int32_t)offsetof(SPVM_OBJECT, ref_count))
#define SPVM_RUNTIME_C_RUNTIME_EXCEPTION_BYTE_OFFSET ((int32_t)offsetof(SPVM_RUNTIME, exception))

#define SPVM_RUNTIME_C_INLINE_GET_REF_COUNT(object) ((*(SPVM_API_int*)((intptr_t)object + SPVM_RUNTIME_C_OBJECT_REF_COUNT_BYTE_OFFSET)))
#define SPVM_RUNTIME_C_INLINE_INC_REF_COUNT_ONLY(object) ((*(SPVM_API_int*)((intptr_t)object + SPVM_RUNTIME_C_OBJECT_REF_COUNT_BYTE_OFFSET))++)
#define SPVM_RUNTIME_C_INLINE_INC_REF_COUNT(object)\
do {\
  if (object != NULL) {\
    SPVM_RUNTIME_C_INLINE_INC_REF_COUNT_ONLY(object);\
  }\
} while (0)\

#define SPVM_RUNTIME_C_INLINE_DEC_REF_COUNT_ONLY(object) ((*(SPVM_API_int*)((intptr_t)object + SPVM_RUNTIME_C_OBJECT_REF_COUNT_BYTE_OFFSET))--)
#define SPVM_RUNTIME_C_INLINE_DEC_REF_COUNT(object)\
do {\
  if (object != NULL) {\
    if (SPVM_RUNTIME_C_INLINE_GET_REF_COUNT(object) > 1) { SPVM_RUNTIME_C_INLINE_DEC_REF_COUNT_ONLY(object); }\
    else { api->dec_ref_count(api, object); }\
  }\
} while (0)\

#define SPVM_RUNTIME_C_INLINE_ISWEAK(object) ((intptr_t)object & 1)
#define SPVM_RUNTIME_C_INLINE_OBJECT_ASSIGN(dist_ptr, source) \
do {\
  SPVM_API_OBJECT* tmp_object = source;\
  if (tmp_object != NULL) {\
    SPVM_RUNTIME_C_INLINE_INC_REF_COUNT_ONLY(tmp_object);\
  }\
  if (*(SPVM_API_OBJECT**)(dist_ptr) != NULL) {\
    if (SPVM_RUNTIME_C_INLINE_ISWEAK(*(SPVM_API_OBJECT**)(dist_ptr))) { api->unweaken(api, (SPVM_API_OBJECT**)dist_ptr); }\
    if (SPVM_RUNTIME_C_INLINE_GET_REF_COUNT(*(SPVM_API_OBJECT**)(dist_ptr)) > 1) { SPVM_RUNTIME_C_INLINE_DEC_REF_COUNT_ONLY(*(SPVM_API_OBJECT**)(dist_ptr)); }\
    else { api->dec_ref_count(api, *(SPVM_API_OBJECT**)(dist_ptr)); }\
  }\
  *(SPVM_API_OBJECT**)(dist_ptr) = tmp_object;\
} while (0)\


struct SPVM_runtime {
  // API
  SPVM_API* api;
  
  // Compiler
  SPVM_COMPILER* compiler;
  
  // Runtime memory allocator
  SPVM_RUNTIME_ALLOCATOR* allocator;
  
  // Exception
  SPVM_OBJECT* exception;
  
  // Package variables
  SPVM_API_VALUE* package_vars;
  
  int32_t objects_count;
};

SPVM_RUNTIME* SPVM_RUNTIME_new();
void SPVM_RUNTIME_free(SPVM_RUNTIME* runtime);
SPVM_API* SPVM_RUNTIME_new_api(SPVM_RUNTIME* runtime);

SPVM_API_VALUE SPVM_RUNTIME_call_sub(SPVM_API* api, int32_t sub_id, SPVM_API_VALUE* args);

SPVM_API_VALUE SPVM_RUNTIME_call_sub_vm(SPVM_API* api, int32_t sub_id, SPVM_API_VALUE* args);
SPVM_API_VALUE SPVM_RUNTIME_call_sub_native(SPVM_API* api, int32_t sub_id, SPVM_API_VALUE* args);
SPVM_API_VALUE SPVM_RUNTIME_call_sub_jit(SPVM_API* api, int32_t sub_id, SPVM_API_VALUE* args);

#endif
