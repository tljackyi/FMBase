//
//  FMExceptionLog.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FMExceptionDelegate <NSObject>
- (void)captureExceptionWithErrorDic:(NSDictionary *)errorDic;
@end

@interface FMExceptionLog : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<FMExceptionDelegate> delegate;

- (void)reportExceptionWithMessage:(NSString *)message extraDic:(nullable NSDictionary *)extraDic;

@end

NS_ASSUME_NONNULL_END
