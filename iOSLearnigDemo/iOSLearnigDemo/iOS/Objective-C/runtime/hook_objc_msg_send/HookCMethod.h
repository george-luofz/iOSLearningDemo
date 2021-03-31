//
//  HookCMethod.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/30.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#ifndef HookCMethod_h
#define HookCMethod_h

#include <stdio.h>
struct rebinding {
    const char *name;
    void *replacement;
    void **replaced;
};

struct rebindings_entry {
    struct rebinding *rebindings;
    size_t rebindings_nel;
    struct rebindings_entry *next;
};

#endif /* HookCMethod_h */
