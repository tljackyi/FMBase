//
//  NSAttributedString+FMStringWithFormat.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "NSAttributedString+FMStringWithFormat.h"

@implementation NSAttributedString (FMStringWithFormat)

+ (NSMutableAttributedString*)stringWithFormat:(NSAttributedString*)format, ...{
    va_list args;
    va_start(args, format);
    
    NSMutableAttributedString *mutableAttributedString = (NSMutableAttributedString*)[format mutableCopy];
    NSString *mutableString = [mutableAttributedString string];
    
    while (true) {
        NSAttributedString *arg = va_arg(args, NSAttributedString*);
        if (!arg) {
            break;
        }
        NSRange rangeOfStringToBeReplaced = [mutableString rangeOfString:@"%@"];
        if (rangeOfStringToBeReplaced.location != NSNotFound) {
            [mutableAttributedString replaceCharactersInRange:rangeOfStringToBeReplaced withAttributedString:arg];
        }
    }
    
    va_end(args);
    
    return mutableAttributedString;
}

@end
