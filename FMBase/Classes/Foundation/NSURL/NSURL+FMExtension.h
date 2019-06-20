//
//  NSURL+FMExtension.h
//  Pods
//
//  Created by yitailong on 2019/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (FMExtension)

+ (NSDictionary*)decodedParametersForQuery:(NSString*)queryStr;

+ (NSDictionary*)rawDicParametersForQueryParameters:(NSString*)queryStr;

+ (NSString*)queryStringForDicParameters:(NSDictionary*)dic;

+ (NSString*)queryStringForRawDicParameters:(NSDictionary*)rawDic;

@end

NS_ASSUME_NONNULL_END
