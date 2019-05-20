//
//  NSDate+FMFormatter.h
//  Pods
//
//  Created by yitailong on 2019/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (FMFormatter)

// 返回自定义时间格式
- (NSString *)fm_dateFormatterWithFormat:(NSString *)format;

// 返回自定义时间格式
- (NSString *)fm_dateFormatterWithFormat:(NSString *)format
                                timeZone:(NSTimeZone *)timeZone;

// 返回自定义时间格式
- (NSString *)fm_dateFormatterWithFormat:(NSString *)format
                                  locale:(NSLocale *)locale
                                timeZone:(NSTimeZone *)timeZone;


@end

NS_ASSUME_NONNULL_END
