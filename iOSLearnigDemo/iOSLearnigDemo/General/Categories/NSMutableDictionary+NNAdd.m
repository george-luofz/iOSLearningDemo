//
//  NSMutableDictionary+NNAdd.m
//  MiaoKan
//
//  Created by baye on 2017/3/23.
//  Copyright © 2017年 YaXie. All rights reserved.
//

#import "NSMutableDictionary+NNAdd.h"

@implementation NSMutableDictionary (NNAdd)

- (void)nn_setObject:(id)anObject forKey:(NSString *)aKey {
    if (!aKey.length) {
        return;
    }
    if (self == anObject) {
        return;
    }
    [self setValue:anObject forKey:aKey];
}

@end
