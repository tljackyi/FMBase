//
//  FMEasyPermission+Location.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+Location.h"
#import <CoreLocation/CoreLocation.h>

@implementation FMEasyPermission (Location)

+ (EasyAuthorityStatus)checkLocationAuthority{
    if (![CLLocationManager locationServicesEnabled]) {
        return EasyAuthorizationStatusTurnOff;
    }
    CLAuthorizationStatus st = [CLLocationManager authorizationStatus];
    if (st == kCLAuthorizationStatusAuthorizedAlways ||
        st == kCLAuthorizationStatusAuthorizedWhenInUse) {
        return EasyAuthorizationStatusAuthorized;
    }
    return (EasyAuthorityStatus)[CLLocationManager authorizationStatus];
}

+ (void)requestLocationPermissionType:(EasyLocationRequestType)type completion:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.location_lock)
    EasyAuthorityStatus st = [self checkLocationAuthority];
    switch (st) {
        case EasyAuthorizationStatusNotDetermined:
        {
            CLLocationManager *lmg = [CLLocationManager new];
            EasyPermission.lmg = lmg;
            EasyPermission.locationBlock = statusBlock;
            lmg.delegate = EasyPermission;
            if (type == EasyLocationRequestTypeWhenInUse) {
                [lmg requestWhenInUseAuthorization];
            }else{
                [lmg requestAlwaysAuthorization];
            }
        }
            break;
        case EasyAuthorizationStatusRestricted:
        {
            kFM_UNLOCK(EasyPermission.location_lock)
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
            });
        }
            break;
        case EasyAuthorizationStatusDenied:
        {
            kFM_UNLOCK(EasyPermission.location_lock)
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
            });
        }
            break;
        case EasyAuthorizationStatusAuthorized:
        {
            kFM_UNLOCK(EasyPermission.location_lock)
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(EasyAuthorizationStatusAuthorized);
            });
        }
            break;
        case EasyAuthorizationStatusTurnOff:
        {
            kFM_UNLOCK(EasyPermission.location_lock)
            dispatch_main_async_safe(^{
                statusBlock == nil?:statusBlock(EasyAuthorizationStatusTurnOff);
            });
        }
            break;
            
        default:
            break;
    }
}

@end
