//
//  MvvmController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "MvvmController.h"

#import <Masonry/Masonry.h>

#import "MvvmViewModel.h"

#import "MvvmTableController.h"
#import "MvvmTableViewModel.h"

@implementation MvvmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    MvvmTableController *controller = MvvmTableController.new;
    MvvmTableViewModel *viewModel = MvvmTableViewModel.new;
    controller.viewModel = viewModel;
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(60.0f);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
}

- (void)dealloc {
}

#pragma mark - Setter

- (void)setViewModel:(MvvmViewModel *)viewModel {
    _viewModel = viewModel;
}

@end
