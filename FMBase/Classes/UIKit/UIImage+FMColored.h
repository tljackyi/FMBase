//
//  UIImage+FMColored.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FMColored)

+ (UIImage*)fm_clearImageWithSize:(CGSize)size;

+ (UIImage*)fm_coloredImage:(UIColor*)color withSize:(CGSize)size;

+ (UIImage *)fm_imageWithColor:(UIColor *)color
                       size:(CGSize)aSize
               cornerRadius:(float)cornerRadius;

+ (UIImage *)fm_gradientImageWithStartColor:(UIColor *)startColor
                                endColor:(UIColor *)endColor
                              boundsSize:(CGSize)size
                              startPoint:(CGPoint)startPoint
                                endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
