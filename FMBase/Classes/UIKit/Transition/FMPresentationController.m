//
//  FMPresentationController.m
//  custapp
//

//

#import "FMPresentationController.h"
#import "FMBaseFunctionsDef.h"
#import <Masonry/Masonry.h>

@interface FMPresentationController ()

@property (strong, nonatomic) UIView *blurView;

@end

@implementation FMPresentationController

- (CGRect)frameOfPresentedViewInContainerView {
    CGSize size = self.presentedViewController.preferredContentSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = KScreenSize();
    }
    return (CGRect) {{0, KScreenHeight() - size.height}, size};
}

- (void)containerViewDidLayoutSubviews {
    [self.containerView insertSubview: self.blurView belowSubview: self.presentedView];
    [self.blurView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

- (void)presentationTransitionWillBegin {
    perform_view_animate(^{
        self.blurView.alpha = 1;
    });
}

- (void)dismissalTransitionWillBegin {
    perform_view_animate(^{
        self.blurView.alpha = 0;
    });
}

#pragma mark - getter

- (UIView *)blurView {
    if (!_blurView) {
        _blurView = [[UIView alloc] init];
        _blurView.backgroundColor = [UIColor colorWithWhite: 0 alpha : 0.3];
        _blurView.alpha = 0;
    }
    return _blurView;
}

@end
