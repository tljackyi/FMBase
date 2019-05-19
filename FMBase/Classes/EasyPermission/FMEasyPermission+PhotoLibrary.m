//
//  FMEasyPermission+PhotoLibrary.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+PhotoLibrary.h"
#import <Photos/PHPhotoLibrary.h>

@implementation FMEasyPermission (PhotoLibrary)

+ (EasyAuthorityStatus)checkPhotoLibrayAuthority{
    return (EasyAuthorityStatus)[PHPhotoLibrary authorizationStatus];
}
+ (void)requestPhotoLibrayPermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.photoLibrary_lock)
    EasyAuthorityStatus st = [self checkPhotoLibrayAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                    kFM_UNLOCK(EasyPermission.photoLibrary_lock)
                    dispatch_main_async_safe(^{
                        statusBlock == nil?:statusBlock((EasyAuthorityStatus)status);
                    });
                }];
            }
                break;
            case EasyAuthorizationStatusRestricted:
            {
                kFM_UNLOCK(EasyPermission.photoLibrary_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.photoLibrary_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
                
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.photoLibrary_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusAuthorized);
                });
                
            }
                break;
                
            default:
                break;
        }
    });
}

@end
