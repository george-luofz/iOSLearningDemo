//
//  NetworkRequest.h
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ResponseBlock)(NSError *error, id responseObject);
typedef void(^ProgressBlock)(NSProgress *progress);
typedef NSData*(^UploadBlock)(void);

typedef NS_ENUM(NSInteger, MKRequestType) {
    MKRequestTypeJSON,
    MKRequestTypeUpload,
    MKRequestTypeDownload
};
@class NetworkRequest;
NetworkRequest *NetWorkRequest(void);

@interface NetworkRequest : NSObject

@property (nonatomic) MKRequestType requestType;
@property (nonatomic, copy) NSString *httpMethod;
@property (nonatomic, copy, readonly) NSString *urlString;
@property (nonatomic, copy, readonly) NSDictionary *parameters;

@property (nonatomic, class, readonly) NSURLSession *session;

// 取消请求时，是否调用回调block，默认为false
@property (nonatomic) BOOL callbackWhenCancelled;

//- (NetworkRequest *(^)(void))NetworkRequest;

- (NetworkRequest*)GET;
- (NetworkRequest*)POST;
- (NetworkRequest*)upload;
- (NetworkRequest*)download;
- (NetworkRequest*(^)(NSString*))HTTPMethod;
- (NetworkRequest*(^)(NSString*))URL;
- (NetworkRequest*(^)(id))params;
- (NetworkRequest*(^)(ResponseBlock))response;
- (NetworkRequest*(^)(ProgressBlock))progress;
- (NetworkRequest*(^)(UploadBlock))uploadBlock;

// 公共参数
- (NSDictionary *)commonParams;

/// 注意，如果需要对网络请求进行cancel，请使用weak
- (void)cancel;
@end
