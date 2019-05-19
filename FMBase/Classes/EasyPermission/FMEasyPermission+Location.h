//
//  FMEasyPermission+Location.h
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMEasyPermission (Location)

+ (EasyAuthorityStatus)checkLocationAuthority;
+ (void)requestLocationPermissionType:(EasyLocationRequestType)type completion:(StatusBlock)statusBlock;


@end

NS_ASSUME_NONNULL_END
