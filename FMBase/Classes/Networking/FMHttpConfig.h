//
//  FMHttpConfig.h
//  Pods
//
//  Created by yitailong on 2019/6/6.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FMHTTPReqContentType) {
    FMHTTPReqContentType_Json,
    FMHTTPReqContentType_Urlencoded
};

CG_INLINE NSString* FMReqContentTypeToAFReq(FMHTTPReqContentType contentType){
    if (contentType == FMHTTPReqContentType_Json) {
        return NSStringFromClass([AFJSONRequestSerializer class]);
    }
    return NSStringFromClass([AFHTTPRequestSerializer class]);
}

@interface FMHttpConfig : NSObject

@property (nonatomic, copy) NSString *codeKey;
@property (nonatomic, assign) FMHTTPReqContentType contentType;

@end

NS_ASSUME_NONNULL_END
