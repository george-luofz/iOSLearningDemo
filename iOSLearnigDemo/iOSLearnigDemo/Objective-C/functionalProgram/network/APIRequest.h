//
//  APIRequest.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequest.h"

@interface APIRequest : NSObject

+ (NetworkRequest *)requestUserInfoWithParams:(NSDictionary *)params response:(ResponseBlock)reponseBlock;

@end
