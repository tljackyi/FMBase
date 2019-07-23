//
//  FMAlertController.h
//  custapp
//

//

#import <UIKit/UIKit.h>
#import "FMPresentTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMAlertController : UIViewController

@property (nonatomic, strong, readonly) FMPresentTransition *transition;
@property (nonatomic, strong, readonly) UIView *contentView;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
