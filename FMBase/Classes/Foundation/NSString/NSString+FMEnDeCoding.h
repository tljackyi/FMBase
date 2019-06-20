//
//  NSString+FMEnDeCoding.h
//  Pods
//
//  Created by yitailong on 2019/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FMEnDeCoding)

/**
 *    @see stringByEscapingForURLArgument
 *
 *    @return    escapted string
 */
- (NSString*)urlEncode;

/**
 *    @see stringByUnescapingFromURLArgument
 *
 *    @return    unescapted string
 */
- (NSString*)urlDecode;

/**
 *    url argument escaping
 *
 *    @return    escapted string
 */
- (NSString*)stringByEscapingForURLArgument;

/**
 *    url argument unescaping
 *
 *    @return    unescapted string
 */
- (NSString*)stringByUnescapingFromURLArgument;

- (NSString*)base64Encode;
- (NSString*)base64Decode;

/**
 *  md5 encoding
 *
 *  @return lowercase encoding string
 */
- (NSString*)md5Encode;

/**
 *  md5 encoding
 *
 *  @return uppercase encoding string
 */
- (NSString*)MD5Encode;


@end

NS_ASSUME_NONNULL_END
