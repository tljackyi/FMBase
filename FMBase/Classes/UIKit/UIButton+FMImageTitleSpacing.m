//
//  UIButton+FMImageTitleSpacing.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "UIButton+FMImageTitleSpacing.h"

@implementation UIButton (FMImageTitleSpacing)

- (void)setImage:(UIImage *)image
           title:(NSString*)title
           style:(FMButtonEdgeInsetsStyle)style
 imageTitleSpace:(CGFloat)space
        forState:(UIControlState)state{
    [self fm_setImage:image title:title style:style imageTitleSpace:space forState:state];
}

- (void)fm_setImage:(UIImage *)image
              title:(NSString*)title
              style:(FMButtonEdgeInsetsStyle)style
    imageTitleSpace:(CGFloat)space
           forState:(UIControlState)state{
    
    [self setImage:image forState:state];
    [self setTitle:title forState:state];
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = image.size.width;
    CGFloat imageHeight = image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    UIFont *titleFont = self.titleLabel.font;
    CGSize titleSize = [title sizeWithAttributes:@{NSFontAttributeName:titleFont}];
    
    labelWidth = titleSize.width;
    labelHeight = titleSize.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    /**
     FMButtonEdgeInsetsStyleTop, // image在上，label在下
     FMButtonEdgeInsetsStyleLeft, // image在左，label在右
     FMButtonEdgeInsetsStyleBottom, // image在下，label在上
     FMButtonEdgeInsetsStyleRight // image在右，label在左
     */
    switch (style) {
        case FMButtonEdgeInsetsStyleTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case FMButtonEdgeInsetsStyleLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case FMButtonEdgeInsetsStyleBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case FMButtonEdgeInsetsStyleRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}

@end
