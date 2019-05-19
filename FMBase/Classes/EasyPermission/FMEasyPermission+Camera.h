//
//  FMEasyPermission+Camera.h
//  Pods
//
//  Created by yitailong on 2019/5/19.
//


#import "FMEasyPermission.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMEasyPermission (Camera)

+ (EasyAuthorityStatus)checkCameraAuthority;
+ (void)requestCameraPermission:(StatusBlock)statusBlock;

@end

NS_ASSUME_NONNULL_END
