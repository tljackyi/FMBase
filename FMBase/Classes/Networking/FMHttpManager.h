//
//  FMHttpManager.h
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import <Foundation/Foundation.h>
#import "FMHttpRequest.h"
#import "FMJson.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMHttpManager : NSObject

+ (FMHttpManager *)sharedInstance;

+ (void)buildRequestConfig:(void(^)(FMHttpRequest *requset, NSURLRequest * _Nonnull __autoreleasing * _Nullable urlRequest, NSError *error))config;
+ (void)buildResponseConfig:(void(^)(FMJson *json, NSError * _Nullable __autoreleasing *  _Nullable error))config;

+ (void)addRequest:(FMHttpRequest *)request callback:(void(^)(FMJson *json, NSError *error))callback;
+ (void)cancelRequest:(FMHttpRequest *)request;
+ (void)cancelAllRequest;


+ (void)hookError:(NSError *)error;

@end

NS_ASSUME_NONNULL_END
