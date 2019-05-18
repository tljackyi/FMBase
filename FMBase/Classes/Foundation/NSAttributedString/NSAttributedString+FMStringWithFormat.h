//
//  NSAttributedString+FMStringWithFormat.h
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (FMStringWithFormat)

// [attributedString stringWithFormat:attrFormat, attrArg1, attrArg2, NULL]
+ (NSMutableAttributedString*)stringWithFormat:(NSAttributedString*)format, ...;

@end

NS_ASSUME_NONNULL_END
