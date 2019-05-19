//
//  NSMutableAttributedString+FMAttributedStringBuilder.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "NSMutableAttributedString+FMAttributedStringBuilder.h"
#import <objc/runtime.h>
#import "NSAttributedString+YYText.h"

@interface NSMutableAttributedString ()

@property (nonatomic, strong) NSArray *scr_ranges;

@end

@implementation NSMutableAttributedString (FMAttributedStringBuilder)

- (NSArray *)scr_ranges {
    return objc_getAssociatedObject(self, @selector(scr_ranges));
}

- (void)setScr_ranges:(NSArray *)scr_ranges {
    objc_setAssociatedObject(self, @selector(scr_ranges), scr_ranges, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (NSMutableAttributedString *(^)(NSString *string))fm_build{
    return ^(NSString *string){
        NSRange range = NSMakeRange(0, string.length);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        attributedString.scr_ranges = @[[NSValue valueWithRange:range]];
        return attributedString;
    };
}

- (NSMutableAttributedString *(^)(NSString *))fm_append {
    return ^(NSString *string) {
        NSRange range = NSMakeRange(self.length, string.length);
        [self appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
        self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSAttributedString *))fm_attributedAppend {
    return ^(NSAttributedString *attributedString) {
        NSRange range = NSMakeRange(self.length, attributedString.string.length);
        [self appendAttributedString:attributedString];
        self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSUInteger index))fm_insert {
    return ^(NSString *string, NSUInteger index) {
        if (index > self.length) {
            return self;
        }
        [self insertAttributedString:[[NSAttributedString alloc] initWithString:string]
                             atIndex:index];
        NSRange range = NSMakeRange(index, string.length);
        self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fm_appendSpacing {
    return ^(CGFloat spacing) {
        if (spacing <= 0) {
            return self;
        }
        
        // 原理是：字号为 1 的系统字体空格正好是 1 像素
        NSInteger pixels = (NSInteger)roundf(spacing * [UIScreen mainScreen].scale);
        NSMutableString *spaces = [[NSMutableString alloc] init];
        for (NSInteger i = 0; i < pixels; i++) {
            [spaces appendString:@" "];
        }
        
        [self appendAttributedString:[[NSAttributedString alloc] initWithString:spaces
                                                                     attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:1] }]];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat spacing))fm_headSpacing {
    return ^(CGFloat spacing) {
        if (spacing <= 0) {
            return self;
        }
        NSMutableArray *ranges = [NSMutableArray array];
        for (NSInteger index = 0; index < self.scr_ranges.count; index++) {
            NSRange range = [self.scr_ranges[index] rangeValue];
            
            // 原理是：字号为 1 的系统字体空格正好是 1 像素
            NSInteger pixels = (NSInteger)roundf(spacing * [UIScreen mainScreen].scale);
            NSMutableString *spaces = [[NSMutableString alloc] init];
            for (NSInteger i = 0; i < pixels; i++) {
                [spaces appendString:@" "];
            }
            [self insertAttributedString:[[NSAttributedString alloc] initWithString:spaces
                                                                         attributes:@{ NSFontAttributeName: [UIFont systemFontOfSize:1] }]
                                 atIndex:range.location];
            range.location += (index + 1);
            [ranges addObject:[NSValue valueWithRange:range]];
        }
        self.scr_ranges = [ranges copy];
        return self;
    };
}

// https://stackoverflow.com/questions/26105803/center-nstextattachment-image-next-to-single-line-uilabel
- (NSMutableAttributedString *(^)(UIImage *))fm_appendImage {
    return ^(UIImage *image) {
        return self.fm_appendSizeImage(image, image.size);
    };
}

- (NSMutableAttributedString *(^)(UIImage *, CGSize))fm_appendSizeImage {
    return ^(UIImage *image, CGSize imageSize) {
        for (NSInteger index = 0; index < self.scr_ranges.count; index++) {
            NSRange range = [self.scr_ranges[index] rangeValue];
            UIFont *font = [self attribute:NSFontAttributeName atIndex:range.length - 1 effectiveRange:nil];
            CGFloat offset = 0;
            if (font) {
                offset = roundf(font.descender - imageSize.height / 2 + font.descender + font.capHeight + 2);
            }
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = image;
            attachment.bounds = CGRectMake(0, offset, imageSize.width, imageSize.height);
            [self appendAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIImage *, CGSize, NSUInteger, UIFont *))fm_insertImage {
    return ^(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font) {
        CGFloat offset =  roundf(font.descender - imageSize.height / 2 + font.descender + font.capHeight + 2);
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        attachment.bounds = CGRectMake(0, offset, imageSize.width, imageSize.height);
        [self insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]
                             atIndex:index];
        NSMutableArray *ranges = [NSMutableArray array];
        for (NSInteger i = 0; i < self.scr_ranges.count; i++) {
            NSRange range = [self.scr_ranges[i] rangeValue];
            range.location += 1;
            [ranges addObject:[NSValue valueWithRange:range]];
        }
        self.scr_ranges = [ranges copy];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, UIFont *font))fm_headInsertImage {
    return ^(UIImage *image, UIFont *font){
        return  self.fm_headInsertSizeImage(image, image.size, font);
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))fm_headInsertSizeImage {
    return ^(UIImage *image, CGSize imageSize, UIFont *font) {
        NSMutableArray *ranges = [NSMutableArray array];
        for (NSInteger index = 0; index < self.scr_ranges.count; index++) {
            NSRange range = [self.scr_ranges[index] rangeValue];
            CGFloat offset =  roundf(font.descender - imageSize.height / 2 + font.descender + font.capHeight + 2);
            NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
            attachment.image = image;
            attachment.bounds = CGRectMake(0, offset, imageSize.width, imageSize.height);
            [self insertAttributedString:[NSAttributedString attributedStringWithAttachment:attachment]
                                 atIndex:range.location];
            range.location += (index + 1);
            [ranges addObject:[NSValue valueWithRange:range]];
        }
        self.scr_ranges = [ranges copy];
        return self;
    };
}

#pragma mark - YYTextAttachment
- (NSMutableAttributedString *(^)(UIImage *image))fm_yyappendImage {
    return ^(UIImage *image) {
        return self.fm_yyappendSizeImage(image, image.size);
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize))fm_yyappendSizeImage {
    return ^(UIImage *image, CGSize imageSize){
        for (NSInteger index = 0; index < self.scr_ranges.count; index++) {
            NSRange range = [self.scr_ranges[index] rangeValue];
            UIFont *font = [self attribute:NSFontAttributeName atIndex:range.length - 1 effectiveRange:nil];
            if (font) {
                NSMutableAttributedString *attachmentAttributedString = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:imageSize alignToFont:font alignment:YYTextVerticalAlignmentCenter];
                [self appendAttributedString:attachmentAttributedString];
            }
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font))fm_yyinsertImage{
    return ^(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font) {
        NSMutableAttributedString *attachmentAttributedString = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:imageSize alignToFont:font alignment:YYTextVerticalAlignmentCenter];
        [self insertAttributedString:attachmentAttributedString
                             atIndex:index];
        NSMutableArray *ranges = [NSMutableArray array];
        for (NSInteger i = 0; i < self.scr_ranges.count; i++) {
            NSRange range = [self.scr_ranges[i] rangeValue];
            range.location += attachmentAttributedString.length;
            [ranges addObject:[NSValue valueWithRange:range]];
        }
        self.scr_ranges = [ranges copy];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, UIFont *font))fm_yyheadInsertImage{
    return ^(UIImage *image, UIFont *font){
        return  self.fm_yyheadInsertSizeImage(image, image.size, font);
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))fm_yyheadInsertSizeImage{
    return ^(UIImage *image, CGSize imageSize, UIFont *font) {
        NSMutableArray *ranges = [NSMutableArray array];
        for (NSInteger index = 0; index < self.scr_ranges.count; index++) {
            NSRange range = [self.scr_ranges[index] rangeValue];
            NSMutableAttributedString *attachmentAttributedString = [NSMutableAttributedString attachmentStringWithContent:image contentMode:UIViewContentModeScaleToFill attachmentSize:imageSize alignToFont:font alignment:YYTextVerticalAlignmentCenter];
            [self insertAttributedString:attachmentAttributedString
                                 atIndex:range.location];
            range.location += (attachmentAttributedString.length + 1);
            [ranges addObject:[NSValue valueWithRange:range]];
        }
        self.scr_ranges = [ranges copy];
        return self;
    };
}

#pragma mark - Basic
- (NSMutableAttributedString *(^)(UIFont *font))fm_font{
    return ^(UIFont *font){
        [self fm_addAttribute:NSFontAttributeName value:font];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))fm_color {
    return ^(UIColor *color) {
        [self fm_addAttribute:NSForegroundColorAttributeName value:color];
        return self;
    };
}

#pragma mark - Range
- (NSMutableAttributedString *)fm_all {
    NSRange range = NSMakeRange(0, self.length);
    self.scr_ranges = @[ [NSValue valueWithRange:range] ];
    return self;
}

- (NSMutableAttributedString *(^)(NSString *))fm_match {
    return ^(NSString *string) {
        if (string.length == 0) {
            self.scr_ranges = @[];
            return self;
        }
        NSMutableArray *ranges = [NSMutableArray array];
        NSRange searchRange = NSMakeRange(0, self.length);
        NSRange foundRange;
        while (searchRange.location < self.string.length) {
            foundRange = [self.string rangeOfString:string options:0 range:searchRange];
            if (foundRange.location == NSNotFound) {
                break;
            }
            [ranges addObject:[NSValue valueWithRange:foundRange]];
            searchRange.location = foundRange.location + foundRange.length;
            searchRange.length = self.string.length - searchRange.location;
        }
        self.scr_ranges = [ranges copy];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))fm_matchFirst {
    return ^(NSString *string) {
        if (string.length == 0) {
            self.scr_ranges = @[];
            return self;
        }
        NSRange range = [self.string rangeOfString:string];
        if (range.location != NSNotFound) {
            self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *))fm_matchLast {
    return ^(NSString *string) {
        if (string.length == 0) {
            self.scr_ranges = @[];
            return self;
        }
        NSRange range = [self.string rangeOfString:string options:NSBackwardsSearch];
        if (range.location != NSNotFound) {
            self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        }
        return self;
    };
}

#pragma mark - Paragraph
- (NSMutableAttributedString *(^)(NSUnderlineStyle))fm_underlineStyle {
    return ^(NSUnderlineStyle style) {
        [self fm_addAttribute:NSUnderlineStyleAttributeName value:@(style)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))fm_underlineColor {
    return ^(UIColor * color) {
        [self fm_addAttribute:NSUnderlineColorAttributeName value:color];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fm_lineSpacing {
    return ^(CGFloat lineSpacing) {
        [self fm_configParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
            paragraphStyle.lineSpacing = lineSpacing;
        }];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fm_lineHeight {
    return ^(CGFloat lineHeight) {
        [self fm_configParagraphStyle:^(NSMutableParagraphStyle *style) {
            style.minimumLineHeight = lineHeight;
            style.maximumLineHeight = lineHeight;
        }];
        for (NSValue *value in self.scr_ranges) {
            CGFloat offset = 0;
            NSRange range = [value rangeValue];
            NSInteger index = range.location + range.length - 1;
            UIFont *font = [self attribute:NSFontAttributeName atIndex:index effectiveRange:nil];
            if (font) {
                offset = (lineHeight - font.lineHeight) / 4;
            }
            [self addAttribute:NSBaselineOffsetAttributeName value:@(offset) range:range];
        }
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fm_yylineHeight {
    return ^(CGFloat lineHeight) {
        [self fm_configParagraphStyle:^(NSMutableParagraphStyle *style) {
            style.minimumLineHeight = lineHeight;
            style.maximumLineHeight = lineHeight;
        }];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))fm_paragraphSpacing {
    return ^(CGFloat paragraphSpacing) {
        [self fm_configParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
            paragraphStyle.paragraphSpacing = paragraphSpacing;
        }];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSTextAlignment))fm_alignment {
    return ^(NSTextAlignment alignment) {
        [self fm_configParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
            paragraphStyle.alignment = alignment;
        }];
        return self;
    };
}


#pragma mark - Private
- (void)fm_addAttribute:(NSAttributedStringKey)name value:(id)value {
    for (NSValue *rangeValue in self.scr_ranges) {
        NSRange range = [rangeValue rangeValue];
        [self addAttribute:name value:value range:range];
    }
}

- (void)fm_configParagraphStyle:(void (^)(NSMutableParagraphStyle *style))block {
    for (NSValue *value in self.scr_ranges) {
        NSRange range = [value rangeValue];
        NSInteger index = range.location + range.length - 1;
        NSMutableParagraphStyle *paragraphStyle = [[self attribute:NSParagraphStyleAttributeName atIndex:index effectiveRange:nil] mutableCopy];
        if (!paragraphStyle) {
            paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        }
        block(paragraphStyle);
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
}


@end
