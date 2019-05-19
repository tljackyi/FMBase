//
//  FMEasyPermission+Notification.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+Notification.h"
#import <UserNotifications/UserNotifications.h>

@implementation FMEasyPermission (Notification)

+ (void)checkNotificationAuthorityStatus:(StatusBlock)statusBlock{
    if ([[UIDevice currentDevice].systemVersion doubleValue] < 10.0) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        UIUserNotificationType notiTypes = settings.types;
        
        if (notiTypes == UIUserNotificationTypeNone) {
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
            });
        }else{
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(EasyAuthorizationStatusAuthorized);
            });
        }
#pragma clang diagnostic pop
    }else{
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            UNAuthorizationStatus st = settings.authorizationStatus;
            EasyAuthorityStatus est;
            switch (st) {
                case UNAuthorizationStatusNotDetermined:
                {
                    est = EasyAuthorizationStatusNotDetermined;
                }
                    break;
                case UNAuthorizationStatusDenied:
                {
                    est = EasyAuthorizationStatusDenied;
                }
                    break;
                case UNAuthorizationStatusAuthorized:
                {
                    est = EasyAuthorizationStatusAuthorized;
                }
                    break;
                    
                default:
                    break;
            }
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(est);
            });
        }];;
    }
}

@end
