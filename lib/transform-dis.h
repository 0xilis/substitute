#pragma once
#include <stdint.h>
#include <stdbool.h>

int transform_dis_main(const void *restrict code_ptr,
                       void **restrict rewritten_ptr_ptr,
                       uintptr_t pc_patch_start,
                       uintptr_t *pc_patch_end_p,
                       struct arch_dis_ctx *arch_ctx_p,
                       int *offset_by_pcdiff);
