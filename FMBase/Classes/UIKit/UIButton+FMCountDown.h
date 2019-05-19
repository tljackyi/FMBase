//
//  UIButton+FMCountDown.h
//  Pods
//
//  Created by yitailong on 2019/5/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (FMCountDown)

- (void)startTime:(NSInteger)timeout waitBlock:(void(^)(NSInteger remainTime))waitBlock finishBlock:(void(^)(void))finishBlock;

@end

NS_ASSUME_NONNULL_END
