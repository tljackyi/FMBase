//
//  FMEasyPermission+Microphone.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+Microphone.h"
#import <AVFoundation/AVFoundation.h>

@implementation FMEasyPermission (Microphone)

+ (EasyAuthorityStatus)checkMicrophoneAuthority{
    return (EasyAuthorityStatus)[AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
}

+ (void)requestMicrophonePermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.microphone_lock)
    EasyAuthorityStatus st = [self checkMicrophoneAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                    kFM_UNLOCK(EasyPermission.microphone_lock)
                    EasyAuthorityStatus cst = EasyAuthorizationStatusDenied;
                    if (granted) {
                        cst = EasyAuthorizationStatusAuthorized;
                    }
                    dispatch_main_async_safe(^{
                        statusBlock == nil?:statusBlock(cst);
                    });
                }];
            }
                break;
            case EasyAuthorizationStatusRestricted:
            {
                kFM_UNLOCK(EasyPermission.microphone_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.microphone_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.microphone_lock)
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
