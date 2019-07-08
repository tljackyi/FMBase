//
//  UILabel+FMSize.h
//  Pods
//
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (FMSize)

- (CGFloat)fm_suggestedSizeForWidth:(CGFloat)width;

- (CGFloat)fm_suggestSizeForString:(NSString *)string
                            width:(CGFloat)width;

+ (CGFloat)fm_suggestSizeForString:(NSString *)string
                              font:(UIFont *)font
                             width:(CGFloat)width;

+ (CGFloat)fm_suggestSizeForAttributedString:(NSAttributedString *)string
                                       width:(CGFloat)width;


- (CGFloat)fm_suggestedSizeForHeight:(CGFloat)height;

- (CGFloat)fm_suggestSizeForString:(NSString *)string
                            height:(CGFloat)height;

+ (CGFloat)fm_suggestSizeForString:(NSString *)string
                              font:(UIFont *)font
                            height:(CGFloat)height;

+ (CGFloat)fm_suggestSizeForAttributedString:(NSAttributedString *)string
                                       height:(CGFloat)height;


@end

NS_ASSUME_NONNULL_END
