//
//  UIView+FMBlockGesture.m
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import "UIView+FMBlockGesture.h"
#import <objc/runtime.h>

static const void *kFMTapGestureKey = &kFMTapGestureKey;
static const void *kFMTapGestureBlockKey = &kFMTapGestureBlockKey;
static const void *kFMLongPressGestureKey = &kFMLongPressGestureKey;
static const void *kFMLongPressBlockKey = &kFMLongPressBlockKey;

@implementation UIView (FMBlockGesture)

- (UITapGestureRecognizer *)fm_addTapGestureWithHandler:(FMTapGestureBlock)handler {
    UITapGestureRecognizer *tapGesture =objc_getAssociatedObject(self, kFMTapGestureKey);
    if (!tapGesture) {
        tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fm_tapAcion:)];
        [self addGestureRecognizer:tapGesture];
        objc_setAssociatedObject(self, kFMTapGestureKey, tapGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, kFMTapGestureBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return tapGesture;
}

- (UILongPressGestureRecognizer *)fm_addLongPressGestureWithHandler:(FMLongPressGestureBlock)handler {
    UILongPressGestureRecognizer *longPressGesture = objc_getAssociatedObject(self, kFMLongPressGestureKey);
    if (!longPressGesture) {
        longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
        [self addGestureRecognizer:longPressGesture];
        objc_setAssociatedObject(self, kFMLongPressGestureKey, longPressGesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    objc_setAssociatedObject(self, kFMLongPressBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
    return longPressGesture;
}

#pragma mark ------ < Event Response > ------
- (void)fm_tapAcion:(UITapGestureRecognizer *)tapGestureRecognizer {
    if (tapGestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        FMTapGestureBlock block = objc_getAssociatedObject(self, kFMTapGestureBlockKey);
        if (block) {
            block(tapGestureRecognizer);
        }
    }
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    if (longPressGestureRecognizer.state == UIGestureRecognizerStateRecognized) {
        FMLongPressGestureBlock block = objc_getAssociatedObject(self, kFMLongPressBlockKey);
        if (block) {
            block(longPressGestureRecognizer);
        }
    }
}

@end
