//
//  FMBaseMacrosDef.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#ifndef FMBaseMacrosDef_h
#define FMBaseMacrosDef_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// 单例
#define SingletonDeclarationWithClass +(instancetype)sharedInstance;
#define SingletonImplementationWithClass \
+ (instancetype)sharedInstance {\
static id instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
}

CG_INLINE void swizz_instanceMethod(Class cls, SEL orig_sel, SEL swizzle_sel) {
    Method originalMethod = class_getInstanceMethod(cls, orig_sel);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzle_sel);
    BOOL success = class_addMethod(cls,
                                   orig_sel,
                                   method_getImplementation(swizzledMethod),
                                   method_getTypeEncoding(swizzledMethod));
    if (success) {
        class_replaceMethod(cls,
                            swizzle_sel,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

CG_INLINE CGFloat KScreenScale() {
    return [UIScreen mainScreen].scale;
}
CG_INLINE CGFloat KLineWidth() {
    return 1.0 / [UIScreen mainScreen].scale;
}
CG_INLINE CGFloat KScreenHeight() {
    return [[UIScreen mainScreen] bounds].size.height;
}
CG_INLINE CGSize KScreenSize() {
    return [[UIScreen mainScreen] bounds].size;
}
CG_INLINE CGFloat KScreenWidth() {
    return [[UIScreen mainScreen] bounds].size.width;
}
CG_INLINE BOOL iPhone4() {
    return [UIScreen mainScreen].bounds.size.height == 480;
}
CG_INLINE BOOL iPhone4sAndAbove() {
    return [UIScreen mainScreen].bounds.size.height > 480;
}
CG_INLINE BOOL iPhone5() {
    return [UIScreen mainScreen].bounds.size.height == 568;
}
CG_INLINE BOOL iPhone5AndLower() {
    return [UIScreen mainScreen].bounds.size.height <= 568;
}
CG_INLINE BOOL iPhone5AndAbove() {
    return [UIScreen mainScreen].bounds.size.height >= 568;
}
CG_INLINE BOOL iPhone6() {
    return [UIScreen mainScreen].bounds.size.height == 667;
}
CG_INLINE BOOL iPhone6AndAbove() {
    return [UIScreen mainScreen].bounds.size.height >= 667;
}
CG_INLINE BOOL iPhone6AndLower() {
    return [UIScreen mainScreen].bounds.size.height <= 667;
}
CG_INLINE BOOL iPhone6Plus() {
    return [UIScreen mainScreen].bounds.size.height == 736;
}
CG_INLINE BOOL iPhone6PlusAndAbove() {
    return [UIScreen mainScreen].bounds.size.height >= 736;
}
CG_INLINE BOOL iPhone6PlusScale() {
    return CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(375, 667));
}
CG_INLINE BOOL iPhonePlus() {
    return CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(414, 736));;
}
CG_INLINE BOOL iPhoneX() {
    return [UIScreen mainScreen].bounds.size.height == 812;
}
CG_INLINE BOOL iPhoneXAndAbove() {
    CGRect rect = [UIScreen mainScreen].bounds;
    return CGRectGetHeight(rect) / CGRectGetWidth(rect) >= 2.0;
}


CG_INLINE CGFloat TopLayoutGuideLength() {
    return iPhoneXAndAbove() ? 24.0f : 0.0f;
}
CG_INLINE CGFloat BottomLayoutGuideLength() {
    return iPhoneXAndAbove() ? 34.0f : 0.0f;
}
CG_INLINE CGFloat StatusBarHeight() {
    return UIApplication.sharedApplication.statusBarFrame.size.height;
}
CG_INLINE CGFloat NavigationBarHeight() {
    return 64 + TopLayoutGuideLength();
}


#endif /* FMBaseMacrosDef_h */
