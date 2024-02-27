//
//  ImController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/21.
//

#import "ImController.h"

#import <Masonry/Masonry.h>

#import "ImViewModel.h"
#import "DialogsController.h"

@interface ImController ()

@end

@implementation ImController

- (void)viewDidLoad {
    [super viewDidLoad];
    DialogsController *dialogsController = DialogsController.new;
    [self addChildViewController:dialogsController];
    [self.view addSubview:dialogsController.view];
    [dialogsController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    dialogsController.viewModel = self.viewModel.dialogsViewModel;
}

- (void)setViewModel:(ImViewModel *)viewModel {
    _viewModel = viewModel;
}

@end
