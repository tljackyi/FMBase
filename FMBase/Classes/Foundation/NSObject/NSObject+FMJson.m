//
//  NSObject+FMJson.m
//  Pods
//
//  Created by PILIPA on 2019/7/8.
//

#import "NSObject+FMJson.h"
#import "FMBaseFunctionsDef.h"
#import <YYModel/YYModel.h>

@implementation NSObject (FMJson)

+ (instancetype)fm_modelWithJson:(id)json {
    return [self yy_modelWithJSON:json];
}

+ (instancetype)fm_modelWithJson:(FMJson *)json
                    forKeyStr:(NSString *)keyStr {
    if (!NHValidStringify(keyStr)) {
        return nil;
    }
    return [self fm_modelWithJson: [json jsonForKey: keyStr].jsonObj];
}

+ (NSArray *)fm_modelArrayWithJson:(id)json {
    return [NSArray yy_modelArrayWithClass:[self class] json:json];
}

+ (NSArray *)fm_modelArrayWithJson:(FMJson *)json
                      forKeyStr:(NSString *)keyStr {
    if (!NHValidStringify(keyStr)) {
        return nil;
    }
    return [self fm_modelArrayWithJson: [json jsonForKey: keyStr].jsonObj];
}

@end
