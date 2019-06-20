//
//  FMURLRoutable.h
//  Pods
//
//  Created by yitailong on 2019/6/20.
//
#import "FMURLRouterInfo.h"

@protocol FMURLRoutable <NSObject>

@optional
/**
 page编码，默认值：class字符串
 
 @return 编码
 */
+ (NSString *)pageKey;

@required
+ (instancetype)initWithURLRouterInfo:(FMURLRouterInfo *)info;

@end
