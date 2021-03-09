//
//  TestClass.m
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import "TestClass.h"
#import "BlockObj.h"

typedef void(^Block) (void);

@interface TestClass()
@property (nonatomic, assign) int globalCount;
@property (nonatomic, copy) void(^blocks)(int);
@end

@implementation TestClass

int b = 20;

- (void)testMethods {
    // 1.__block / static / auto / global
    int autoCount = 1;
    self.globalCount = 30;
    static int staticCount = 20;
    __block int blockCount = 10;
    void (^blockA)(int a) = ^(int a) {
        NSLog(@"%d,%d,%d,%d,%d",a,blockCount,staticCount,autoCount, self.globalCount);
    };
    
    if (blockA) {
        blockA(1990);
    }

    // 没有访问auto变量global block
    int a = 10;
    __unsafe_unretained void (^blockSize)(void) = ^ {
//        NSLog(@"%d,%d",1,a);
        int c = a+1;
    };
    
    NSLog(@"%@",blockSize);
    
}

// 1. block 类型
// gloable 没有访问auto和全局变量
// stack 访问auto（测试都是malloc，arc自动copy）
// malloc

#pragma mark - 栈block
/*
struct __block_impl {
  void *isa;
  int Flags;
  int Reserved;
  void *FuncPtr;
};

// @implementation TestClass


struct __TestClass__testMethods_block_impl_0 {
  struct __block_impl impl;
  struct __TestClass__testMethods_block_desc_0* Desc;
  __TestClass__testMethods_block_impl_0(void *fp, struct __TestClass__testMethods_block_desc_0 *desc, int flags=0) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __TestClass__testMethods_block_func_0(struct __TestClass__testMethods_block_impl_0 *__cself, int a) {

        NSLog((NSString *)&__NSConstantStringImpl__var_folders__d_s5d63yjs45dc9d2g4vmn4kk00000gn_T_TestClass_bf0183_mi_0,a);
    }

static struct __TestClass__testMethods_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __TestClass__testMethods_block_desc_0_DATA = { 0, sizeof(struct __TestClass__testMethods_block_impl_0)};

static void _I_TestClass_testMethods(TestClass * self, SEL _cmd) {
    void (*blockA)(int a) = ((void (*)(int))&__TestClass__testMethods_block_impl_0((void *)__TestClass__testMethods_block_func_0, &__TestClass__testMethods_block_desc_0_DATA));
    if (blockA) {
        ((void (*)(__block_impl *, int))((__block_impl *)blockA)->FuncPtr)((__block_impl *)blockA, 1990);
    }
}

 @end
*/

#pragma mark - block int变量捕获

/*
struct __TestClass__testMethods_block_impl_0 {
  struct __block_impl impl;
  struct __TestClass__testMethods_block_desc_0* Desc;
  int count;
  __TestClass__testMethods_block_impl_0(void *fp, struct __TestClass__testMethods_block_desc_0 *desc, int _count, int flags=0) : count(_count) {
    impl.isa = &_NSConcreteStackBlock;
    impl.Flags = flags;
    impl.FuncPtr = fp;
    Desc = desc;
  }
};
static void __TestClass__testMethods_block_func_0(struct __TestClass__testMethods_block_impl_0 *__cself, int a) {
  int count = __cself->count; // bound by copy

        NSLog((NSString *)&__NSConstantStringImpl__var_folders__d_s5d63yjs45dc9d2g4vmn4kk00000gn_T_TestClass_48a64d_mi_0,a,count);
    }

static struct __TestClass__testMethods_block_desc_0 {
  size_t reserved;
  size_t Block_size;
} __TestClass__testMethods_block_desc_0_DATA = { 0, sizeof(struct __TestClass__testMethods_block_impl_0)};

static void _I_TestClass_testMethods(TestClass * self, SEL _cmd) {
    int count = 10;
    void (*blockA)(int a) = ((void (*)(int))&__TestClass__testMethods_block_impl_0((void *)__TestClass__testMethods_block_func_0, &__TestClass__testMethods_block_desc_0_DATA, count));
    if (blockA) {
        ((void (*)(__block_impl *, int))((__block_impl *)blockA)->FuncPtr)((__block_impl *)blockA, 1990);
    }
}
*/

#pragma mark - __block
/*
 struct __Block_byref_count_0 {
   void *__isa;
 __Block_byref_count_0 *__forwarding;
  int __flags;
  int __size;
  int count;
 };

 struct __TestClass__testMethods_block_impl_0 {
   struct __block_impl impl;
   struct __TestClass__testMethods_block_desc_0* Desc;
   __Block_byref_count_0 *count; // by ref
 // _count->__forwarding 自动赋值给_count成员
   __TestClass__testMethods_block_impl_0(void *fp, struct __TestClass__testMethods_block_desc_0 *desc, __Block_byref_count_0 *_count, int flags=0) : count(_count->__forwarding) {
     impl.isa = &_NSConcreteStackBlock;
     impl.Flags = flags;
     impl.FuncPtr = fp;
     Desc = desc;
   }
 };
 static void __TestClass__testMethods_block_func_0(struct __TestClass__testMethods_block_impl_0 *__cself, int a) {
   __Block_byref_count_0 *count = __cself->count; // bound by ref

         NSLog((NSString *)&__NSConstantStringImpl__var_folders__d_s5d63yjs45dc9d2g4vmn4kk00000gn_T_TestClass_5c6ae3_mi_0,a,(count->__forwarding->count));
     }
 static void __TestClass__testMethods_block_copy_0(struct __TestClass__testMethods_block_impl_0*dst, struct __TestClass__testMethods_block_impl_0*src) {_Block_object_assign((void*)&dst->count, (void*)src->count, 8);}

 static void __TestClass__testMethods_block_dispose_0(struct __TestClass__testMethods_block_impl_0*src) {_Block_object_dispose((void*)src->count, 8;}

 static struct __TestClass__testMethods_block_desc_0 {
   size_t reserved;
   size_t Block_size;
   void (*copy)(struct __TestClass__testMethods_block_impl_0*, struct __TestClass__testMethods_block_impl_0*);
   void (*dispose)(struct __TestClass__testMethods_block_impl_0*);
 } __TestClass__testMethods_block_desc_0_DATA = { 0, sizeof(struct __TestClass__testMethods_block_impl_0), __TestClass__testMethods_block_copy_0, __TestClass__testMethods_block_dispose_0};

 static void _I_TestClass_testMethods(TestClass * self, SEL _cmd) {
     __attribute__((__blocks__(byref))) __Block_byref_count_0 count = {(void*)0,(__Block_byref_count_0 *)&count, 0, sizeof(__Block_byref_count_0), 10};
     void (*blockA)(int a) = ((void (*)(int))&__TestClass__testMethods_block_impl_0((void *)__TestClass__testMethods_block_func_0, &__TestClass__testMethods_block_desc_0_DATA, (__Block_byref_count_0 *)&count, 570425344));
     if (blockA) {
         ((void (*)(__block_impl *, int))((__block_impl *)blockA)->FuncPtr)((__block_impl *)blockA, 1990);
     }
 }
 // @end
 */

#pragma mark - block copy操作


@end
