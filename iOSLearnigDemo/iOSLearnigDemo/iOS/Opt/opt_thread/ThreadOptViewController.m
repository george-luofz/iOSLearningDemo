//
//  ThreadOptViewController.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/19.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "ThreadOptViewController.h"
#import <mach/mach.h>
#include <dlfcn.h>
#include <pthread.h>
#include <sys/types.h>
#include <limits.h>
#include <string.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>

#import "BSBacktraceLogger.h"

#define BS_NLIST struct nlist_64
#define DETAG_INSTRUCTION_ADDRESS(A) ((A) & ~(3UL))
#define CALL_INSTRUCTION_FROM_RETURN_ADDRESS(A) (DETAG_INSTRUCTION_ADDRESS((A)) - 1)
#define POINTER_FMT       "0x%016lx"
#define POINTER_SHORT_FMT "0x%lx"

typedef struct BSStackFrameEntry {
    const struct BSStackFrameEntry *const previous;
    const uintptr_t return_address;
} BSStackFrameEntry;


@interface ThreadOptViewController ()

@end

@implementation ThreadOptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self testGetAllThreadStacks];
    BSLOG_ALL;

//    NSLog(@"bb");
}

//#pragma mark - 获取所有线程堆栈
///*
// 1. task_threads通过获取所有线程
// 2. 找到当前线程pc记录
// 3. 通过当前fp，找到上一个线程fp，找到该线程pc
// 4. 循环直到结束
// */
//- (void)testGetAllThreadStacks {
//    thread_act_array_t threads;
//    mach_msg_type_number_t thread_count = 0;
//    const task_t this_task = mach_task_self();
//    
//    kern_return_t kr = task_threads(this_task, &threads, &thread_count);
//    NSMutableString *resultString = [NSMutableString stringWithFormat:@"Call Backtrace of %u threads:\n", thread_count];
//    for(int i = 0; i < thread_count; i++) {
//        [resultString appendString:backtraceOfThread(threads[i])];
//    }
//    NSLog(@"all thread stack: \n %@" ,resultString);
//}
//
//// 找到每个线程得fp、lr
//NSString *backtraceOfThread(thread_t thread) {
//    _STRUCT_MCONTEXT machineContext;
//    mach_msg_type_number_t state_count = ARM_THREAD_STATE64_COUNT;
//    kern_return_t kr = thread_get_state(thread, ARM_THREAD_STATE64, (thread_state_t)&machineContext.__ss, &state_count);
//    if (kr != KERN_SUCCESS) return nil;
//
//    int i = 0;
//    uintptr_t backtraceBuffer[50];
//    NSMutableString *resultString = [[NSMutableString alloc] initWithFormat:@"Backtrace of Thread %u:\n", thread];
//    
//    // pc
//    const uintptr_t instructionAddress = machineContext.__ss.__pc;
//    backtraceBuffer[i] = instructionAddress;
//    ++i;
//    
//    // fp
//    BSStackFrameEntry frame = {0};
//    const uintptr_t framePtr = machineContext.__ss.__fp;
//    if(framePtr == 0 ||
//       bs_mach_copyMem((void *)framePtr, &frame, sizeof(frame)) != KERN_SUCCESS) {
//        return @"Fail to get frame pointer";
//    }
//    
//    // 向上拿到所有
//    for(; i < 50; i++) {
//        backtraceBuffer[i] = frame.return_address;
//        if(backtraceBuffer[i] == 0 ||
//           frame.previous == 0 ||
//           bs_mach_copyMem(frame.previous, &frame, sizeof(frame)) != KERN_SUCCESS) {
//            break;
//        }
//    }
//    
//    // 符号化
//    int backtraceLength = i;
//    Dl_info symbolicated[backtraceLength];
//    bs_symbolicate(backtraceBuffer, symbolicated, backtraceLength, 0);
//    for (int i = 0; i < backtraceLength; ++i) {
//        [resultString appendFormat:@"%@", bs_logBacktraceEntry(i, backtraceBuffer[i], &symbolicated[i])];
//    }
//    [resultString appendFormat:@"\n"];
//    return [resultString copy];
//}
//
//#pragma mark - private
//
//kern_return_t bs_mach_copyMem(const void *const src, void *const dst, const size_t numBytes){
//    vm_size_t bytesCopied = 0;
//    return vm_read_overwrite(mach_task_self(), (vm_address_t)src, (vm_size_t)numBytes, (vm_address_t)dst, &bytesCopied);
//}
//
//#pragma mark Symbolicate
//
//void bs_symbolicate(const uintptr_t* const backtraceBuffer,
//                    Dl_info* const symbolsBuffer,
//                    const int numEntries,
//                    const int skippedEntries){
//    int i = 0;
//    
//    if(!skippedEntries && i < numEntries) {
//        bs_dladdr(backtraceBuffer[i], &symbolsBuffer[i]);
//        i++;
//    }
//    
//    for(; i < numEntries; i++) {
//        bs_dladdr(CALL_INSTRUCTION_FROM_RETURN_ADDRESS(backtraceBuffer[i]), &symbolsBuffer[i]);
//    }
//}
//
//bool bs_dladdr(const uintptr_t address, Dl_info* const info) {
//    info->dli_fname = NULL;
//    info->dli_fbase = NULL;
//    info->dli_sname = NULL;
//    info->dli_saddr = NULL;
//    
//    const uint32_t idx = bs_imageIndexContainingAddress(address);
//    if(idx == UINT_MAX) {
//        return false;
//    }
//    const struct mach_header* header = _dyld_get_image_header(idx);
//    const uintptr_t imageVMAddrSlide = (uintptr_t)_dyld_get_image_vmaddr_slide(idx);
//    const uintptr_t addressWithSlide = address - imageVMAddrSlide;
//    const uintptr_t segmentBase = bs_segmentBaseOfImageIndex(idx) + imageVMAddrSlide;
//    if(segmentBase == 0) {
//        return false;
//    }
//    
//    info->dli_fname = _dyld_get_image_name(idx);
//    info->dli_fbase = (void*)header;
//    
//    // Find symbol tables and get whichever symbol is closest to the address.
//    const BS_NLIST* bestMatch = NULL;
//    uintptr_t bestDistance = ULONG_MAX;
//    uintptr_t cmdPtr = bs_firstCmdAfterHeader(header);
//    if(cmdPtr == 0) {
//        return false;
//    }
//    for(uint32_t iCmd = 0; iCmd < header->ncmds; iCmd++) {
//        const struct load_command* loadCmd = (struct load_command*)cmdPtr;
//        if(loadCmd->cmd == LC_SYMTAB) {
//            const struct symtab_command* symtabCmd = (struct symtab_command*)cmdPtr;
//            const BS_NLIST* symbolTable = (BS_NLIST*)(segmentBase + symtabCmd->symoff);
//            const uintptr_t stringTable = segmentBase + symtabCmd->stroff;
//            
//            for(uint32_t iSym = 0; iSym < symtabCmd->nsyms; iSym++) {
//                // If n_value is 0, the symbol refers to an external object.
//                if(symbolTable[iSym].n_value != 0) {
//                    uintptr_t symbolBase = symbolTable[iSym].n_value;
//                    uintptr_t currentDistance = addressWithSlide - symbolBase;
//                    if((addressWithSlide >= symbolBase) &&
//                       (currentDistance <= bestDistance)) {
//                        bestMatch = symbolTable + iSym;
//                        bestDistance = currentDistance;
//                    }
//                }
//            }
//            if(bestMatch != NULL) {
//                info->dli_saddr = (void*)(bestMatch->n_value + imageVMAddrSlide);
//                info->dli_sname = (char*)((intptr_t)stringTable + (intptr_t)bestMatch->n_un.n_strx);
//                if(*info->dli_sname == '_') {
//                    info->dli_sname++;
//                }
//                // This happens if all symbols have been stripped.
//                if(info->dli_saddr == info->dli_fbase && bestMatch->n_type == 3) {
//                    info->dli_sname = NULL;
//                }
//                break;
//            }
//        }
//        cmdPtr += loadCmd->cmdsize;
//    }
//    return true;
//}
//
//uintptr_t bs_firstCmdAfterHeader(const struct mach_header* const header) {
//    switch(header->magic) {
//        case MH_MAGIC:
//        case MH_CIGAM:
//            return (uintptr_t)(header + 1);
//        case MH_MAGIC_64:
//        case MH_CIGAM_64:
//            return (uintptr_t)(((struct mach_header_64*)header) + 1);
//        default:
//            return 0;  // Header is corrupt
//    }
//}
//
//uint32_t bs_imageIndexContainingAddress(const uintptr_t address) {
//    const uint32_t imageCount = _dyld_image_count();
//    const struct mach_header* header = 0;
//    
//    for(uint32_t iImg = 0; iImg < imageCount; iImg++) {
//        header = _dyld_get_image_header(iImg);
//        if(header != NULL) {
//            // Look for a segment command with this address within its range.
//            uintptr_t addressWSlide = address - (uintptr_t)_dyld_get_image_vmaddr_slide(iImg);
//            uintptr_t cmdPtr = bs_firstCmdAfterHeader(header);
//            if(cmdPtr == 0) {
//                continue;
//            }
//            for(uint32_t iCmd = 0; iCmd < header->ncmds; iCmd++) {
//                const struct load_command* loadCmd = (struct load_command*)cmdPtr;
//                if(loadCmd->cmd == LC_SEGMENT) {
//                    const struct segment_command* segCmd = (struct segment_command*)cmdPtr;
//                    if(addressWSlide >= segCmd->vmaddr &&
//                       addressWSlide < segCmd->vmaddr + segCmd->vmsize) {
//                        return iImg;
//                    }
//                }
//                else if(loadCmd->cmd == LC_SEGMENT_64) {
//                    const struct segment_command_64* segCmd = (struct segment_command_64*)cmdPtr;
//                    if(addressWSlide >= segCmd->vmaddr &&
//                       addressWSlide < segCmd->vmaddr + segCmd->vmsize) {
//                        return iImg;
//                    }
//                }
//                cmdPtr += loadCmd->cmdsize;
//            }
//        }
//    }
//    return UINT_MAX;
//}
//
//uintptr_t bs_segmentBaseOfImageIndex(const uint32_t idx) {
//    const struct mach_header* header = _dyld_get_image_header(idx);
//    
//    // Look for a segment command and return the file image address.
//    uintptr_t cmdPtr = bs_firstCmdAfterHeader(header);
//    if(cmdPtr == 0) {
//        return 0;
//    }
//    for(uint32_t i = 0;i < header->ncmds; i++) {
//        const struct load_command* loadCmd = (struct load_command*)cmdPtr;
//        if(loadCmd->cmd == LC_SEGMENT) {
//            const struct segment_command* segmentCmd = (struct segment_command*)cmdPtr;
//            if(strcmp(segmentCmd->segname, SEG_LINKEDIT) == 0) {
//                return segmentCmd->vmaddr - segmentCmd->fileoff;
//            }
//        }
//        else if(loadCmd->cmd == LC_SEGMENT_64) {
//            const struct segment_command_64* segmentCmd = (struct segment_command_64*)cmdPtr;
//            if(strcmp(segmentCmd->segname, SEG_LINKEDIT) == 0) {
//                return (uintptr_t)(segmentCmd->vmaddr - segmentCmd->fileoff);
//            }
//        }
//        cmdPtr += loadCmd->cmdsize;
//    }
//    return 0;
//}
//
//#pragma mark GenerateBacbsrackEnrty
//NSString* bs_logBacktraceEntry(const int entryNum,
//                               const uintptr_t address,
//                               const Dl_info* const dlInfo) {
//    char faddrBuff[20];
//    char saddrBuff[20];
//    
//    const char* fname = bs_lastPathEntry(dlInfo->dli_fname);
//    if(fname == NULL) {
//        sprintf(faddrBuff, POINTER_FMT, (uintptr_t)dlInfo->dli_fbase);
//        fname = faddrBuff;
//    }
//    
//    uintptr_t offset = address - (uintptr_t)dlInfo->dli_saddr;
//    const char* sname = dlInfo->dli_sname;
//    if(sname == NULL) {
//        sprintf(saddrBuff, POINTER_SHORT_FMT, (uintptr_t)dlInfo->dli_fbase);
//        sname = saddrBuff;
//        offset = address - (uintptr_t)dlInfo->dli_fbase;
//    }
//    return [NSString stringWithFormat:@"%-30s  0x%08" PRIxPTR " %s + %lu\n" ,fname, (uintptr_t)address, sname, offset];
//}
//
//const char* bs_lastPathEntry(const char* const path) {
//    if(path == NULL) {
//        return NULL;
//    }
//    
//    char* lastFile = strrchr(path, '/');
//    return lastFile == NULL ? path : lastFile + 1;
//}

@end
