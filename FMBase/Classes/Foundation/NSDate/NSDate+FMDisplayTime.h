//
//  NSDate+FMDisplayTime.h
//  Pods
//
//  Created by yitailong on 2019/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

struct FMDateEnum {
    NSInteger day;      //天
    NSInteger hour;     //小时
    NSInteger minute;   //分钟
    NSInteger second;   //秒
};
typedef struct FMDateEnum FMDateEnum;
struct FMDateUnitEnum {
    const char *dateString; //格式化字符串：x天x时x分x秒
    FMDateEnum dateEnum;      //日期枚举值
};
typedef struct FMDateUnitEnum FMDateUnitEnum;


CG_EXTERN bool kFMDateIsEmpty(FMDateEnum date);

@interface NSDate (FMDisplayTime)

// 当前日期->未来日期enum
- (FMDateUnitEnum)fm_unitEnumToFuture:(NSDate *)toDate;

/**
 通过时间戳计算时间差
 @param compareDate 时间戳
 @return 刚刚、几分钟前、.....
 */
+ (NSString *)fm_compareCurrentTime:(NSTimeInterval) compareDate;

/**
 通过时间字符串计算时间差
 @param timeString 时间字符串，example：2018-06-19 16:24:10
 @return 几年/月/周...前.
 */
+ (NSString *)fm_compareCurrentTimeWithTimeString:(NSString *)timeString;

@end

NS_ASSUME_NONNULL_END
