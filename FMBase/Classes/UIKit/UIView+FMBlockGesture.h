//
//  UIView+FMBlockGesture.h
//  Pods
//
//  Created by yitailong on 2019/5/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FMTapGestureBlock)(UITapGestureRecognizer *tapGestureRecognizer);
typedef void(^FMLongPressGestureBlock)(UILongPressGestureRecognizer *lonePressGestureRecognizer);

@interface UIView (FMBlockGesture)

/**
 Add tap gesture with block.
 @param handler block handler
 */
- (UITapGestureRecognizer *)fm_addTapGestureWithHandler:(FMTapGestureBlock)handler;

/**
 Add long press gusture with block.
 @param handler block handler
 */
- (UILongPressGestureRecognizer *)fm_addLongPressGestureWithHandler:(FMLongPressGestureBlock)handler;

@end

NS_ASSUME_NONNULL_END
