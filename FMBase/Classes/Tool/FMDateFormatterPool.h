//
//  FMDateFormatterPool.h
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMDateFormatterPool : NSObject

+ (instancetype)shareInstance;

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSString *)format;

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSString *)format
                                       timeZone:(NSTimeZone *)timeZone;

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSString *)format
                                         locale:(NSLocale *)locale
                                       timeZone:(NSTimeZone *)timeZone;

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSDateFormatterStyle)dateStyle
                                      timeStyle:(NSDateFormatterStyle)timeStyle;

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSDateFormatterStyle)dateStyle
                                      timeStyle:(NSDateFormatterStyle)timeStyle
                                       timeZone:(NSTimeZone *)timeZone;

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSDateFormatterStyle)dateStyle
                                      timeStyle:(NSDateFormatterStyle)timeStyle
                                         locale:(NSLocale *)locale
                                       timeZone:(NSTimeZone *)timeZone;

@end

NS_ASSUME_NONNULL_END
