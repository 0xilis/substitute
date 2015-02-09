#pragma once
#include <stdint.h>
#include <stdbool.h>
#include stringify(TARGET_DIR/arch-dis.h)

bool jump_dis_main(void *code_ptr, uintptr_t pc_patch_start, uintptr_t pc_patch_end,
                   struct arch_dis_ctx initial_dis_ctx);
