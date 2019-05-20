//
//  UIView+FMExtension.m
//  Pods
//
//  Created by yitailong on 2019/5/20.
//

#import "UIView+FMExtension.h"

@implementation UIView (FMExtension)

-(void)jk_shadowWithColor: (UIColor *)color
                   offset: (CGSize)offset
                  opacity: (CGFloat)opacity
             cornerRadius: (CGFloat)cornerRadius
{
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = cornerRadius;
}

#pragma mark -- Border
- (void)fm_addBorderWithColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = cornerRadius;
}

- (void)fm_addBorderAndCornerRadiusWithColor:(UIColor *)color {
    [self fm_addBorderWithColor:color
                    borderWidth:0.5f
                   cornerRadius:4.f];
}

- (void)fm_addBorderWithColor:(UIColor *)color
                  borderWidth:(CGFloat)borderWidth {
    [self fm_addBorderWithColor:color
                    borderWidth:borderWidth
                   cornerRadius:0.f];
}

#pragma mark -- CornerRadius
- (void)fm_setCornerRadius:(CGFloat)cornerRadius {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)fm_setCircleCornerRadius {
    NSAssert(self.bounds.size.width != self.bounds.size.height, @"请检查视图frame设置是否正确");
    [self fm_setCornerRadius:self.bounds.size.width];
}

- (void)fm_setBezierCornerRadiusByRoundingCorners:(FMRectCornerType)rectCorner
                                     cornerRadius:(CGFloat)cornerRadius {
    UIRectCorner corner;
    switch (rectCorner) {
        case FMRectCornerTop:
            corner = UIRectCornerTopLeft | UIRectCornerTopRight;
            break;
        case FMRectCornerLeft:
            corner = UIRectCornerTopLeft | UIRectCornerBottomLeft;
            break;
        case FMRectCornerBottom:
            corner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
            break;
        case FMRectCornerRight:
            corner = UIRectCornerBottomRight | UIRectCornerTopRight;
            break;
        case FMRectCornerAll:
            corner = UIRectCornerAllCorners;
            break;
        default:
            break;
    }
    
    CGSize size = CGSizeMake(cornerRadius, cornerRadius);
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    byRoundingCorners:corner cornerRadii:size];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

#pragma mark --------  子视图  --------
- (NSArray *)superviews {
    NSMutableArray *superviews = [[NSMutableArray alloc] init];
    
    UIView *view = self;
    UIView *superview = nil;
    while (view) {
        superview = [view superview];
        if (!superview) {
            break;
        }
        
        [superviews addObject:superview];
        view = superview;
    }
    return superviews;
}

#pragma mark --------  添加视图到Window上  --------
- (void)fm_addToWindow {
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(window)])
    {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}


@end
