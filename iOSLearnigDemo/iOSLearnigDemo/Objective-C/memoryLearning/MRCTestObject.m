//
//  MRCTestObject.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/3/29.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "MRCTestObject.h"

@implementation MRCTestObject

- (void)dealloc{
    self.data = nil;
    [super dealloc];
}
@end
