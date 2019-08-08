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
@property (nonatomic, copy) void(^requestConfig)(FMHttpRequest *requset, NSURLRequest **urlRequest, NSError *error);
@property (nonatomic, copy) void(^responseConfig)(FMJson *json, NSError **error);

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

+ (void)buildRequestConfig:(void(^)(FMHttpRequest *requset, NSURLRequest **urlRequest, NSError *error))config{
    [FMHttpManager sharedInstance].requestConfig = config;
}

+ (void)buildResponseConfig:(void(^)(FMJson *json, NSError **error))responseConfig{
    [FMHttpManager sharedInstance].responseConfig = responseConfig;
}


+ (void)addRequest:(FMHttpRequest *)request
          callback:(void(^)(FMJson *json, NSError *error))callback {
    NSError *error = nil;
    NSURLRequest *urlRequest = nil;
    void (^requestConfig)(FMHttpRequest *requset, NSURLRequest **urlRequest, NSError *error) = [FMHttpManager sharedInstance].requestConfig;
    if (requestConfig) {
        requestConfig(request, &urlRequest, error);
    }
    if (error) {
        callback(nil, error);
        return;
    }
    if (!urlRequest) {
        error = [NSError errorWithDomain: @"com.error.request"
                                    code: 404
                                userInfo: @{NSLocalizedDescriptionKey:@"Not Found Request"}];
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
                   FMJson *json = [FMJson jsonWithData: responseObject];
                   void(^responseConfig)(FMJson *json, NSError **error)  = [FMHttpManager sharedInstance].responseConfig;
                   if (responseConfig) {
                       responseConfig(json, &error);
                   }
                   [self hookError:error];
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
