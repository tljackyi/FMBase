//
//  UIImageView+FMWebCache.h
//  Pods
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (FMWebCache)

- (void)fm_setRoundImageWithURL:(NSString *)imageURL
                    placeholder:(nullable UIImage *)placeholder;

- (void)fm_setImageWithURL:(NSString *)imageURL
               placeholder:(nullable UIImage *)placeholder;

- (void)fm_setImageWithURL:(NSString *)imageURL
               placeholder:(nullable UIImage *)placeholder
                 imageSize:(CGSize)imageSize;

- (void)fm_setImageWithURL:(NSString *)imageURL
               placeholder:(nullable UIImage *)placeholder
                 imageSize:(CGSize)imageSize
              cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
