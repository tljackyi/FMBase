//
//  FMEasyPermission+Calendar.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+Calendar.h"
#import <EventKit/EventKit.h>

@implementation FMEasyPermission (Calendar)

+ (EasyAuthorityStatus)checkCalendarAuthority{
    return (EasyAuthorityStatus)[EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
}
+ (void)requestCalendarPermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.calendar_lock)
    EasyAuthorityStatus st = [self checkCalendarAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [[EKEventStore new] requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
                    kFM_UNLOCK(EasyPermission.calendar_lock)
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
                kFM_UNLOCK(EasyPermission.calendar_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.calendar_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.calendar_lock)
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
