//
//  NSURL+FMExtension.m
//  Pods
//
//  Created by yitailong on 2019/6/20.
//

#import "NSURL+FMExtension.h"
#import "NSString+FMEnDeCoding.h"

@implementation NSURL (FMExtension)

+ (NSDictionary*)parseDicFromUrlQueryStr:(NSString*)queryStr withDecoding:(BOOL)decoding {
    if (![queryStr isKindOfClass:[NSString class]] || queryStr.length == 0) {
        return nil;
    }
    
    NSMutableDictionary* dic = [NSMutableDictionary dictionaryWithCapacity:4];
    
    NSArray *resPairs = [queryStr componentsSeparatedByString:@"&"];
    for (NSString *keyValue in resPairs) {
        // @"key=" -> array:[@"key", @""]
        NSArray *pairs = [keyValue componentsSeparatedByString:@"="];
        if (pairs.count < 2) {
            continue;
        }
        NSString *value = [pairs objectAtIndex:1];
        if (value && [value isKindOfClass:[NSString class]]) {
            if (decoding) {
                value = [value urlDecode];
            }
            [dic setObject:value forKey:[pairs objectAtIndex:0]];
        }
    }
    return dic;
}

+ (NSString*)stringValueOfObj:(id)obj {
    NSString *value = nil;
    if ([obj isKindOfClass:[NSString class]]) {
        value = obj;
    }
    else if ([obj respondsToSelector:@selector(stringValue)]) {
        value = [obj stringValue];
    }
    return value;
}

+ (NSString*)buildUrlQueryStrFromDic:(NSDictionary*)dic valueHasBeenEncoded:(BOOL)hasBeenEncoded {
    if (!dic || ![dic isKindOfClass:[NSDictionary class]]) {
        return @"";
    }
    
    NSMutableString *queryStr = [NSMutableString stringWithCapacity:20];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString *keyStr = [self stringValueOfObj:key];
        NSString *valueStr = [self stringValueOfObj:obj];
        if ([keyStr length] > 0 && [valueStr length] > 0) {
            if (!hasBeenEncoded) {
                valueStr = [valueStr urlEncode];
            }
            [queryStr appendFormat:@"%@=%@&", keyStr, valueStr];
        }
    }];
    
    if ([queryStr length] > 0) {
        [queryStr deleteCharactersInRange:NSMakeRange([queryStr length]-1, 1)];
    }
    return queryStr;
}
/**
 * &key1=value1&key2=value2
 * @return dictionary里的value经过url decode
 */
+ (NSDictionary*)decodedParametersForQuery:(NSString*)queryStr {
    return [self parseDicFromUrlQueryStr:queryStr withDecoding:YES];
}

/**
 * &key1=value1&key2=value2
 * @return dictionary里的value __未__ 经过url decode
 */
+ (NSDictionary*)rawDicParametersForQueryParameters:(NSString*)queryStr {
    return [self parseDicFromUrlQueryStr:queryStr withDecoding:NO];
}

/**
 * dictionary里的value经过url encode
 */
+ (NSString*)queryStringForDicParameters:(NSDictionary*)dic {
    return [self buildUrlQueryStrFromDic:dic valueHasBeenEncoded:YES];
}
/**
 * dictionary里的value __未__ 经过url encode
 */
+ (NSString*)queryStringForRawDicParameters:(NSDictionary*)rawDic {
    return [self buildUrlQueryStrFromDic:rawDic valueHasBeenEncoded:NO];
}


@end
