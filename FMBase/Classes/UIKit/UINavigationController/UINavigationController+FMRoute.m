//
//  UINavigationController+FMRoute.m
//  Pods
//
//

#import "UINavigationController+FMRoute.h"
#import "FMURLRouter.h"
#import "FMBaseFunctionsDef.h"
#import "FMURLRoutable.h"
#import <ReactiveObjC/RACTuple.h>

@implementation UINavigationController (FMRoute)

- (NSURL *)fm_formatURLFromPageStr:(NSString *)page params:(NSDictionary *)params {
    if (!NHValidStringify(page)) {
        return nil;
    }
    NSMutableString * urlStr = [NSMutableString stringWithFormat: @"%@://%@/%@",
                                [FMURLRouter shareInstance].routerScheme, [FMURLRouter shareInstance].routerHost, page];
    urlStr = [[urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<>+"].invertedSet] mutableCopy];
    NSString *paramStr = [NSURL queryStringForRawDicParameters:params];
    if (NHValidStringify(paramStr)) {
        [urlStr appendFormat: @"?%@", paramStr];
    }
    
    return [NSURL URLWithString: urlStr];
}

- (void)fm_pushWithURL:(NSURL *)url {
    [self fm_launchPageWithUrl: url model: kOpenMethodPush];
}

- (void)fm_pushWithURLString:(NSString *)urlStr {
    if (NHValidStringify(urlStr)) {
        [self fm_pushWithURL: [NSURL URLWithString: urlStr]];
    }
}

- (void)fm_pushToPage:(NSString *)page params:(NSDictionary *)params {
    [self fm_pushWithURL: [self fm_formatURLFromPageStr: page params: params]];
}

- (void)fm_pushToPageClass:(Class)cls params:(NSDictionary *)params {
    if ([cls conformsToProtocol: @protocol(FMURLRoutable)]) {
        [self fm_pushToPage: [cls pageKey] params: params];
    }
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)fm_popToPage:(NSString *)page {
    FMURLRouter *router = [FMURLRouter shareInstance];
    NSURL *url = [self fm_formatURLFromPageStr: page params: nil];
    if (![router canOpenURL: url]) {
        return;
    }
    __block UIViewController *controller = nil;
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj,
                                                       NSUInteger idx,
                                                       BOOL * _Nonnull stop) {
        Class<FMURLRoutable> cls = [obj class];
        if ([cls respondsToSelector: @selector(pageKey)] &&
            [[cls pageKey] isEqualToString: page]) {
            controller = obj;
            *stop = YES;
        }
    }];
    if (!controller) {
        RACTuple *tuple = [router performSelector: NSSelectorFromString(@"routableClassForURL:")
                                       withObject: url];
        controller = [[tuple.first alloc] init];
    }
    UIViewController *lastController = [self.viewControllers lastObject];
    [self setViewControllers: @[controller, lastController] animated: NO];
    [self popViewControllerAnimated: YES];
}
#pragma clang diagnostic pop

- (void)fm_presentWithURL:(NSURL *)url {
    [self fm_launchPageWithUrl: url model: kOpenMethodPresent];
}

- (void)fm_presentWithURLString:(NSString *)urlStr {
    if (NHValidStringify(urlStr)) {
        [self fm_presentWithURL: [NSURL URLWithString: urlStr]];
    }
}

- (void)fm_presentToPage:(NSString *)page params:(NSDictionary *)params {
    [self fm_presentWithURL: [self fm_formatURLFromPageStr: page params: params]];
}

- (void)fm_presentToPageClass:(Class)cls params:(NSDictionary *)params {
    if ([cls conformsToProtocol: @protocol(FMURLRoutable)]) {
        [self fm_presentToPage: [cls pageKey] params: params];
    }
}

- (void)fm_launchPageWithUrl:(NSURL *)url model:(kOpenMethod)model {
    if (!url) {
        return;
    }
    FMURLRouter *router = [FMURLRouter shareInstance];
    if ([router canOpenURL: url]) {
        [router openURL: url model: model inNavi: self];
        return;
    }
}

@end
