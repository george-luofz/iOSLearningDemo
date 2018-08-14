//
//  NSMutableArray+NNAdd.h
//  MiaoKan
//
//  Created by baye on 2017/3/23.
//  Copyright © 2017年 YaXie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray <ObjectType> (NNAdd)

- (void)nn_addObject:(ObjectType)anObject;
- (void)nn_insertObject:(ObjectType)anObject atIndex:(NSUInteger)index;
- (void)nn_removeObjectAtIndex:(NSUInteger)index;
- (void)nn_replaceObjectAtIndex:(NSUInteger)index withObject:(ObjectType)anObject;

@end
