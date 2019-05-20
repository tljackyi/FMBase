//
//  UIView+FMExtension.h
//  Pods
//
//  Created by yitailong on 2019/5/20.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,FMRectCornerType) {
    FMRectCornerTop,
    FMRectCornerLeft,
    FMRectCornerRight,
    FMRectCornerBottom,
    FMRectCornerAll
};

NS_ASSUME_NONNULL_BEGIN
@interface UIView (FMExtension)

#pragma mark -- Shadow
/**
 *  view 添加阴影
 *
 *  @param color 边框颜色
 *  @param offset 偏移
 *  @param opacity 透明度
 *  @param cornerRadius 圆角
 */
-(void)fm_shadowWithColor: (UIColor *)color
                   offset: (CGSize)offset
                  opacity: (CGFloat)opacity
             cornerRadius: (CGFloat)cornerRadius;

#pragma mark -- Border
/**
 *  view 添加边框
 *
 *  @param color 边框颜色
 *  @param borderWidth 宽度
 *  @param cornerRadius 圆角
 */
- (void)fm_addBorderWithColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius;
/**
 *  添加边框(默认圆角为4)
 *
 *  @param color 边框颜色
 */
- (void)fm_addBorderAndCornerRadiusWithColor:(UIColor *)color;
/**
 *  添加边框
 *
 *  @param color 边框颜色
 *  @param borderWidth 边框宽度
 */
- (void)fm_addBorderWithColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth;

#pragma mark -- CornerRadius
/**
 *  设置圆角
 *
 *  @param cornerRadius 圆角大小
 */
- (void)fm_setCornerRadius:(CGFloat)cornerRadius;

/**
 *  视图切成圆
 *
 */
- (void)fm_setCircleCornerRadius;

/**
 *  为某个方向添加指定圆角大小
 *
 *  @param rectCorner
 UIRectCornerTopLeft
 UIRectCornerTopRight
 UIRectCornerBottomLeft
 UIRectCornerBottomRight
 UIRectCornerAllCorners
 *  @param cornerRadius 圆角size
 */
- (void)fm_setBezierCornerRadiusByRoundingCorners:(FMRectCornerType)rectCorner
                                     cornerRadius:(CGFloat)cornerRadius;

#pragma mark --------  父视图  --------
/**  父视图  */
- (NSArray *)superviews;

#pragma mark --------  添加视图到Window上  --------
- (void)fm_addToWindow;

@end

NS_ASSUME_NONNULL_END
