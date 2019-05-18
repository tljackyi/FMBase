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

+ (NSMutableAttributedString *(^)(NSString *string))build{
    return ^(NSString *string){
        NSRange range = NSMakeRange(0, string.length);
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
        attributedString.scr_ranges = @[[NSValue valueWithRange:range]];
        return attributedString;
    };
}

- (NSMutableAttributedString *(^)(NSString *))append {
    return ^(NSString *string) {
        NSRange range = NSMakeRange(self.length, string.length);
        [self appendAttributedString:[[NSAttributedString alloc] initWithString:string]];
        self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSAttributedString *))attributedAppend {
    return ^(NSAttributedString *attributedString) {
        NSRange range = NSMakeRange(self.length, attributedString.string.length);
        [self appendAttributedString:attributedString];
        self.scr_ranges = @[ [NSValue valueWithRange:range] ];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSString *, NSUInteger index))insert {
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

- (NSMutableAttributedString *(^)(CGFloat))appendSpacing {
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

- (NSMutableAttributedString *(^)(CGFloat spacing))headSpacing {
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
- (NSMutableAttributedString *(^)(UIImage *))appendImage {
    return ^(UIImage *image) {
        return self.appendSizeImage(image, image.size);
    };
}

- (NSMutableAttributedString *(^)(UIImage *, CGSize))appendSizeImage {
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

- (NSMutableAttributedString *(^)(UIImage *, CGSize, NSUInteger, UIFont *))insertImage {
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

- (NSMutableAttributedString *(^)(UIImage *image, UIFont *font))headInsertImage {
    return ^(UIImage *image, UIFont *font){
        return  self.headInsertSizeImage(image, image.size, font);
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))headInsertSizeImage {
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
- (NSMutableAttributedString *(^)(UIImage *image))yyappendImage {
    return ^(UIImage *image) {
        return self.yyappendSizeImage(image, image.size);
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize))yyappendSizeImage {
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

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font))yyinsertImage{
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

- (NSMutableAttributedString *(^)(UIImage *image, UIFont *font))yyheadInsertImage{
    return ^(UIImage *image, UIFont *font){
        return  self.yyheadInsertSizeImage(image, image.size, font);
    };
}

- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))yyheadInsertSizeImage{
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
- (NSMutableAttributedString *(^)(UIFont *font))font{
    return ^(UIFont *font){
        [self addAttribute:NSFontAttributeName value:font];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))color {
    return ^(UIColor *color) {
        [self addAttribute:NSForegroundColorAttributeName value:color];
        return self;
    };
}

#pragma mark - Range
- (NSMutableAttributedString *)all {
    NSRange range = NSMakeRange(0, self.length);
    self.scr_ranges = @[ [NSValue valueWithRange:range] ];
    return self;
}

- (NSMutableAttributedString *(^)(NSString *))match {
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

- (NSMutableAttributedString *(^)(NSString *))matchFirst {
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

- (NSMutableAttributedString *(^)(NSString *))matchLast {
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
- (NSMutableAttributedString *(^)(NSUnderlineStyle))underlineStyle {
    return ^(NSUnderlineStyle style) {
        [self addAttribute:NSUnderlineStyleAttributeName value:@(style)];
        return self;
    };
}

- (NSMutableAttributedString *(^)(UIColor *))underlineColor {
    return ^(UIColor * color) {
        [self addAttribute:NSUnderlineColorAttributeName value:color];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))lineSpacing {
    return ^(CGFloat lineSpacing) {
        [self configParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
            paragraphStyle.lineSpacing = lineSpacing;
        }];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))lineHeight {
    return ^(CGFloat lineHeight) {
        [self configParagraphStyle:^(NSMutableParagraphStyle *style) {
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

- (NSMutableAttributedString *(^)(CGFloat))yylineHeight {
    return ^(CGFloat lineHeight) {
        [self configParagraphStyle:^(NSMutableParagraphStyle *style) {
            style.minimumLineHeight = lineHeight;
            style.maximumLineHeight = lineHeight;
        }];
        return self;
    };
}

- (NSMutableAttributedString *(^)(CGFloat))paragraphSpacing {
    return ^(CGFloat paragraphSpacing) {
        [self configParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
            paragraphStyle.paragraphSpacing = paragraphSpacing;
        }];
        return self;
    };
}

- (NSMutableAttributedString *(^)(NSTextAlignment))alignment {
    return ^(NSTextAlignment alignment) {
        [self configParagraphStyle:^(NSMutableParagraphStyle *paragraphStyle) {
            paragraphStyle.alignment = alignment;
        }];
        return self;
    };
}


#pragma mark - Private
- (void)addAttribute:(NSAttributedStringKey)name value:(id)value {
    for (NSValue *rangeValue in self.scr_ranges) {
        NSRange range = [rangeValue rangeValue];
        [self addAttribute:name value:value range:range];
    }
}

- (void)configParagraphStyle:(void (^)(NSMutableParagraphStyle *style))block {
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
