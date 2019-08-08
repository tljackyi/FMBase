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

@interface FMURLRouterConfig : NSObject

@property (nonatomic, copy) NSString *routerScheme;
@property (nonatomic, copy) NSString *routerHost;

@end

@interface FMURLRouter : NSObject

@property (nonatomic, copy, readonly) NSString *routerScheme;
@property (nonatomic, copy, readonly) NSString *routerHost;

+ (instancetype)shareInstance;

- (void)buildRouterConfig:(void(^)(FMURLRouterConfig *config))builder;
- (BOOL)canOpenURL:(NSURL *)url;
- (FMURLRouterInfo *)parseRouterForURL:(NSURL *)url;
- (void)openURL:(NSURL *)url model:(kOpenMethod)model inNavi:(UINavigationController *)fromVC;

@end

NS_ASSUME_NONNULL_END
