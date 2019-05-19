//
//  FMExceptionLog.m
//  Pods
//
//  Created by yitailong on 2019/5/17.
//

#import "FMExceptionLog.h"

@implementation FMExceptionLog

+ (instancetype)sharedInstance  {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)reportExceptionWithMessage:(NSString *)message extraDic:(nullable NSDictionary *)extraDic
{
    NSString *msg = [@"FMExceptionLog " stringByAppendingString:message];
    NSLog(@"%@", msg);
    NSArray<NSString *> *allThreads = [NSThread callStackSymbols];
    
    NSDictionary *errorDic = @{
                               @"Name" : @"FFExtension capture's Exception",
                               @"Reason" : msg?:@"",
                               @"ExtraDic" : extraDic?:@{},
                               @"CallStackSymbols" : allThreads?:@[],
                               };
    if ([self.delegate respondsToSelector:@selector(captureExceptionWithErrorDic:)]) {
        [self.delegate captureExceptionWithErrorDic:errorDic];
    }
}

@end
