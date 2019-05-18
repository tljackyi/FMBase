//
//  NSMutableAttributedString+FMAttributedStringBuilder.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (FMAttributedStringBuilder)

#pragma mark - Content
// 创建一个 Attributed String
+ (NSMutableAttributedString *(^)(NSString *string))build;

// 尾部追加一个新的 Attributed String
- (NSMutableAttributedString *(^)(NSString *string))append;

// 同 append 比，参数是 NSAttributedString
- (NSMutableAttributedString *(^)(NSAttributedString *attributedString))attributedAppend;

// 插入一个新的 Attributed String
- (NSMutableAttributedString *(^)(NSString *string, NSUInteger index))insert;

// 增加间隔，spacing 的单位是 point。放到 Content 的原因是，间隔是通过空格+字体模拟。
- (NSMutableAttributedString *(^)(CGFloat spacing))appendSpacing;

// 增加head间隔, 原理同appendSpacing
- (NSMutableAttributedString *(^)(CGFloat spacing))headSpacing;

#pragma mark - NSTextAttachment
// 在尾部追加图片附件，默认使用图片尺寸，图片垂直居中，为了设置处理垂直居中（基于字体的 capHeight），需要在添加图片附件之前设置字体
- (NSMutableAttributedString *(^)(UIImage *image))appendImage;

// 在尾部追加图片附件，可以自定义尺寸，其他同 appendImage
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize))appendSizeImage;

// 在 index 位置插入图片附件，由于不确定字体信息，因此需要显式输入字体
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font))insertImage;

// 默认使用图片尺寸
- (NSMutableAttributedString *(^)(UIImage *image, UIFont *font))headInsertImage;

// 同 insertImage 的区别在于，会在当前 Range 的头部插入图片附件，如果没有 Range 则什么也不做
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))headInsertSizeImage;

#pragma mark - YYTextAttachment
// YYLabel 在尾部追加图片附件
- (NSMutableAttributedString *(^)(UIImage *image))yyappendImage;

// YYLabel 在尾部追加图片附件，可以自定义尺寸，其他同 yyappendImage
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize))yyappendSizeImage;

// YLabel 在 index 位置插入图片附件，由于不确定字体信息，因此需要显式输入字体
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, NSUInteger index, UIFont *font))yyinsertImage;

// YYLabel  默认使用图片尺寸
- (NSMutableAttributedString *(^)(UIImage *image, UIFont *font))yyheadInsertImage;

// YYLabel 同 yyinsertImage 的区别在于，会在当前 Range 的头部插入图片附件，如果没有 Range 则什么也不做
- (NSMutableAttributedString *(^)(UIImage *image, CGSize imageSize, UIFont *font))yyheadInsertSizeImage;

#pragma mark - Basic
// 字体
- (NSMutableAttributedString *(^)(UIFont *font))font;

// 字体颜色
- (NSMutableAttributedString *(^)(UIColor *color))color;

#pragma mark - Range
// 将范围设置为当前字符串全部
- (NSMutableAttributedString *)all;

// 匹配所有符合的字符串
- (NSMutableAttributedString *(^)(NSString *string))match;

// 从头开始匹配第一个符合的字符串
- (NSMutableAttributedString *(^)(NSString *string))matchFirst;

// 为尾开始匹配第一个符合的字符串
- (NSMutableAttributedString *(^)(NSString *string))matchLast;


#pragma mark - Paragraph
// 下划线风格
- (NSMutableAttributedString *(^)(NSUnderlineStyle style))underlineStyle;

// 下划线颜色
- (NSMutableAttributedString *(^)(UIColor *color))underlineColor;

// 行间距
- (NSMutableAttributedString *(^)(CGFloat spacing))lineSpacing;

//行高 http://pingguohe.net/2018/03/29/how-to-implement-line-height.html
- (NSMutableAttributedString *(^)(CGFloat lineHeight))lineHeight;

// YYLabel 行高
- (NSMutableAttributedString *(^)(CGFloat lineHeight))yylineHeight;

// 段间距
- (NSMutableAttributedString *(^)(CGFloat spacing))paragraphSpacing;

// 对齐
- (NSMutableAttributedString *(^)(NSTextAlignment alignment))alignment;


@end

NS_ASSUME_NONNULL_END
