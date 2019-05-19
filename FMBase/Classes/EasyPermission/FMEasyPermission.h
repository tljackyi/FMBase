//
//  FMEasyPermission.h
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define EasyPermission [FMEasyPermission shareInstance]

#ifndef kFM_LOCK
#define kFM_LOCK(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
#endif

#ifndef kFM_UNLOCK
#define kFM_UNLOCK(lock) dispatch_semaphore_signal(lock);
#endif

#ifndef dispatch_main_async_safe
#define dispatch_main_async_safe(block) dispatch_queue_async_safe(dispatch_get_main_queue(), block)
#endif

#ifndef dispatch_queue_async_safe
#define dispatch_queue_async_safe(queue, block)\
if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(queue)) {\
block();\
} else {\
dispatch_async(queue, block);\
}
#endif

typedef NS_ENUM(NSInteger,EasyAuthorityStatus){
    EasyAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
    EasyAuthorizationStatusRestricted = 1, // This application is not authorized
    EasyAuthorizationStatusDenied = 2, // User has explicitly denied this application
    EasyAuthorizationStatusAuthorized = 3, // User has authorized this application
    EasyAuthorizationStatusTurnOff = 4 // the function not open,for location.....
};


/**
 about location type
 */
typedef NS_ENUM(NSInteger,EasyLocationRequestType){
    EasyLocationRequestTypeWhenInUse = 0, // location when in use
    EasyLocationRequestTypeAlway = 1  // alway location
};

typedef void(^StatusBlock)(EasyAuthorityStatus status);

@interface FMEasyPermission : NSObject<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *lmg;
@property (copy, nonatomic) StatusBlock locationBlock;
@property (strong, readonly, nonatomic) dispatch_queue_t  concurrentQueue;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    photoLibrary_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    camera_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    addressBook_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    microphone_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    mediaLibrary_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    bluetooth_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    notifications_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    calendar_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    reminder_lock;
@property (strong, readonly, nonatomic) dispatch_semaphore_t    location_lock;

+ (instancetype)shareInstance;
+ (void)openSetting;

@end


