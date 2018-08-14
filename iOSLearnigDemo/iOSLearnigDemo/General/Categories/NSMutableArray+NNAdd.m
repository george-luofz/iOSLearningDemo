//
//  NSMutableArray+NNAdd.m
//  MiaoKan
//
//  Created by baye on 2017/3/23.
//  Copyright © 2017年 YaXie. All rights reserved.
//

#import "NSMutableArray+NNAdd.h"

@implementation NSMutableArray (NNAdd)

- (void)nn_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    if (self == anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)nn_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        return;
    }
    if (!anObject) {
        return;
    }
    if (self == anObject) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)nn_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)nn_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= self.count) {
        return;
    }
    if (!anObject) {
        return;
    }
    if (self == anObject) {
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}


@end
