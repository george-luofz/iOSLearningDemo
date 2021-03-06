//
//  FZProxy.h
//  iOSLearnigDemo
//
//  Created by george_luo on 2021/3/8.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FZProxy : NSProxy
@property (nonatomic, strong) NSObject *obj;

-(void)transformToObject:(NSObject *)obj;

@end

NS_ASSUME_NONNULL_END
