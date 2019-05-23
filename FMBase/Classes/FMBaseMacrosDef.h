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

/**  < 获取系统版本 >  */
#define kWB_IOS_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

/**  < 系统版本判断 >  */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

/**  < 判断 iOS 8 或更高的系统版本 >  */
#define kFM_SYSTEM_VERSION_8_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")

/**  < 判断 iOS 9 或更高的系统版本 >  */
#define kFM_SYSTEM_VERSION_9_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")

/**  < 判断 iOS 11 或更高的系统版本 >  */
#define kFM_SYSTEM_VERSION_11_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")


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

#ifndef kFM_LOCK
#define kFM_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef kFM_UNLOCK
#define kFM_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

#endif /* FMBaseMacrosDef_h */
