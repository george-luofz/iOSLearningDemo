//
//  NSArray+NNAdd.m
//  MiaoKan
//
//  Created by baye on 2017/3/23.
//  Copyright © 2017年 YaXie. All rights reserved.
//

#import "NSArray+NNAdd.h"

@implementation NSArray (NNAdd)

- (id)nn_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
