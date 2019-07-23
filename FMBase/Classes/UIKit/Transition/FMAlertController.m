//
//  FMAlertController.m
//  custapp
//

//

#import "FMAlertController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

@interface FMAlertController ()

@property (nonatomic, strong, readwrite) FMPresentTransition *transition;
@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation FMAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
    @weakify(self)
    [[control rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self dismiss];
    }];
    self.view = control;
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(52);
        make.right.offset(-52);
        make.centerY.offset(0);
    }];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getter
- (FMPresentTransition *)transition{
    if (!_transition) {
        _transition = [[FMPresentTransition alloc] init];
    }
    return _transition;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

@end
