//
//  UILabel+FMSize.m
//  Pods
//
//

#import "UILabel+FMSize.h"

@implementation UILabel (FMSize)

- (CGFloat)fm_suggestedSizeForWidth:(CGFloat)width {
    if (self.attributedText)
        return [[self class] fm_suggestSizeForAttributedString:self.attributedText width:width];
    
    return [self fm_suggestSizeForString:self.text width:width];
}

- (CGFloat)fm_suggestSizeForString:(NSString *)string
                            width:(CGFloat)width {
    if (!string) {
        return 0;
    }
    return [[self class] fm_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] width:width];
}

+ (CGFloat)fm_suggestSizeForString:(NSString *)string
                              font:(UIFont *)font
                             width:(CGFloat)width {
    if (!string) {
        return 0;
    }
    return [[self class] fm_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:font}] width:width];
}

+ (CGFloat)fm_suggestSizeForAttributedString:(NSAttributedString *)string  width:(CGFloat)width {
    if (!string) {
        return 0;
    }
    CGSize size = [string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return ceilf(size.height);
}

- (CGFloat)fm_suggestedSizeForHeight:(CGFloat)height{
    if (self.attributedText)
        return [[self class] fm_suggestSizeForAttributedString:self.attributedText height:height];
    
    return [self fm_suggestSizeForString:self.text height:height];
}

- (CGFloat)fm_suggestSizeForString:(NSString *)string
                            height:(CGFloat)height{
    if (!string) {
        return 0;
    }
    return [[self class] fm_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.font}] height:height];
}


+ (CGFloat)fm_suggestSizeForAttributedString:(NSAttributedString *)string
                                      height:(CGFloat)height{
    if (!string) {
        return 0;
    }
    CGSize size = [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
    return ceilf(size.width);
}

+ (CGFloat)fm_suggestSizeForString:(NSString *)string
                              font:(UIFont *)font
                            height:(CGFloat)height{
    if (!string) {
        return 0;
    }
    return [[self class] fm_suggestSizeForAttributedString:[[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: font}] height:height];
}

@end
