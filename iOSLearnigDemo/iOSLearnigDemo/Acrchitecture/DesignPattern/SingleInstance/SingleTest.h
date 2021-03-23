//
//  SingleTest.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2021/3/23.
//  Copyright © 2021 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SingleTest : NSObject

+ (instancetype)shareInstance;

+(instancetype) alloc __attribute__((unavailable("replace with 'sharedInstance'")));

+(instancetype) new __attribute__((unavailable("replace with 'sharedInstance'")));

-(instancetype) copy __attribute__((unavailable("replace with 'sharedInstance'")));

-(instancetype) mutableCopy __attribute__((unavailable("replace with 'sharedInstance'")));


@end

NS_ASSUME_NONNULL_END
