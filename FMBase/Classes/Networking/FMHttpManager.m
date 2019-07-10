//
//  FMHttpManager.m
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import "FMHttpManager.h"
#import <AFNetworking/AFNetworking.h>

static dispatch_queue_t kHttpCompletionQueue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("com.http.completion", DISPATCH_QUEUE_CONCURRENT);
    });
    return queue;
}

@interface FMHttpManager ()

@property (nonatomic, strong) AFURLSessionManager *sessionManager;
@property (nonatomic, strong) FMHttpConfig *config;

@end

@implementation FMHttpManager

+ (FMHttpManager *)sharedInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[FMHttpManager alloc] init];
    });
    return instance;
}

- (void)buildServerConfig:(void(^)(FMHttpConfig *config))builder{
    FMHttpConfig *config = [[FMHttpConfig alloc] init];
    builder(config);
    self.config = config;
}

+ (void)addRequest:(FMHttpRequest *)request
          callback:(void(^)(FMJson *json, NSError *error))callback {
    NSError *error = nil;
    FMHttpConfig *config = [FMHttpManager sharedInstance].config;
    Class reqClass = NSClassFromString(FMReqContentTypeToAFReq(config.contentType));
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    if ([reqClass respondsToSelector:@selector(serializer)]) {
        requestSerializer = [reqClass performSelector:@selector(serializer)];
    }
    NSMutableURLRequest *urlRequest = [requestSerializer requestWithMethod: request.methodStr
                                                                 URLString: request.urlStr
                                                                parameters: request.params
                                                                     error: &error];
    if (error) {
        callback(nil, error);
        return;
    }
    AFURLSessionManager *manager = [FMHttpManager sharedInstance].sessionManager;
    manager.completionQueue = kHttpCompletionQueue();
    NSURLSessionTask *task =
    [manager dataTaskWithRequest: urlRequest
                  uploadProgress: NULL
                downloadProgress: NULL
               completionHandler: ^(NSURLResponse * _Nonnull response,
                                    id  _Nullable responseObject,
                                    NSError * _Nullable error) {
                   
                   FMHttpConfig *config = [FMHttpManager sharedInstance].config;
                   FMJson *json = [FMJson jsonWithData: responseObject];
                   NSInteger code = [json integerValueForKey:config.codeKey defaultValue: 0];
                   if (code != 0) {
                       error = [NSError errorWithDomain: @"com.error.response"
                                                   code: code
                                               userInfo: @{NSLocalizedDescriptionKey: [json stringValueForKey: config.errCodeKey]}];
                   }
                   [self hookError: error];
                   callback(json, error);
               }];
    request.identifier = [@(task.taskIdentifier) stringValue];
    [task resume];
}

+ (void)cancelRequest:(FMHttpRequest *)request {
    AFURLSessionManager *manager = [FMHttpManager sharedInstance].sessionManager;
    [manager.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj,
                                                NSUInteger idx,
                                                BOOL * _Nonnull stop) {
        if (obj.taskIdentifier == [request.identifier integerValue]) {
            [obj cancel];
            *stop = YES;
        }
    }];
}

+ (void)cancelAllRequest {
    AFURLSessionManager *manager = [FMHttpManager sharedInstance].sessionManager;
    [manager.tasks makeObjectsPerformSelector: @selector(cancel)];
}

+ (void)hookError:(NSError *)error {
    
}

#pragma mark - getter

- (AFURLSessionManager *)sessionManager {
    if (!_sessionManager) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration: config];
        _sessionManager.responseSerializer = [AFCompoundResponseSerializer serializer];
        _sessionManager.operationQueue.maxConcurrentOperationCount = 5;
    }
    return _sessionManager;
}

@end
