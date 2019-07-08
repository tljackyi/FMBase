//
//  UIButton+FMImageTitleSpacing.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 定义一个枚举（包含了四种类型的button）
typedef NS_ENUM(NSUInteger, FMButtonEdgeInsetsStyle) {
    FMButtonEdgeInsetsStyleTop, // image在上，label在下
    FMButtonEdgeInsetsStyleLeft, // image在左，label在右
    FMButtonEdgeInsetsStyleBottom, // image在下，label在上
    FMButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (FMImageTitleSpacing)

- (void)setImage:(UIImage *)image
           title:(NSString*)title
           style:(FMButtonEdgeInsetsStyle)style
 imageTitleSpace:(CGFloat)space
        forState:(UIControlState)state;

- (void)fm_setImage:(UIImage *)image
           title:(NSString*)title
           style:(FMButtonEdgeInsetsStyle)style
 imageTitleSpace:(CGFloat)space
        forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
