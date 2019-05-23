//
//  FMBaseFunctionsDef.h
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#ifndef FMBaseFunctionsDef_h
#define FMBaseFunctionsDef_h
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

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

#pragma mark - iPhoneType
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

#pragma mark - ScreenSize
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
CG_INLINE CGFloat KAuToLayoutSize(CGFloat size){
    return size * KScreenWidth() / 375;
}


#pragma mark - Value Type
CG_INLINE BOOL NHValidStringify(NSString *string) {
    return ([string isKindOfClass:[NSString class]] && string.length > 0);
}
CG_INLINE NSString * NHStringify(NSString *string) {
    return NHValidStringify(string) ? string : @"";
}
///判断数组存在并且数组的count>0
CG_INLINE BOOL NHValidArrayify(NSArray *array) {
    return (([array isKindOfClass:[NSArray class]] || [array isKindOfClass:[NSMutableArray class]]) && array.count > 0);
}
CG_INLINE BOOL NHValidDictionaryify(NSDictionary *dic) {
    return (([dic isKindOfClass:[NSDictionary class]] || [dic isKindOfClass:[NSMutableDictionary class]]) && dic.count > 0);
}
/**
验证number有效性

@param number NSDecimalNumber对象
@return 是否有效
*/
CG_INLINE BOOL NHValidDecimalNumber(NSDecimalNumber *number) {
    return [number isKindOfClass: [NSDecimalNumber class]] && ![number isEqualToNumber: [NSDecimalNumber notANumber]];
}
/**
 验证货币金额合法性
 
 @param number 货币金额Number
 @return 是否合法
 */
CG_INLINE BOOL NHValidCurrencyNumber(NSDecimalNumber *number) {
    return (NHValidDecimalNumber(number) &&
            ![number isEqualToNumber: [NSDecimalNumber notANumber]] &&
            [number compare: [NSDecimalNumber zero]] == NSOrderedDescending);
}
/**
 验证货币金额合法性
 
 @param str 货币金额字符串
 @return 是否合法
 */
CG_INLINE BOOL NHValidCurrencyNumberStr(NSString *str) {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString: NHStringify(str)];
    return NHValidCurrencyNumber(number);
}
/**
 有效货币金额
 
 @param str 货币金额字符串
 @return NSDecimalNumber
 */
CG_INLINE NSDecimalNumber * NHSafeCurrencyDecimalNumber(NSString *str) {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString: NHStringify(str)];
    if (!NHValidCurrencyNumber(number)) {
        return [NSDecimalNumber zero];
    }
    return number;
}

/**
 zero金额

 @param number 货币金额
 @return NSDecimalNumber
 */
CG_INLINE BOOL NHZeroCurrencyDecimalNumber(NSDecimalNumber *number) {
    if (!NHValidDecimalNumber(number)) {
        return YES;
    }
    return [number isKindOfClass: [NSDecimalNumber class]] &&
    [number isEqualToNumber: [NSDecimalNumber zero]];
}
/**
 zero金额
 
 @param str 货币金额字符串
 @return NSDecimalNumber
 */
CG_INLINE BOOL NHZeroCurrencyDecimalNumberStr(NSString *str) {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString: NHStringify(str)];
    return NHZeroCurrencyDecimalNumber(number);
}

#pragma mark - Radian
CG_INLINE CGFloat DegreesToRadian(CGFloat degrees)
{
    return M_PI*(degrees)/180.0;
}
CG_INLINE CGFloat RadianToDegrees(CGFloat radian)
{
    return 180.0*(radian)/M_PI;
}

#pragma mark - Animation
CG_INLINE void perform_view_animate_with_duration_delay_finished_block(NSTimeInterval duration, NSTimeInterval delay, void(^animation)(void), void(^completion)(BOOL finished)) {
    [UIView animateWithDuration:duration delay:delay
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut
                     animations:animation
                     completion:completion];
}
CG_INLINE void perform_view_animate_with_duration_finished_block(NSTimeInterval duration, void(^animation)(void), void(^completion)(BOOL finished)) {
    perform_view_animate_with_duration_delay_finished_block(duration, 0, animation, completion);
}
CG_INLINE void perform_view_animate_with_finished_block(void(^animation)(void), void(^completion)(BOOL finished)) {
    perform_view_animate_with_duration_finished_block(0.25, animation, completion);
}
CG_INLINE void perform_view_animate(void(^animation)(void)) {
    perform_view_animate_with_duration_finished_block(0.25, animation, NULL);
}
CG_INLINE void perform_view_animate_with_duration(NSTimeInterval duration, void(^animation)(void)) {
    perform_view_animate_with_duration_finished_block(duration, animation, NULL);
}
CG_INLINE void perform_damping_view_animate_with_duration_delay_finished_block(NSTimeInterval duration, NSTimeInterval delay, void(^animation)(void), void(^completion)(BOOL finished)) {
    [UIView animateWithDuration:duration delay:delay
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn
                     animations:animation completion:completion];
}
CG_INLINE void perform_damping_view_animate(void(^animation)(void)) {
    perform_damping_view_animate_with_duration_delay_finished_block(0.25, 0, animation, NULL);
}
CG_INLINE void perform_damping_view_animate_with_duration(NSTimeInterval duration, void(^animation)(void)) {
    perform_damping_view_animate_with_duration_delay_finished_block(duration, 0, animation, NULL);
}
CG_INLINE void perform_damping_view_animate_with_duration_delay(NSTimeInterval duration, NSTimeInterval delay, void(^animation)(void)) {
    perform_damping_view_animate_with_duration_delay_finished_block(duration, delay, animation, NULL);
}
CG_INLINE void perform_damping_view_animate_with_duration_finished_block(NSTimeInterval duration, void(^animation)(void), void(^completion)(BOOL finished)) {
    perform_damping_view_animate_with_duration_delay_finished_block(duration, 0, animation, completion);
}


CG_INLINE NSString * KLS(NSString *key, NSString *comment) {
    return key;
}

#endif /* FMBaseFunctionsDef_h */
