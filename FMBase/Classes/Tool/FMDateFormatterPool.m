//
//  FMDateFormatterPool.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMDateFormatterPool.h"

@interface FMDateFormatterPool ()

@property (nonatomic, strong) NSCache *dateFormatterCache;

@end

@implementation FMDateFormatterPool

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSString *)format {
    return [self fm_dateFormatterWithFormat:format locale:[NSLocale autoupdatingCurrentLocale] timeZone:[NSTimeZone systemTimeZone]];
}

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSString *)format
                                       timeZone:(NSTimeZone *)timeZone {
    return [self fm_dateFormatterWithFormat:format locale:[NSLocale autoupdatingCurrentLocale] timeZone:timeZone];
}

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSString *)format
                                         locale:(NSLocale *)locale
                                       timeZone:(NSTimeZone *)timeZone {
    if (![format isKindOfClass:[NSString class]] || format.length == 0) return nil;
    NSString *identifier = locale.localeIdentifier;
    NSString *timeZoneName = timeZone.name;
    NSString *key = [self fm_getCacheKeyWithFormat:format
                                  localeIdentifier:identifier
                                      timeZoneName:timeZoneName];
    NSDateFormatter *formatter = [self.dateFormatterCache objectForKey:key];
    if (formatter) return formatter;
    
    formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = format;
    formatter.locale = locale;
    formatter.timeZone = timeZone;
    [self fm_cacheDateFormatter:formatter
                         forKey:key];
    return formatter;
}

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSDateFormatterStyle)dateStyle
                                      timeStyle:(NSDateFormatterStyle)timeStyle {
    return [self fm_dateFormatterWithFormat:dateStyle timeStyle:timeStyle locale:[NSLocale autoupdatingCurrentLocale] timeZone:[NSTimeZone systemTimeZone]];
}

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSDateFormatterStyle)dateStyle
                                      timeStyle:(NSDateFormatterStyle)timeStyle
                                       timeZone:(NSTimeZone *)timeZone {
    return [self fm_dateFormatterWithFormat:dateStyle timeStyle:timeStyle locale:[NSLocale autoupdatingCurrentLocale] timeZone:timeZone];
}

- (NSDateFormatter *)fm_dateFormatterWithFormat:(NSDateFormatterStyle)dateStyle
                                      timeStyle:(NSDateFormatterStyle)timeStyle
                                         locale:(NSLocale *)locale
                                       timeZone:(NSTimeZone *)timeZone {
    NSString *identifier = locale.localeIdentifier;
    NSString *timeZoneName = timeZone.name;
    NSString *key = [self fm_getCacheKeyWithDateStyle:dateStyle
                                            timeStyle:timeStyle
                                     localeIdentifier:identifier
                                         timeZoneName:timeZoneName];
    NSDateFormatter *formatter = [self.dateFormatterCache objectForKey:key];
    if (formatter) return formatter;
    
    formatter = [[NSDateFormatter alloc]init];
    formatter.dateStyle = dateStyle;
    formatter.timeStyle = timeStyle;
    formatter.locale = locale;
    formatter.timeZone = timeZone;
    [self.dateFormatterCache setObject:formatter
                                forKey:key];
    return formatter;
}

#pragma mark - getter
- (NSString *)fm_getCacheKeyWithFormat:(NSString *)format
                      localeIdentifier:(NSString *)identifier
                          timeZoneName:(NSString *)timeZoneName {
    NSMutableString *key = [NSMutableString string];
    if (format) [key appendString:format];
    if (identifier) [key appendFormat:@"|%@",identifier];
    if (timeZoneName) [key appendFormat:@"|%@",timeZoneName];
    return key.copy;
}

- (NSString *)fm_getCacheKeyWithDateStyle:(NSDateFormatterStyle)dateStyle
                                timeStyle:(NSDateFormatterStyle)timeStyle
                         localeIdentifier:(NSString *)identifier
                             timeZoneName:(NSString *)timeZoneName {
    NSMutableString *key = [NSMutableString string];
    if (dateStyle) [key appendFormat:@"%lu",(unsigned long)dateStyle];
    if (timeStyle) [key appendFormat:@"|%lu",(unsigned long)timeStyle];
    if (identifier) [key appendFormat:@"|%@",identifier];
    if (timeZoneName) [key appendFormat:@"|%@",timeZoneName];
    return key.copy;
}

- (NSDateFormatter *)fm_getDateFormatterByKey:(NSString *)key {
    NSDateFormatter *dateFormatter = [self.dateFormatterCache objectForKey:key];
    return dateFormatter;
}

- (void)fm_cacheDateFormatter:(NSDateFormatter *)dateFormatter
                       forKey:(NSString *)key {
    [self.dateFormatterCache setObject:dateFormatter forKey:key];
}


- (NSCache *)dateFormatterCache{
    if (!_dateFormatterCache) {
        _dateFormatterCache = [[NSCache alloc] init];
    }
    return _dateFormatterCache;
}

@end
