//
//  UINavigationController+FMRoute.h
//  Pods
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (FMRoute)

- (void)fm_popToPage:(NSString *)page;

- (void)fm_pushWithURL:(NSURL *)url;
- (void)fm_pushWithURLString:(NSString *)urlStr;
- (void)fm_pushToPage:(NSString *)page params:(NSDictionary *)params;
- (void)fm_pushToPageClass:(Class)cls params:(NSDictionary *)params;

- (void)fm_presentWithURL:(NSURL *)url;
- (void)fm_presentWithURLString:(NSString *)urlStr;
- (void)fm_presentToPage:(NSString *)page params:(NSDictionary *)params;
- (void)fm_presentToPageClass:(Class)cls params:(NSDictionary *)params;


@end

NS_ASSUME_NONNULL_END
