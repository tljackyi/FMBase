//
//  FMEasyPermission+MediaLibrary.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+MediaLibrary.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation FMEasyPermission (MediaLibrary)

+ (EasyAuthorityStatus)checkMediaLibraryAuthority{
    MPMediaLibraryAuthorizationStatus st = [MPMediaLibrary authorizationStatus];
    switch (st) {
        case MPMediaLibraryAuthorizationStatusNotDetermined:
        {
            return EasyAuthorizationStatusNotDetermined;
        }
            break;
        case MPMediaLibraryAuthorizationStatusDenied:
        {
            return EasyAuthorizationStatusNotDetermined;
        }
            break;
        case MPMediaLibraryAuthorizationStatusRestricted:
        {
            return EasyAuthorizationStatusRestricted;
        }
            break;
        case MPMediaLibraryAuthorizationStatusAuthorized:
        {
            return EasyAuthorizationStatusAuthorized;
        }
            break;
            
        default:
            break;
    }
}

+ (void)requestMediaLibraryPermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.mediaLibrary_lock)
    EasyAuthorityStatus st = [self checkMediaLibraryAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [MPMediaLibrary requestAuthorization:^(MPMediaLibraryAuthorizationStatus status) {
                    kFM_UNLOCK(EasyPermission.mediaLibrary_lock)
                    dispatch_main_async_safe(^{
                        statusBlock == nil?:statusBlock((EasyAuthorityStatus)status);
                    });
                }];
            }
                break;
            case EasyAuthorizationStatusRestricted:
            {
                kFM_UNLOCK(EasyPermission.mediaLibrary_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.mediaLibrary_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.mediaLibrary_lock)
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
