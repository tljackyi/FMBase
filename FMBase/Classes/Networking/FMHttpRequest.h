//
//  FMHttpRequest.h
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMHttpRequest : NSObject

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *methodStr;
@property (nonatomic, copy) NSString *urlStr;
@property (nonatomic, strong) NSDictionary *params;

@end

NS_ASSUME_NONNULL_END
