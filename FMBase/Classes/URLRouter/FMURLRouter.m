//
//  FMURLRouter.m
//  Pods
//
//  Created by yitailong on 2019/6/20.
//

#import "FMURLRouter.h"
#import <objc/message.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "FMURLRoutable.h"

NSString * const kURLRouterScheme = @"fmbase";
NSString * const kURLRouterHost = @"fmbase.com";

@interface FMURLRouter ()

@property (strong, nonatomic) NSMutableSet *routers;

@end

@implementation FMURLRouter

+ (instancetype)shareInstance {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [self prepareRoutePool];
    }
    return self;
}

- (void)prepareRoutePool {
    Class *classes = NULL;
    Protocol *protocol = @protocol(FMURLRoutable);
    int numClasses = objc_getClassList(NULL, 0);
    if (numClasses > 0) {
        classes = (Class *) malloc(sizeof(Class) * numClasses);
        numClasses = objc_getClassList(classes, numClasses);
        for (int index = 0; index < numClasses; index++) {
            Class nextClass = classes[index];
            if (class_conformsToProtocol(nextClass, protocol)) {
                [self.routers addObject: nextClass];
            }
        }
        free(classes);
    }
}

- (BOOL)canOpenURL:(NSURL *)url {
    NSString *scheme = [url.scheme lowercaseString];
    NSString *host = [url.host lowercaseString];
    if (![scheme isEqualToString: kURLRouterScheme] ||
        ![host isEqualToString: kURLRouterHost]) {
        return NO;
    }
    Class targetClazz = [self routableClassForURL: url].first;
    return (targetClazz != nil);
}

- (FMURLRouterInfo *)parseRouterForURL:(NSURL *)url {
    FMURLRouterInfo *info = [[FMURLRouterInfo alloc] init];
    info.url = url;
    info.params = [NSURL decodedParametersForQuery: url.query];
    info.pageKey = [url.path stringByReplacingOccurrencesOfString: @"/" withString: @""];
    return info;
}

- (RACTuple *)routableClassForURL:(NSURL *)url {
    __block Class targetClazz = nil;
    FMURLRouterInfo *info = [self parseRouterForURL: url];
    [self.routers enumerateObjectsUsingBlock:^(Class  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *pageKey = ((NSString *(*)(id, SEL)) objc_msgSend)(obj, @selector(pageKey));
        if ([[info.pageKey lowercaseString] isEqualToString: [pageKey lowercaseString]]) {
            targetClazz = obj;
            *stop = YES;
        }
    }];
    return RACTuplePack(targetClazz, info);
}

- (void)openURL:(NSURL *)url model:(kOpenMethod)model inNavi:(UINavigationController *)fromVC {
    RACTuple *tuple = [self routableClassForURL: url];
    Class targetClazz = tuple.first;
    FMURLRouterInfo *info = tuple.second;
    if (targetClazz) {
        id target = [targetClazz initWithURLRouterInfo: info];
        if (!target) {
            return;
        }
        if (model == kOpenMethodPresent) {
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController: target];
            if (navi) {
                [fromVC presentViewController: navi animated: YES completion: NULL];
                return;
            }
        }
        [fromVC pushViewController: target animated: YES];
    }
}

#pragma mark - getter

- (NSMutableSet *)routers {
    if (!_routers) {
        _routers = [NSMutableSet set];
    }
    return _routers;
}


@end