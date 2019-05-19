//
//  FMEasyPermission+Reminder.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+Reminder.h"
#import <EventKit/EventKit.h>

@implementation FMEasyPermission (Reminder)

+ (EasyAuthorityStatus)checkReminderAuthority{
    return (EasyAuthorityStatus)[EKEventStore authorizationStatusForEntityType:EKEntityTypeReminder];
}

+ (void)requestReminderPermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.reminder_lock)
    EasyAuthorityStatus st = [self checkReminderAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [[EKEventStore new] requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError * _Nullable error) {
                    kFM_UNLOCK(EasyPermission.reminder_lock)
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
                kFM_UNLOCK(EasyPermission.reminder_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.reminder_lock)
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.reminder_lock)
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
