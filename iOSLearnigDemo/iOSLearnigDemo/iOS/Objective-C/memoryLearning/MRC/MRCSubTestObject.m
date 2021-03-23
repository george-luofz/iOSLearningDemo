//
//  MRCSubTestObject.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MRCSubTestObject.h"

@implementation MRCSubTestObject

- (void)setData:(NSData *)data{
//    self.data = data;/
    NSString *str = [NSString stringWithFormat:@"%@",_baseObj];
}

- (void)dealloc{
//    self.data = nil;
    [super dealloc];
    
}
@end
