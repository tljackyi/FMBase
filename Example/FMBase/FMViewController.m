//
//  FMViewController.m
//  FMBase
//
//  Created by tljackyi on 05/17/2019.
//  Copyright (c) 2019 tljackyi. All rights reserved.
//

#import "FMViewController.h"
#import "FMLoadable.h"
#import "UIStyle.h"
#import <FMBase.h>
#import <FMBase/NSDate+FMFormatter.h>

@interface FooObject : NSObject
@end
@implementation FooObject
+ (void)userDefinedLoad{
    NSLog(@"FooObject");
}
@end

FMLoadableFunctionBegin(FooObject)
[FooObject userDefinedLoad];
FMLoadableFunctionEnd(FooObject)

@interface FMViewController ()

@end

@implementation FMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [UIStyle style];
    
    [FMEasyPermission requestPhotoLibrayPermission:^(EasyAuthorityStatus status) {
        
    }];
    
    NSString *dateStr = [[NSDate date] fm_dateFormatterWithFormat:@"YYYY.MM.DD"];
    NSString *dateStr1 = [[NSDate date] fm_dateFormatterWithFormat:@"YYYY.MM.DD"];
    NSString *dateStr2 = [[NSDate date] fm_dateFormatterWithFormat:@"YYYY.MM.DD"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
