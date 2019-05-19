//
//  FMEasyPermission+Camera.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+Camera.h"
#import <AVFoundation/AVFoundation.h>

@implementation FMEasyPermission (Camera)

+ (EasyAuthorityStatus)checkCameraAuthority{
    return (EasyAuthorityStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

+ (void)requestCameraPermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.camera_lock)
    EasyAuthorityStatus st = [self checkCameraAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    kFM_UNLOCK(EasyPermission.camera_lock)
                    EasyAuthorityStatus cst = EasyAuthorizationStatusDenied;
                    if (granted) {
                        cst = EasyAuthorizationStatusAuthorized;
                    }
                    dispatch_main_async_safe(^{
                        statusBlock == nil?:statusBlock(cst);
                    })
                }];
            }
                break;
            case EasyAuthorizationStatusRestricted:
            {
                kFM_UNLOCK(EasyPermission.camera_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.camera_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.camera_lock)
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
