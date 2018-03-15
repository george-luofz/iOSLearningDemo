//
//  blockTest.c
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/15.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#include "blockTest.h"

void test_block(){
    int a = 0;
    printf("block before:%p",&a);
    void (^func)(void) = ^{
        printf("block in:%p",&a);
    };
    printf("block after:%p",&a);
    func();
}
