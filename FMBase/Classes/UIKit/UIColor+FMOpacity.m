//
//  UIColor+FMOpacity.m
//  FMBase
//
//  Created by yitailong on 2019/5/18.
//

#import "UIColor+FMOpacity.h"

@implementation UIColor (FMOpacity)

- (UIColor *)fm_alpha:(CGFloat)alpha {
    return [self colorWithAlphaComponent: alpha];
}

@end
