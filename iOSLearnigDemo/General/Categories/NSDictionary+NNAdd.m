//
//  NSDictionary+MKAdd.m
//  MiaoKan
//
//  Created by baye on 2017/3/28.
//  Copyright © 2017年 YaXie. All rights reserved.
//

#import "NSDictionary+NNAdd.h"

@implementation NSDictionary (NNAdd)

- (NSData *)nn_jsonData {
    return [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
}

- (NSString *)nn_jsonString {
    return [[NSString alloc] initWithData:self.nn_jsonData encoding:NSUTF8StringEncoding];
}

@end
