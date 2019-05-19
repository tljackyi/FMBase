//
//  NSString+FMAttributedStringBuilder.m
//  FMBase
//
//  Created by yitailong on 2019/5/17.
//

#import "NSString+FMAttributedStringBuilder.h"
#import "NSMutableAttributedString+FMAttributedStringBuilder.h"

@implementation NSString (FMAttributedStringBuilder)

- (NSMutableAttributedString *)fm_attributedBuild {
    return NSMutableAttributedString.fm_build(self);
}

@end
