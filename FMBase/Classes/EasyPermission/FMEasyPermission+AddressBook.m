//
//  FMEasyPermission+AddressBook.m
//  Pods
//
//  Created by yitailong on 2019/5/19.
//

#import "FMEasyPermission+AddressBook.h"
#import <Contacts/Contacts.h>

@implementation FMEasyPermission (AddressBook)

+ (EasyAuthorityStatus)checkAddressBookAuthority{
    return (EasyAuthorityStatus)[CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
}

+ (void)requestAddressBookPermission:(StatusBlock)statusBlock{
    kFM_LOCK(EasyPermission.addressBook_lock);
    EasyAuthorityStatus st = [self checkAddressBookAuthority];
    dispatch_async(EasyPermission.concurrentQueue, ^{
        switch (st) {
            case EasyAuthorizationStatusNotDetermined:
            {
                [[CNContactStore new] requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    kFM_UNLOCK(EasyPermission.addressBook_lock)
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
                kFM_UNLOCK(EasyPermission.addressBook_lock);
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusRestricted);
                });
            }
                break;
            case EasyAuthorizationStatusDenied:
            {
                kFM_UNLOCK(EasyPermission.addressBook_lock);
                dispatch_main_async_safe(^{
                    statusBlock == nil?:statusBlock(EasyAuthorizationStatusDenied);
                });
            }
                break;
            case EasyAuthorizationStatusAuthorized:
            {
                kFM_UNLOCK(EasyPermission.addressBook_lock);
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
