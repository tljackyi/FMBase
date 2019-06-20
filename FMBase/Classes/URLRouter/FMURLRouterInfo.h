//
//  FMURLRouterInfo.h
//  Pods
//
//  Created by yitailong on 2019/6/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMURLRouterInfo : NSObject

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSDictionary *params;
@property (copy,   nonatomic) NSString *pageKey;

@end

NS_ASSUME_NONNULL_END
