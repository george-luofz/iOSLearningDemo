//
//  NetworkRequest.m
//  iOSLearnigDemo
//
//  Created by 罗富中 on 2018/8/13.
//  Copyright © 2018年 George_luofz. All rights reserved.
//

#import "NetworkRequest.h"
#import <AdSupport/AdSupport.h>
#import <sys/utsname.h>
#import <sys/sysctl.h>

#define weak(obj) autoreleasepool{} __weak typeof(obj) obj##Weak  = obj;
#define strong(obj) autoreleasepool{} __strong typeof(obj) obj##Strong  = obj##Weak;

@interface DomainManager : NSObject
@property (nonatomic) NSMutableArray<NSString *> *apiDomains;
@property (nonatomic) NSMutableArray<NSString *> *logDomains;

@property (nonatomic) NSMutableArray<NSString *> *testApiDomains;
@property (nonatomic) NSMutableArray<NSString *> *testLogDomains;

+ (instancetype)sharedManager;

- (NSArray<NSString *> *)domainsForRequsetType:(MKRequestType)requestType;
//- (void)sortDomainsWithSuccessDomain:(NSString *)domain requestType:(MKRequestType)requestType;
@end

@implementation DomainManager

+ (instancetype)sharedManager {
    static id manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _apiDomains = [NSMutableArray arrayWithArray:@[@"http://39.105.20.33:8000"]];
        //        _apiDomains = [NSMutableArray arrayWithArray:@[@"http://39.105.20.33:8000"]];
        _logDomains = [NSMutableArray arrayWithArray:@[@"http://kdlog.bbobo.com", @"http://log.kuaikanapps.com", @"http://47.94.119.50"]];
        
        //        _testApiDomains = [NSMutableArray arrayWithArray:@[@"http://47.94.120.74:8000"]];
        _testApiDomains = [NSMutableArray arrayWithArray:@[@"http://39.105.20.33:8000"]];
        //        _testLogDomains = [NSMutableArray arrayWithArray:@[@"http://47.93.28.166:9103"]];
        _testLogDomains = [NSMutableArray arrayWithArray:@[@"http://47.93.23.201:8889"]];
    }
    return self;
}

// 给出当前热度排序的域名
- (NSArray<NSString *> *)domainsForRequsetType:(MKRequestType)requestType {
    if (requestType == MKRequestTypeJSON) {
//        if (UserDefaultsHelper.isTestApi) {
//            return [_testApiDomains copy];
//        }
        return [_apiDomains copy];
    }
//    if (requestType == MKRequestTypeAnalysis) {
//        if (UserDefaultsHelper.isTestApi) {
//            return [_testLogDomains copy];
//        }
//        return [_logDomains copy];
//    }
    return nil;
}

@end

@interface NetworkRequest()
@property (nonatomic, strong) NSMutableURLRequest *urlRequest;
@property (nonatomic, strong) NSURLSessionTask *sessionTask;

@property (nonatomic, copy) ResponseBlock responseBlock;
@property (nonatomic, copy) ProgressBlock progressBlock;
@property (nonatomic, copy) UploadBlock uploadDataBlock;

@property (nonatomic, copy) NSArray<NSString *> *domains;

@property (nonatomic) NSTimeInterval requestDate;

@property (nonatomic, getter=isShouldCancel) BOOL shouldCancel;

@property (nonatomic, strong) id parameters;
@property (nonatomic, copy) NSString *urlString;

@end

@implementation NetworkRequest

NetworkRequest *NetWorkRequest(void) {
    return [NetworkRequest new];
}

+ (NSURLSession *)session {
    return default_session();
}
- (NetworkRequest *(^)(void))NetworkRequest{
    return ^ NetworkRequest *(void){
        return [NetworkRequest new];
    };
}

- (NetworkRequest *)GET{
    _requestType = MKRequestTypeJSON;
    _httpMethod = @"GET";
    return self;
}

- (NetworkRequest *)POST{
    _requestType = MKRequestTypeJSON;
    _httpMethod = @"POST";
    return self;
}

- (NetworkRequest *)upload{
    _requestType = MKRequestTypeUpload;
    return self;
}

- (NetworkRequest *)download{
    _requestType = MKRequestTypeDownload;
    return self;
}

- (NetworkRequest *(^)(NSString *))HTTPMethod{
    @weak(self)
    return ^ NetworkRequest *(NSString *method){
        @strong(self)
        selfStrong.httpMethod = [method copy];
        return selfStrong;
    };
}

- (NetworkRequest *(^)(NSString *))URL{
    @weak(self)
    return ^ NetworkRequest *(NSString *urlString){
        @strong(self)
        if([urlString isKindOfClass:[NSString class]] && urlString.length > 0){
            [selfStrong setValue:urlString forKey:@"urlString"];
        }
        return selfStrong;
    };
}

- (NetworkRequest *(^)(id))params{
    @weak(self)
    return ^ NetworkRequest *(id params){
        @strong(self)
        if(params){
            [selfStrong setValue:params forKey:@"parameters"];
        }
        return selfStrong;
    };
}

- (NetworkRequest *(^)(ResponseBlock))response{
    @weak(self)
    return ^ NetworkRequest *(ResponseBlock responseBlock){
        @strong(self)
        selfStrong.responseBlock = responseBlock;
        return [selfStrong request];
    };
}

- (NetworkRequest *(^)(ProgressBlock))progress{
    @weak(self)
    return ^ NetworkRequest *(ProgressBlock progressBlock){
        @strong(self)
        selfStrong.progressBlock = progressBlock;
        return selfStrong;
    };
}

- (NetworkRequest *(^)(UploadBlock))uploadBlock{
    @weak(self)
    return ^NetworkRequest *(UploadBlock uploadBlock){
        @strong(self)
        selfStrong.uploadDataBlock = uploadBlock;
        return selfStrong;
    };
}
// 公共参数
- (NSDictionary *)commonParams{
    NSMutableDictionary *params = [NSMutableDictionary new];
    params[@"os"] = @(1);
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    params[@"bundleid"] = [infoDictionary objectForKey:(__bridge NSString *)kCFBundleIdentifierKey];
    params[@"version"] = [infoDictionary objectForKey:(NSString *)kCFBundleVersionKey];
    params[@"idfa"] = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];;
    params[@"apiversion"] = @"v1";
    params[@"st"] = @([[NSDate date] timeIntervalSince1970]);
    params[@"userid"] = @""; //TODO:
    params[@"channelid"] = @"";
    params[@"imei"] = @"";
    params[@"mac"] = @"";
    params[@"net"] = @"";
    params[@"token"] = @""; //TODO:
    params[@"model"] = [[self class] iphoneType];
    return params;
}

- (void)cancel{
    self.shouldCancel = YES;
    if (self.sessionTask){
        [self.sessionTask cancel];
    }
}

#pragma mark - private

static NSURLSession *default_session() {
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuration.timeoutIntervalForRequest = 10.0;
        session = [NSURLSession sessionWithConfiguration:configuration];
    });
    return session;
}

static dispatch_queue_t network_queue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.warmDiary.queue", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}


- (NetworkRequest *)request{
    @weak(self)
    @strong(self) //写外边，在非globalQueue中放外边
    dispatch_async(network_queue(), ^{
        // 1. config
        // 2. request
        // 3. callback
        [selfStrong _configBeforeRequest];
        [selfStrong _requestWithComletionHandler:^(id  _Nullable responseObject, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            [selfStrong _handleAfterRequestCompletion:responseObject response:response error:error];
        }];
    });
    return self;
}

#pragma mark - request config
// 请求前配置
- (void)_configBeforeRequest{
    switch (_requestType) {
        case MKRequestTypeJSON: {
            [self jsonRequestConfig];
        }
            break;
        case MKRequestTypeUpload: {
            [self uploadRequestConfig];
        }
            break;
        case MKRequestTypeDownload: {
            [self downloadRequestConfig];
        }
            break;
        default:break;
    }
}

- (void)jsonRequestConfig {
    // 1.GET/POST
    // 2.http header

    NSString *requestUrl = self.urlString;
    if ([_httpMethod isEqualToString:@"GET"]){
        NSString *requestParams = [self _buildGetRequestUrlString:self.parameters];
        requestUrl = [self.urlString stringByAppendingPathComponent:requestParams];
    } else {
        // body
        if (self.parameters){
            NSError *jsonSerializationError = nil;
            NSData *data = [NSJSONSerialization dataWithJSONObject:self.parameters options:0 error:&jsonSerializationError];
            if(data && !jsonSerializationError){
                self.urlRequest.HTTPBody = data;
            }
        }
    }
    
    NSURL *URL = [NSURL URLWithString:requestUrl];
    self.urlRequest = [NSMutableURLRequest requestWithURL:URL];
    self.urlRequest.HTTPMethod = _httpMethod;
    self.urlRequest.HTTPShouldUsePipelining = true;
    
    NSDictionary *commonParams = [self commonParams];
    [commonParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.urlRequest setValue:[NSString stringWithFormat:@"%@",obj] forHTTPHeaderField:key];
    }];
}

- (void)uploadRequestConfig{
    
}

- (void)downloadRequestConfig{
    
}
// 构建GET请求参数
- (NSString *)_buildGetRequestUrlString:(NSDictionary *)params{
    NSMutableString *tempString = [NSMutableString stringWithString:@"?"];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [tempString appendFormat:@"%@=%@&",key,obj];
    }];
    [tempString substringToIndex:tempString.length-2];
    return [tempString copy];
}
#pragma mark - request
- (void)_requestWithComletionHandler:(void (^)(id _Nullable responseObject, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    self.sessionTask = [default_session() dataTaskWithRequest:self.urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 1.error
        // 2.data is nil
        // 3.json error
        if (error){
            if (completionHandler){
                completionHandler(nil, response, error);
            }
            return;
        }
        if (data == nil){
            if (completionHandler){
                completionHandler(nil, response, [NSError errorWithDomain:@"no data" code:-10001 userInfo:nil]);
            }
            return;
        }
        NSError *JSONSerializationError = nil;
        NSJSONSerialization *JSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&JSONSerializationError];
        if (JSONSerializationError) {
            if (completionHandler) {
                completionHandler(nil, response, JSONSerializationError);
            }
            return;
        }
        if (completionHandler) {
            completionHandler(JSON, response, nil);
        }
    }];
    [self.sessionTask resume];
}

#pragma mark - completion handler
// 请求完成回调
- (void)_handleAfterRequestCompletion:(id) responseObject response:(NSURLResponse * _Nullable) response error:(NSError *) error{
    // 1. error
        // 1. canceled
        // 3. no retry
    if (error && error.code == NSURLErrorCancelled && !self.callbackWhenCancelled){
        return;
    }
    [self _callbackReponseBlockInMainThread:responseObject error:nil];
}
// 主线程执行回调
- (void)_callbackReponseBlockInMainThread:(id)responseObj error:(NSError *)error{
    @weak(self)
    if (self.responseBlock){
        dispatch_async(dispatch_get_main_queue(), ^{
            @strong(self)
            selfStrong.responseBlock(error,responseObj);
            selfStrong.responseBlock = nil;
        });
    }
}

#pragma mark - setter/getter
- (void)setSessionTask:(NSURLSessionTask *)sessionTask {
    _sessionTask = sessionTask;
    if (self.isShouldCancel) {
        [_sessionTask cancel];
    }
}

- (NSString *)urlString{
    if (!_urlString.length){
        return nil;
    }
    if ([_urlString hasPrefix:@"http://"] || [_urlString hasPrefix:@"https://"]){
        return _urlString;
    }
    NSString *currentDomain = [[DomainManager sharedManager].apiDomains firstObject];
    _urlString = [[currentDomain stringByAppendingPathComponent:_urlString] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return _urlString;
}

#pragma mark - config
+ (NSString *)iphoneType{
    static NSString *platform = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    });
    return platform;
}

@end
