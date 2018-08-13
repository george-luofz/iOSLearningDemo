//
//  APIRequest.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "APIRequest.h"

@implementation APIRequest

+ (NetworkRequest *)requestUserInfoWithParams:(NSDictionary *)params response:(ResponseBlock)reponseBlock{
    return NetWorkRequest().POST.params(@{@"key1":@"value1",@"key2":@"value2"}).URL(@"https://www.baidu.com/").response(reponseBlock);
}

@end
