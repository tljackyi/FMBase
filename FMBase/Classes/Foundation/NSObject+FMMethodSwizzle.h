//
//  NSObject+FMMethodSwizzle.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (FMMethodSwizzle)

+ (void)classSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector;

+ (void)instancenSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector;

@end

NS_ASSUME_NONNULL_END
