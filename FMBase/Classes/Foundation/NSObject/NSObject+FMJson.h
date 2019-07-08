//
//  NSObject+FMJson.h
//  Pods
//
//  Created by PILIPA on 2019/7/8.
//

#import <Foundation/Foundation.h>
#import "FMJson.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FMJson)

+ (instancetype)fm_modelWithJson:(id)json;

+ (instancetype)fm_modelWithJson:(FMJson *)json
                       forKeyStr:(NSString *)keyStr;

+ (NSArray *)fm_modelArrayWithJson:(id)json;

+ (NSArray *)fm_modelArrayWithJson:(FMJson *)json
                         forKeyStr:(NSString *)keyStr;

@end

NS_ASSUME_NONNULL_END
