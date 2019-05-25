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

#pragma mark - Black

@property (strong, readonly, nonatomic) UIColor *blackColor_000000;
@property (strong, readonly, nonatomic) UIColor *blackColor_21283e;
@property (strong, readonly, nonatomic) UIColor *blackColor_182031;
@property (strong, readonly, nonatomic) UIColor *blackColor_a4b6cc;

+ (instancetype)style;
- (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
