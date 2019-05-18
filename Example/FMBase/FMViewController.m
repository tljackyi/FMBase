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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
