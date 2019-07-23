//
//  FMBase.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#ifndef FMBase_h
#define FMBase_h

#pragma mark - Def
#import "FMBaseMacrosDef.h"
#import "FMBaseFunctionsDef.h"

#pragma mark - Foundation
#import "NSDate+FMFormatter.h"
#import "NSDate+FMDisplayTime.h"
#import "NSObject+FMMethodSwizzle.h"
#import "NSString+FMEnDeCoding.h"
#import "NSURL+FMExtension.h"

#pragma mark - NSAttributedString
#import "NSAttributedString+FMStringWithFormat.h"
#import "NSString+FMAttributedStringBuilder.h"
#import "NSMutableAttributedString+FMAttributedStringBuilder.h"

#pragma mark - UIKit
#import "UIButton+FMCountDown.h"
#import "UIButton+FMImageTitleSpacing.h"
#import "UIColor+FMExtension.h"
#import "UIColor+FMOpacity.h"
#import "UIImage+FMColored.h"
#import "UIImageView+FMWebCache.h"
#import "UILabel+FMSize.h"
#import "UITableView+FMDequeueReusable.h"
#import "UITextField+FMInputLimit.h"
#import "UIView+FMBlockGesture.h"
#import "UIView+FMDraggable.h"
#import "UIView+FMExtension.h"
#import "UIViewController+FMDestory.h"
#import "UINavigationController+FMExtension.h"
#import "UINavigationController+FMRoute.h"
#import "FMAlertController.h"
#import "FMSheetController.h"

#pragma mark - Networking
#import "FMHttpManager.h"
#import "FMHttpRequest.h"
#import "FMHttpUtils.h"
#import "FMHttpConfig.h"

#pragma mark - Tool
#import "FMDateFormatterPool.h"
#import "FMExceptionLog.h"
#import "FMNavgation.h"
#import "FMUIStyle.h"
#import "FMTextSize.h"
#import "FMJson.h"

#pragma mark - EasyPermission
#import "FMEasyPermission.h"
#import "FMEasyPermission+AddressBook.h"
#import "FMEasyPermission+Calendar.h"
#import "FMEasyPermission+Camera.h"
#import "FMEasyPermission+Location.h"
#import "FMEasyPermission+MediaLibrary.h"
#import "FMEasyPermission+Microphone.h"
#import "FMEasyPermission+Notification.h"
#import "FMEasyPermission+PhotoLibrary.h"
#import "FMEasyPermission+Reminder.h"

#pragma mark - URLRouter
#import "FMURLRouter.h"
#import "FMURLRouterInfo.h"
#import "FMURLRoutable.h"

#endif /* FMBase_h */
