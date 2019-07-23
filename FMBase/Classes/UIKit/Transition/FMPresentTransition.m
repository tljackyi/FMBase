//
//  FMPresentTransition.m
//  custapp
//
//

#import "FMPresentTransition.h"
#import "FMPresentationController.h"

@implementation FMPresentTransition

- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented
                                                      presentingViewController:(UIViewController *)presenting
                                                          sourceViewController:(UIViewController *)source {
    return [[FMPresentationController alloc] initWithPresentedViewController: presented
                                                    presentingViewController: presenting];
}

@end
