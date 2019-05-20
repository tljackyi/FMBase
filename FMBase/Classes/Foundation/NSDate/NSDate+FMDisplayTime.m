//
//  NSDate+FMDisplayTime.m
//  Pods
//
//  Created by yitailong on 2019/5/20.
//

#import "NSDate+FMDisplayTime.h"
#import "FMBaseFunctionsDef.h"
#import "FMDateFormatterPool.h"

bool kBMDateIsEmpty(FMDateEnum date) {
    return date.day == 0 && date.hour == 0 && date.minute == 0 && date.second == 0;
}

@implementation NSDate (FMDisplayTime)

- (FMDateUnitEnum)fm_unitEnumToFuture:(NSDate *)toDate {
    FMDateUnitEnum unitEnum;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond;
    NSDateComponents *dateComponents = [calendar components: unit
                                                   fromDate: self
                                                     toDate: toDate
                                                    options: NSCalendarWrapComponents];
    const NSInteger day = MAX(dateComponents.day, 0);
    const NSInteger hour = MAX(dateComponents.hour, 0);
    const NSInteger minute = MAX(dateComponents.minute, 0);
    const NSInteger second = MAX(dateComponents.second, 0);
    
    NSMutableString *dateString = [NSMutableString string];
    
    //天
    NSString *dayString = [NSString stringWithFormat: @"%ld", day];
    [dateString appendFormat: @"%@%@ ", dayString, KLS(@"天", nil)];
    
    //小时
    NSString *hourString = [NSString stringWithFormat: @"%ld", hour];
    [dateString appendFormat: @"%@%@ ", hourString, KLS(@"时", nil)];
    
    //分钟
    NSString *minuteString = [NSString stringWithFormat: @"%ld", minute];
    [dateString appendFormat: @"%@%@ ", minuteString, KLS(@"分", nil)];
    
    //秒
    NSString *secondString = [NSString stringWithFormat: @"%ld", second];
    [dateString appendFormat: @"%@%@", secondString, KLS(@"秒", nil)];
    
    unitEnum.dateString = [dateString UTF8String];
    unitEnum.dateEnum = (FMDateEnum) {day, hour, minute, second};
    return unitEnum;
}

+ (NSString *)fm_compareCurrentTime:(NSTimeInterval) compareDate {
    NSDate *confromTimesp        = [NSDate dateWithTimeIntervalSince1970:compareDate / 1000];
    NSTimeInterval  timeInterval = [confromTimesp timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags      = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *referenceComponents = [calendar components:unitFlags fromDate:confromTimesp];
    NSInteger referenceHour  =referenceComponents.hour;
    if (timeInterval < 60) {
        result = KLS(@"刚刚", nil);
    }
    else if((temp= timeInterval/60) < 60){
        result = [NSString stringWithFormat:KLS(@"%ld分钟前", nil),temp];
    }
    
    else if((temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:KLS(@"%ld小时前", nil),temp];
    }
    else if ((temp = timeInterval/3600/24)==1)
    {
        result = [NSString stringWithFormat:KLS(@"昨天%ld时", nil),(long)referenceHour];
    }
    else if ((temp = timeInterval/3600/24)==2)
    {
        result = [NSString stringWithFormat:KLS(@"前天%ld时", nil),(long)referenceHour];
    }
    
    else if((temp = timeInterval/3600/24) <31){
        result = [NSString stringWithFormat:KLS(@"%ld天前", nil),temp];
    }
    
    else if((temp = timeInterval/3600/24/30) <12){
        result = [NSString stringWithFormat:KLS(@"%ld个月前", nil),temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:KLS(@"%ld年前", nil),temp];
    }
    return  result;
}

+ (NSString *)fm_compareCurrentTimeWithTimeString:(NSString *)timeString {
    if (!timeString) return nil;
    NSDateFormatter *formatter = [[FMDateFormatterPool shareInstance] fm_dateFormatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [NSDate date];
    NSDate *compareDate = [formatter dateFromString:timeString];
    /** < 时间差转换成秒 > */
    long delta = (long)[nowDate timeIntervalSinceDate:compareDate];
    if (delta <= 0 )return timeString;
    if(delta / (60 * 60 * 24 * 365) > 0) return [NSString stringWithFormat:KLS(@"%ld年前", nil), delta / (60 * 60 * 24 * 365)];
    if (delta / (60 * 60 * 24 * 30) > 0) return [NSString stringWithFormat:KLS(@"%ld月前", nil), delta / (60 * 60 * 24 * 30)];
    if (delta / (60 * 60 * 24 * 7) > 0) return [NSString stringWithFormat:KLS(@"%ld周前", nil), delta / (60 * 60 * 24 * 7)];
    if (delta / (60 * 60 * 24) > 0) return [NSString stringWithFormat:KLS(@"%ld天前", nil), delta / (60 * 60 * 24)];
    if (delta / (60 * 60) > 0) return [NSString stringWithFormat:KLS(@"%ld小时前", nil), delta / (60 * 60)];
    if (delta / (60) > 0) return [NSString stringWithFormat:KLS(@"%ld分钟前", nil), delta / (60)];
    return KLS(@"刚刚", nil);
}

@end
