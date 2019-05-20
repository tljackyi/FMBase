//
//  NSDate+FMFormatter.m
//  Pods
//
//  Created by yitailong on 2019/5/20.
//

#import "NSDate+FMFormatter.h"
#import "FMDateFormatterPool.h"

@implementation NSDate (FMFormatter)

// 返回自定义时间格式
- (NSString *)fm_dateFormatterWithFormat:(NSString *)format{
     return [self fm_dateFormatterWithFormat:format locale:[NSLocale autoupdatingCurrentLocale] timeZone:[NSTimeZone systemTimeZone]];
}

// 返回自定义时间格式
- (NSString *)fm_dateFormatterWithFormat:(NSString *)format
                                timeZone:(NSTimeZone *)timeZone{
      return [self fm_dateFormatterWithFormat:format locale:[NSLocale autoupdatingCurrentLocale] timeZone:timeZone];
}

// 返回自定义时间格式
- (NSString *)fm_dateFormatterWithFormat:(NSString *)format
                                  locale:(NSLocale *)locale
                                timeZone:(NSTimeZone *)timeZone {
    NSDateFormatter *dateFormatter = [[FMDateFormatterPool shareInstance] fm_dateFormatterWithFormat:format locale:locale timeZone:timeZone];
    return [dateFormatter stringFromDate:self];
}

@end
