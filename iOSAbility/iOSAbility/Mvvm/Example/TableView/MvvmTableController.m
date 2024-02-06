//
//  MvvmTableController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableController.h"

#import <Masonry/Masonry.h>

#import "MvvmTableViewModel.h"
#import "MvvmTableCellViewModel.h"

@interface MvvmTableController ()

//@property (weak, nonatomic) UILabel *sectionLabel;
//@property (weak, nonatomic) UILabel *rowLabel;
//@property (weak, nonatomic) UITextField *sectionTextField;
//@property (weak, nonatomic) UITextField *rowTextField;
@property (weak, nonatomic) UIButton *addButton;
@property (weak, nonatomic) UIButton *deleteButton;

@end

@implementation MvvmTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.addButton.mas_bottom).offset(6.0f);
    }];
    [self deleteButton];
}

#pragma mark - Actions

- (void)onAdd:(id)sender {
    NSInteger row = self.viewModel.sectionViewModels[0].viewModels.count;
    MvvmTableCellViewModel *viewModel = MvvmTableCellViewModel.new;
    viewModel.section = 0;
    viewModel.row = row;
    [self.viewModel.sectionViewModels[0] addViewModel:viewModel];
}

- (void)onDelete:(id)sender {
//    MvvmTableCellViewModel *viewModel = self.viewModel.sectionViewModels[0].viewModels.lastObject;
//    if (!viewModel) {
//        return;
//    }
//    [self.viewModel.sectionViewModels[0] removeViewModel:viewModel];
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.viewModel.sectionViewModels[0].viewModels.count)];
    [self.viewModel.sectionViewModels[0] removeViewModelsAtIndexes:indexes];
}

#pragma mark - Setter

- (void)setViewModel:(MvvmTableViewModel *)viewModel {
    [super setViewModel:viewModel];
}

#pragma mark - Getter

- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *addButton = UIButton.new;
        _addButton = addButton;
        [_addButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_addButton setTitle:@"Add" forState:UIControlStateNormal];
        [self.view addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.equalTo(self.view);
        }];
        [_addButton addTarget:self action:@selector(onAdd:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        UIButton *deleteButton = UIButton.new;
        _deleteButton = deleteButton;
        [_deleteButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_deleteButton setTitle:@"Delete" forState:UIControlStateNormal];
        [self.view addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.trailing.equalTo(self.addButton.mas_leading);
        }];
        [_deleteButton addTarget:self action:@selector(onDelete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
