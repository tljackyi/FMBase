//
//  FMHttpUtils.h
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMHttpUtils : NSObject

+ (RACSignal *)rac_getWithUrlStr:(NSString *)urlStr
                          params:(NSDictionary *)params;

+ (RACSignal *)rac_postWithUrlStr:(NSString *)urlStr
                           params:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
