//
//  FMURLRouter.h
//  Pods
//
//  Created by yitailong on 2019/6/20.
//

#import <Foundation/Foundation.h>
#import "NSURL+FMExtension.h"
#import "FMURLRouterInfo.h"

typedef NS_ENUM(NSInteger, kOpenMethod){
    kOpenMethodPush = 0,
    kOpenMethodPresent
};

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kURLRouterScheme;
extern NSString * const kURLRouterHost;

@interface FMURLRouter : NSObject

+ (instancetype)shareInstance;

- (BOOL)canOpenURL:(NSURL *)url;
- (FMURLRouterInfo *)parseRouterForURL:(NSURL *)url;
- (void)openURL:(NSURL *)url model:(kOpenMethod)model inNavi:(UINavigationController *)fromVC;

@end

NS_ASSUME_NONNULL_END
