//
//  UITableView+FMDequeueReusable.m
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import "UITableView+FMDequeueReusable.h"
#import <objc/runtime.h>

@implementation UITableView (FMDequeueReusable)

- (NSMutableSet<NSString *> *)registeredCellIdentifiers{
    if (!objc_getAssociatedObject(self, _cmd)) {
        NSMutableSet *set = [[NSMutableSet alloc] init];
        objc_setAssociatedObject(self, @selector(registeredCellIdentifiers), set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return set;
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (__kindof UITableViewCell *)fm_dequeueReusableCellOfClass:(Class)cellClass
                                        withReuseIdentifier:(NSString *)identifier
                                               forIndexPath:(NSIndexPath *)indexPath{
    if (![self.registeredCellIdentifiers containsObject:identifier]) {
        [self.registeredCellIdentifiers addObject:identifier];
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    return [self dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (__kindof UITableViewCell *)fm_dequeueReusableCellOfClass:(Class)cellClass
                                        withReuseIdentifier:(NSString *)identifier{
    if (![self.registeredCellIdentifiers containsObject:identifier]) {
        [self.registeredCellIdentifiers addObject:identifier];
        [self registerClass:cellClass forCellReuseIdentifier:identifier];
    }
    return [self dequeueReusableCellWithIdentifier:identifier];
}

@end
