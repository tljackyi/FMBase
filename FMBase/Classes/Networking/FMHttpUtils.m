//
//  FMHttpUtils.m
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import "FMHttpUtils.h"
#import "FMJson.h"
#import "FMHttpRequest.h"
#import "FMHttpManager.h"

@implementation FMHttpUtils

+ (RACSignal *)rac_getWithUrlStr:(NSString *)urlStr
                          params:(NSDictionary *)params {
    return [self rac_requestWithUrlStr: urlStr method: @"GET" params: params];
}

+ (RACSignal *)rac_postWithUrlStr:(NSString *)urlStr
                           params:(NSDictionary *)params {
    return [self rac_requestWithUrlStr: urlStr method: @"POST" params: params];
}

+ (RACSignal *)rac_requestWithUrlStr:(NSString *)urlStr
                              method:(NSString *)methodStr
                              params:(NSDictionary *)params {
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        FMHttpRequest *request = [[FMHttpRequest alloc] init];
        request.urlStr = urlStr;
        request.methodStr = methodStr;
        request.params = params;
        [FMHttpManager addRequest: request callback:^(FMJson *json, NSError *error) {
            if (error) {
                [subscriber sendError: error];
            }
            else {
                [subscriber sendNext: json];
                [subscriber sendCompleted];
            }
        }];
        return [RACDisposable disposableWithBlock:^{
            [FMHttpManager cancelRequest: request];
        }];
    }];
}

@end
