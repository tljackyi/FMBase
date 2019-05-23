//
//  FMTextSize.h
//  Pods
//
//  Created by yitailong on 2019/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMTextSize : NSObject

+ (CGFloat)heightForAttributedString:(NSAttributedString *)text
                            maxWidth:(CGFloat)maxWidth;

+ (CGFloat)heightForString:(NSString *)text
                      font:(UIFont *)font
                  maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
