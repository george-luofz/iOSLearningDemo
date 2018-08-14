//
//  APIRequest.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "APIRequest.h"

@implementation APIRequest

+ (NetworkRequest *)requestCloudUpdate:(ResponseBlock)responseBlock{
    return NetWorkRequest().URL(@"cloudupdate").GET.response(responseBlock);
}
#pragma mark - user
+ (NetworkRequest *)requestUserInfoWithParams:(NSDictionary *)params response:(ResponseBlock)reponseBlock{
    return NetWorkRequest().URL(@"userinfo").POST.params(params).response(reponseBlock);
}
+ (NetworkRequest *)editUserInfo:(NSString *)phone response:(ResponseBlock)reponseBlock{
//    return NetWorkRequest().URL(@"userinfo").POST.params(params).response(reponseBlock);
    return nil;
}
+ (NetworkRequest *)loginWithType:(NNLogType)logType thirdId:(NSString *)thirdId response:(ResponseBlock)reponseBlock{
    return NetWorkRequest().URL(@"login").POST.params(@{@"logtype":@(logType),@"thirdid":thirdId?:@""}).URL(@"").response(reponseBlock);
}

#pragma mark - 日记本
+ (NetworkRequest *)requestDiaryList:(NSString *)lastId response:(ResponseBlock)reponseBlock{
    if(!lastId) return NetWorkRequest().GET.URL(@"diary/list").response(reponseBlock);
    return NetWorkRequest().URL(@"diary/list").POST.params(@{@"lastid":lastId?:@""}).response(reponseBlock);
}
// 添加日记: 标题；html内容；位置；天气
+ (NetworkRequest *)addDiaryWithTitle:(NSString *)title content:(NSString *)content location:(NSString *)location weather:(NSString *)weather response:(ResponseBlock)responseBlock{
    return NetWorkRequest().URL(@"diary/add").POST.params(@{@"title":title?:@"",@"content":content?:@""}).response(responseBlock);
}
// 更新日记: 标题；html内容；位置；天气
+ (NetworkRequest *)updateDiaryWithTitle:(NSString *)title content:(NSString *)content location:(NSString *)location weather:(NSString *)weather response:(ResponseBlock)responseBlock{
    return NetWorkRequest().URL(@"diary/add").POST.params(@{@"title":title?:@"",@"content":content?:@""}).response(responseBlock);
}
// 删除日记：日记标识
+ (NetworkRequest *)deleteDiary:(NSString *)diaryId response:(ResponseBlock)responseBlock{
    return NetWorkRequest().URL(@"diary/del").POST.params(@{@"diaryid":diaryId?:@""}).response(responseBlock);
}
// 上传张图片：上传前客户端做压缩；一次上传多张
+ (NetworkRequest *)uploadImages:(NSArray<UIImage *> *)images response:(ResponseBlock)responseBlock{
    // TODO: do something
    return NetWorkRequest().URL(@"image/upload").POST.params(@{@"image":images?:@""}).response(responseBlock);
}
@end
