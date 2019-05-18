//
//  FMNavgation.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMNavgation : NSObject

/**
 *  BMNavgation 单例
 */
+ (instancetype)shareInstance;

/**
 *  返回当前控制器
 */
- (UIViewController*)currentViewController;

/**
 *  返回当前的导航控制器
 */
- (UINavigationController*)currentNavigationViewController;

@end

NS_ASSUME_NONNULL_END
