#include "spvm_block.h"
#include "spvm_list.h"
#include "spvm_compiler_allocator.h"
#include "spvm_compiler.h"

SPVM_BLOCK* SPVM_BLOCK_new(SPVM_COMPILER* compiler) {
  SPVM_BLOCK* block = SPVM_COMPILER_ALLOCATOR_alloc_memory_pool(compiler, compiler->allocator, sizeof(SPVM_BLOCK));
  
  return block;
}
