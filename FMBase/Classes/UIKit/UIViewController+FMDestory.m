//
//  UIViewController+FMDestory.m
//  Pods
//
//  Created by yitailong on 2019/6/6.
//

#import "UIViewController+FMDestory.h"

@implementation UIViewController (FMDestory)

- (void)fm_popOrDismissController {
    if (self.navigationController) {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated: YES];
            return;
        }
    }
    [self dismissViewControllerAnimated: YES completion: NULL];
}

@end
