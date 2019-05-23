//
//  FMTextSize.m
//  Pods
//
//  Created by yitailong on 2019/5/22.
//

#import "FMTextSize.h"

@implementation FMTextSize

+ (CGFloat)heightForAttributedString:(NSAttributedString *)text maxWidth:(CGFloat)maxWidth {
    if ([text isKindOfClass:[NSString class]] && !text.length) {
        // no text means no height
        return 0;
    }
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options context:nil].size;
    
    CGFloat height = ceilf(size.height) + 1; // add 1 point as padding
    
    return height;
}

+ (CGFloat)heightForString:(NSString *)text font:(UIFont *)font maxWidth:(CGFloat)maxWidth {
    if (![text isKindOfClass:[NSString class]] || !text.length) {
        // no text means no height
        return 0;
    }
    
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{ NSFontAttributeName : font };
    CGSize size = [text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:options attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height) + 1; // add 1 point as padding
    
    return height;
}

@end
