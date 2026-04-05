# SPDX-License-Identifier: Apache-2.0
# Copyright 2020 Western Digital Corporation or its affiliates.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
// startup code to support HLL programs

#include "defines.h"

.section .text.init
.global _start
_start:

// enable caching, except region 0xd
        li t0, 0x59555555
        csrw 0x7c0, t0

// wyj
// #define ENABLE_PERF_MON 1
#if defined(ENABLE_PERF_MON)
// #define PERF_MON_NOEVENT_CLK_ACTIVE
// #define PERF_MON_ICACHE
// #define PERF_MON_INST_COMMIT
// #define PERF_MON_INST_ALIGNED_DECODED
// #define PERF_MON_INST_LOAD_STORE
// #define PERF_MON_INST_CALC
// #define PERF_MON_INST_CSR
// #define PERF_MON_INST_EBREAK_ECALL_MRET
// #define PERF_MON_INST_FENCE
// #define PERF_MON_BRANCH
// #define PERF_MON_FRONTEND_STALL
// #define PERF_MON_SYNC_STALL
// #define PERF_MON_LSU_DMA_STALL
// #define PERF_MON_EXC_INT
// #define PERF_MON_FLUSH_LOWER
// #define PERF_MON_BR_ERROR
// #define PERF_MON_BUS_TRANS
// #define PERF_MON_BUS_ERROR_STALL
// #define PERF_MON_INT_DISABLED_STALLED
#endif

// wyj
#if defined(ENABLE_PERF_MON)
#if defined(PERF_MON_NOEVENT_CLK_ACTIVE)
        li      x1, 0       // `define MHPME_NOEVENT         6'd0
        li      x2, 1       // `define MHPME_CLK_ACTIVE      6'd1
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_ICACHE)
        li      x1, 2       // `define MHPME_ICACHE_HIT      6'd2
        li      x2, 3       // `define MHPME_ICACHE_MISS     6'd3
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_COMMIT)
        li      x1, 4       // `define MHPME_INST_COMMIT     6'd4
        li      x2, 5       // `define MHPME_INST_COMMIT_16B 6'd5
        li      x3, 6       // `define MHPME_INST_COMMIT_32B 6'd6
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_ALIGNED_DECODED)
        li      x1, 7       // `define MHPME_INST_ALIGNED    6'd7
        li      x2, 8       // `define MHPME_INST_DECODED    6'd8
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_LOAD_STORE)
        li      x1, 11      // `define MHPME_INST_LOAD       6'd11
        li      x2, 12      // `define MHPME_INST_STORE      6'd12
        li      x3, 13      // `define MHPME_INST_MALOAD     6'd13
        li      x4, 14      // `define MHPME_INST_MASTORE    6'd14
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_CALC)
        li      x1, 15      // `define MHPME_INST_ALU        6'd15
        li      x2, 9       // `define MHPME_INST_MUL        6'd9
        li      x3, 10      // `define MHPME_INST_DIV        6'd10
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_CSR)
        li      x1, 16      // `define MHPME_INST_CSRREAD    6'd16
        li      x2, 17      // `define MHPME_INST_CSRRW      6'd17
        li      x3, 18      // `define MHPME_INST_csrw ITE   6'd18
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_EBREAK_ECALL_MRET)
        li      x1, 19      // `define MHPME_INST_EBREAK     6'd19
        li      x2, 20      // `define MHPME_INST_ECALL      6'd20
        li      x3, 23      // `define MHPME_INST_MRET       6'd23
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INST_FENCE)
        li      x1, 21      // `define MHPME_INST_FENCE      6'd21
        li      x2, 22      // `define MHPME_INST_FENCEI     6'd22
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_BRANCH)
        li      x1, 24      // `define MHPME_INST_BRANCH     6'd24
        li      x2, 25      // `define MHPME_BRANCH_MP       6'd25
        li      x3, 26      // `define MHPME_BRANCH_TAKEN    6'd26
        li      x4, 27      // `define MHPME_BRANCH_NOTP     6'd27
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_FRONTEND_STALL)
        li      x1, 28      // `define MHPME_FETCH_STALL     6'd28
        li      x2, 29      // `define MHPME_ALGNR_STALL     6'd29
        li      x3, 30      // `define MHPME_DECODE_STALL    6'd30
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_SYNC_STALL)
        li      x1, 31      // `define MHPME_POSTSYNC_STALL  6'd31
        li      x2, 32      // `define MHPME_PRESYNC_STALL   6'd32
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_LSU_DMA_STALL)
        li      x1, 33      // `define MHPME_LSU_FREEZE      6'd33
        li      x2, 34      // `define MHPME_LSU_SB_WB_STALL 6'd34
        li      x3, 35      // `define MHPME_DMA_DCCM_STALL  6'd35
        li      x4, 36      // `define MHPME_DMA_ICCM_STALL  6'd36
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_EXC_INT)
        li      x1, 37      // `define MHPME_EXC_TAKEN       6'd37
        li      x2, 38      // `define MHPME_TIMER_INT_TAKEN 6'd38
        li      x3, 39      // `define MHPME_EXT_INT_TAKEN   6'd39
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_FLUSH_LOWER)
        li      x1, 40      // `define MHPME_FLUSH_LOWER     6'd40
        li      x2, 0
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_BR_ERROR)
        li      x1, 41      // `define MHPME_BR_ERROR        6'd41
        li      x2, 0
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_BUS_TRANS)
        li      x1, 42      // `define MHPME_IBUS_TRANS      6'd42
        li      x2, 43      // `define MHPME_DBUS_TRANS      6'd43
        li      x3, 44      // `define MHPME_DBUS_MA_TRANS   6'd44
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_BUS_ERROR_STALL)
        li      x1, 45      // `define MHPME_IBUS_ERROR      6'd45
        li      x2, 46      // `define MHPME_DBUS_ERROR      6'd46
        li      x3, 47      // `define MHPME_IBUS_STALL      6'd47
        li      x4, 48      // `define MHPME_DBUS_STALL      6'd48
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#elif defined(PERF_MON_INT_DISABLED_STALLED)
        li      x1, 49      // `define MHPME_INT_DISABLED    6'd49
        li      x2, 50      // `define MHPME_INT_STALLED     6'd50
        li      x3, 0
        li      x4, 0
        csrw    0x323, x1
        csrw    0x324, x2
        csrw    0x325, x3
        csrw    0x326, x4
#else
        // No PERF_MON_xxx selected: do nothing
#endif
#endif

        la sp, STACK

        call main


.global _finish
_finish:
        la t0, tohost
        li t1, 0xff
        sb t1, 0(t0) // DemoTB test termination
        li t1, 1
        sw t1, 0(t0) // Whisper test termination
        beq x0, x0, _finish
        .rept 10
        nop
        .endr

.section .data.io
.global tohost
tohost: .word 0

