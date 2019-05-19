//
//  FMEasyPermission.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission.h"

@interface FMEasyPermission ()

@property (strong, readwrite, nonatomic) dispatch_queue_t  concurrentQueue;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    photoLibrary_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    camera_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    addressBook_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    microphone_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    mediaLibrary_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    bluetooth_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    notifications_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    calendar_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    reminder_lock;
@property (strong, readwrite, nonatomic) dispatch_semaphore_t    location_lock;

@end

@implementation FMEasyPermission

static id instance = nil;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

+ (void)openSetting{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    kFM_UNLOCK(EasyPermission.location_lock)

    if (!_locationBlock) return;
    if (status == kCLAuthorizationStatusNotDetermined) return;  // first request location
    
    if (status == kCLAuthorizationStatusAuthorizedAlways ||
        status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        dispatch_main_async_safe(^{
            self.locationBlock(EasyAuthorizationStatusAuthorized);
        });
    }else if (status == kCLAuthorizationStatusDenied){
        dispatch_main_async_safe(^{
            self.locationBlock(EasyAuthorizationStatusDenied);
        });
    }
    self.lmg.delegate = nil;
}

#pragma mark - getter
- (dispatch_queue_t)concurrentQueue{
    if (!_concurrentQueue) {
        _concurrentQueue = dispatch_queue_create("com.queue.easypermission", DISPATCH_QUEUE_CONCURRENT);
    }
    return _concurrentQueue;
}

- (dispatch_semaphore_t)photoLibrary_lock{
    if (!_photoLibrary_lock) {
        _photoLibrary_lock = dispatch_semaphore_create(1);
    }
    return _photoLibrary_lock;
}

- (dispatch_semaphore_t)camera_lock{
    if (!_camera_lock) {
        _camera_lock = dispatch_semaphore_create(1);
    }
    return _camera_lock;
}

- (dispatch_semaphore_t)addressBook_lock{
    if (!_addressBook_lock) {
        _addressBook_lock = dispatch_semaphore_create(1);
    }
    return _addressBook_lock;
}

- (dispatch_semaphore_t)microphone_lock{
    if (!_microphone_lock) {
        _microphone_lock = dispatch_semaphore_create(1);
    }
    return _microphone_lock;
}

- (dispatch_semaphore_t)mediaLibrary_lock{
    if (!_mediaLibrary_lock) {
        _mediaLibrary_lock = dispatch_semaphore_create(1);
    }
    return _mediaLibrary_lock;
}

- (dispatch_semaphore_t)bluetooth_lock{
    if (!_bluetooth_lock) {
        _bluetooth_lock = dispatch_semaphore_create(1);
    }
    return _bluetooth_lock;
}

- (dispatch_semaphore_t)notifications_lock{
    if (!_notifications_lock) {
        _notifications_lock = dispatch_semaphore_create(1);
    }
    return _notifications_lock;
}

- (dispatch_semaphore_t)calendar_lock{
    if (!_calendar_lock) {
        _calendar_lock = dispatch_semaphore_create(1);
    }
    return _calendar_lock;
}

- (dispatch_semaphore_t)reminder_lock{
    if (!_reminder_lock) {
        _reminder_lock = dispatch_semaphore_create(1);
    }
    return _reminder_lock;
}

- (dispatch_semaphore_t)location_lock{
    if (!_location_lock) {
        _location_lock = dispatch_semaphore_create(1);
    }
    return _location_lock;
}


@end
