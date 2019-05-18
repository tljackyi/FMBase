//
//  FMUIStyle.h
//  Pods
//
//  Created by yitailong on 2019/5/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UIColor+FMOpacity.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMUIStyle : NSObject

#pragma mark - PingFangSC-Medium

@property (strong, readonly, nonatomic) UIFont *font_PingFangSC_Medium_8;
@property (strong, readonly, nonatomic) UIFont *font_PingFangSC_Medium_10;
@property (strong, readonly, nonatomic) UIFont *font_PingFangSC_Medium_12;

+ (instancetype)style;
- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
