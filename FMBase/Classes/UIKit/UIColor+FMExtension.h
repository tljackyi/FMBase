//
//  UIColor+FMExtension.h
//  Pods
//
//  Created by yitailong on 2019/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (FMExtension)

#pragma mark --------  随机色  --------
+ (UIColor *)fm_randomColor;

#pragma mark --------  RGB/RGBA  --------
/**
 *  RGBA颜色
 *
 *  @param red 红色
 *  @param green 绿色
 *  @param blue 蓝色
 *  @param alpha 透明度
 *  @return RGBA颜色
 */
+ (UIColor *)fm_rgbaColorWithRed:(CGFloat)red
                           green:(CGFloat)green
                            blue:(CGFloat)blue
                           alpha:(CGFloat)alpha;
+ (UIColor *)fm_rgbColorWithRed:(CGFloat)red
                          green:(CGFloat)green
                           blue:(CGFloat)blue;

#pragma mark --------  Hex Color  --------
/**
 *  从十六进制字符串获取颜色
 *
 *  @param color 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
 *  @param alpha 颜色透明度
 *  @return 十六进制颜色
 */
+ (UIColor *)fm_colorWithHexString:(NSString *)color
                             alpha:(CGFloat)alpha;
+ (UIColor *)fm_colorWithHexString:(NSString *)color;

/**
 *  Creates and returns a color object using the hex RGB color values
 *
 *  @param rgbValue 0x66ccff
 *  @return hex RGB color
 *  @return The color object
 */
+ (UIColor *)fm_colorWithRGB:(uint32_t)rgbValue;

/**
 *  Creates and returns a color object using the hex RGBA color values.
 *
 *  @param rgbaValue 0x66ccffff
 *  @return The color object
 */
+ (UIColor *)fm_colorWithRGBA:(uint32_t)rgbaValue;

/**
 *  Creates and returns a color object using the specified opacity and RGB hex value
 *
 *  @param rgbValue 0x66CCFF
 *  @param alpha The opacity value of the color object
 *  @return The color object
 */
+ (UIColor *)fm_colorWithRGB:(uint32_t)rgbValue
                       alpha:(CGFloat)alpha;

/**
 *  获取hex字符串
 *  @return hex字符串
 */
- (NSString *)fm_getHexString;

#pragma mark --------  渐变色  --------
+ (UIColor*)fm_gradientFromColor:(UIColor *)c1
                         toColor:(UIColor *)c2
                      withHeight:(int)height;


@end

NS_ASSUME_NONNULL_END
