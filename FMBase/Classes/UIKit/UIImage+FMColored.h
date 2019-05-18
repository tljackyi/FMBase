//
//  UIImage+FMColored.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (FMColored)

+ (UIImage*)clearImageWithSize:(CGSize)size;

+ (UIImage*)coloredImage:(UIColor*)color withSize:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)aSize
               cornerRadius:(float)cornerRadius;

+ (UIImage *)gradientImageWithStartColor:(UIColor *)startColor
                                endColor:(UIColor *)endColor
                              boundsSize:(CGSize)size
                              startPoint:(CGPoint)startPoint
                                endPoint:(CGPoint)endPoint;

@end

NS_ASSUME_NONNULL_END
