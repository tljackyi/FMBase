//
//  FMSheetController.m
//  custapp
//

//

#import "FMSheetController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface FMSheetController ()

@property (nonatomic, strong, readwrite) FMPresentTransition *transition;
@property (nonatomic, strong, readwrite) UIView *contentView;

@end

@implementation FMSheetController

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
        make.left.bottom.right.offset(0);
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
