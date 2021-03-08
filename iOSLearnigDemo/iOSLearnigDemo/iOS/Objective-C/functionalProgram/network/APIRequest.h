//
//  APIRequest.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkRequest.h"

typedef NS_ENUM(NSInteger, NNLogType) {
    NNLogTypeWechat,
    NNLogTypeQQ,
    NNLogTypePhone
};

@interface APIRequest : NSObject

#pragma mark - 云控
+ (NetworkRequest *)requestCloudUpdate:(ResponseBlock)responseBlock;
#pragma mark - 日记本
// 日记列表；首页不传lastId；下页传
+ (NetworkRequest *)requestDiaryList:(NSString *)lastId response:(ResponseBlock)reponseBlock;
// 添加日记: 标题；html内容；位置；天气
+ (NetworkRequest *)addDiaryWithTitle:(NSString *)title content:(NSString *)content location:(NSString *)location weather:(NSString *)weather response:(ResponseBlock)responseBlock;
// 更新日记: 标题；html内容；位置；天气
+ (NetworkRequest *)updateDiaryWithTitle:(NSString *)title content:(NSString *)content location:(NSString *)location weather:(NSString *)weather response:(ResponseBlock)responseBlock;
// 删除日记：日记标识
+ (NetworkRequest *)deleteDiary:(NSString *)diaryId response:(ResponseBlock)responseBlock;
// 上传张图片：上传前客户端做压缩；一次上传多张
+ (NetworkRequest *)uploadImages:(NSArray<UIImage *> *)images response:(ResponseBlock)responseBlock;
#pragma mark - 账本

#pragma mark - 备忘录

#pragma mark - 用户信息
/// 请求用户信息接口
+ (NetworkRequest *)requestUserInfoWithParams:(NSDictionary *)params response:(ResponseBlock)reponseBlock;
// 编辑yoghurt信息
+ (NetworkRequest *)editUserInfo:(NSString *)phone response:(ResponseBlock)reponseBlock;
/// 登录接口: 登录类型；第三方id
+ (NetworkRequest *)loginWithType:(NNLogType)logType thirdId:(NSString *)thirdId response:(ResponseBlock)reponseBlock;
@end
