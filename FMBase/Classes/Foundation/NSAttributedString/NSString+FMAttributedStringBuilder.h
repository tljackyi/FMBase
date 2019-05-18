//
//  NSString+FMAttributedStringBuilder.h
//  FMBase
//
//  Created by yitailong on 2019/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (FMAttributedStringBuilder)

// 生成 Attributed String
- (NSMutableAttributedString *)attributedBuild;

@end

NS_ASSUME_NONNULL_END
