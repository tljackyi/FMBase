//
//  NSObject+FMMethodSwizzle.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "NSObject+FMMethodSwizzle.h"
#import <objc/runtime.h>

@implementation NSObject (FMMethodSwizzle)

+ (void)fm_classSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector
{
    Class realClass = object_getClass(class);
    Method originMethod = class_getClassMethod(realClass, originSelector);
    Method swizzleMethod = class_getClassMethod(realClass, swizzleSelector);
    if (!originMethod || !swizzleMethod) {
        return;
    }
    
    class_addMethod(realClass,
                    originSelector,
                    method_getImplementation(originMethod),
                    method_getTypeEncoding(originMethod));
    class_addMethod(realClass,
                    swizzleSelector,
                    method_getImplementation(swizzleMethod),
                    method_getTypeEncoding(swizzleMethod));
    
    Method originMethod2 = class_getClassMethod(class, originSelector);
    Method swizzleMethod2 = class_getClassMethod(class, swizzleSelector);
    method_exchangeImplementations(originMethod2, swizzleMethod2);
}

+ (void)fm_instancenSwizzleWithClass:(Class)class originSelector:(SEL)originSelector swizzleSelector:(SEL)swizzleSelector
{
    Method originMethod = class_getInstanceMethod(class, originSelector);
    Method swizzleMethod = class_getInstanceMethod(class, swizzleSelector);
    if (!originMethod || !swizzleMethod) {
        return;
    }
    
    class_addMethod(class,
                    originSelector,
                    method_getImplementation(originMethod),
                    method_getTypeEncoding(originMethod));
    class_addMethod(class,
                    swizzleSelector,
                    method_getImplementation(swizzleMethod),
                    method_getTypeEncoding(swizzleMethod));
    
    
    ///< 添加完了之后要重新赋值，因为原来的两个method都是父类的。参考自见https://github.com/rentzsch/jrswizzle/blob/semver-1.x/JRSwizzle.m
    Method originMethod2 = class_getInstanceMethod(class, originSelector);
    Method swizzleMethod2 = class_getInstanceMethod(class, swizzleSelector);
    
    method_exchangeImplementations(originMethod2, swizzleMethod2);
}


@end
