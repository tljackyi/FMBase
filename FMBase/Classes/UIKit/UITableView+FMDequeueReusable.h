//
//  UITableView+FMDequeueReusable.h
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (FMDequeueReusable)

@property (nonatomic, strong, readonly) NSMutableSet<NSString *> *registeredCellIdentifiers;

- (__kindof UITableViewCell *)fm_dequeueReusableCellOfClass:(Class)cellClass
                                        withReuseIdentifier:(NSString *)identifier
                                               forIndexPath:(NSIndexPath *)indexPath;

- (__kindof UITableViewCell *)fm_dequeueReusableCellOfClass:(Class)cellClass
                                        withReuseIdentifier:(NSString *)identifier;
@end

NS_ASSUME_NONNULL_END
