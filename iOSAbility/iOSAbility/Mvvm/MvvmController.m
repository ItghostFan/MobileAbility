//
//  MvvmController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "MvvmController.h"

#import <Masonry/Masonry.h>

#import "MvvmViewModel.h"

#import "MvvmSectionViewModel.h"
#import "MvvmCellViewModel.h"
#import "SectionViewModel.h"
#import "BaseViewModels.h"

#import "MvvmTableController.h"
#import "TableViewModel.h"

#import "MvvmCollectionController.h"
#import "CollectionViewModel.h"

@interface MvvmController ()
@property (weak, nonatomic) UIButton *addButton;
@property (weak, nonatomic) UIButton *deleteButton;
@property (weak, nonatomic) UIButton *selectButton;

@property (strong, nonatomic) BaseViewModels<__kindof SectionViewModel *> *sectionViewModels;

@property (weak, nonatomic) MvvmTableController *tableController;
@property (weak, nonatomic) MvvmCollectionController *collectionController;

@end

@implementation MvvmController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self addButton];
    [self deleteButton];
    [self selectButton];
    
    _sectionViewModels = BaseViewModels.new;
    {
        MvvmSectionViewModel *sectionViewModel = MvvmSectionViewModel.new;
        MvvmCellViewModel *cellViewModel = MvvmCellViewModel.new;
        [sectionViewModel addViewModel:cellViewModel];
        [_sectionViewModels addViewModel:sectionViewModel];
    }
    {
        MvvmSectionViewModel *sectionViewModel = MvvmSectionViewModel.new;
        MvvmCellViewModel *cellViewModel = MvvmCellViewModel.new;
        [sectionViewModel addViewModel:cellViewModel];
        [_sectionViewModels addViewModel:sectionViewModel];
    }
    [self addTable];
    [self addCollection];
}

- (void)addTable {
    MvvmTableController *controller = MvvmTableController.new;
    TableViewModel *viewModel = TableViewModel.new;
    viewModel.sectionViewModels = _sectionViewModels;
    controller.viewModel = viewModel;
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(60.0f);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    _tableController = controller;
}

- (void)addCollection {
    MvvmCollectionController *controller = MvvmCollectionController.new;
    CollectionViewModel *viewModel = CollectionViewModel.new;
    viewModel.sectionViewModels = _sectionViewModels;
    controller.viewModel = viewModel;
    [self addChildViewController:controller];
    [self.view addSubview:controller.view];
    [controller.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(60.0f);
        make.bottom.leading.trailing.equalTo(self.view);
    }];
    _collectionController = controller;
}

- (void)dealloc {
}

#pragma mark - Setter

- (void)setViewModel:(MvvmViewModel *)viewModel {
    _viewModel = viewModel;
}

#pragma mark - Actions

- (void)onAdd:(id)sender {
    NSInteger row = self.sectionViewModels[0].viewModels.count;
    MvvmCellViewModel *viewModel = MvvmCellViewModel.new;
    [self.sectionViewModels[0] addViewModel:viewModel];
}

- (void)onDelete:(id)sender {
//    MvvmCellViewModel *viewModel = self.viewModel.sectionViewModels[0].viewModels.lastObject;
//    if (!viewModel) {
//        return;
//    }
//    [self.viewModel.sectionViewModels[0] removeViewModel:viewModel];
    NSMutableIndexSet *indexes = [NSMutableIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.sectionViewModels[0].viewModels.count)];
    [self.sectionViewModels[0] removeViewModelsAtIndexes:indexes];
}

- (void)onSelect:(id)sender {
    self.selectButton.selected = !self.selectButton.selected;
    self.tableController.view.hidden = self.selectButton.selected;
    self.collectionController.view.hidden = !self.selectButton.selected;
}

#pragma mark - Getter

- (UIButton *)addButton {
    if (!_addButton) {
        UIButton *addButton = UIButton.new;
        _addButton = addButton;
        [_addButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_addButton setTitle:@"Add" forState:UIControlStateNormal];
        _addButton.backgroundColor = UIColor.grayColor;
        _addButton.clipsToBounds = YES;
        _addButton.layer.cornerRadius = 10.0f;
        [self.view addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.view);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
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
        _deleteButton.backgroundColor = UIColor.grayColor;
        _deleteButton.clipsToBounds = YES;
        _deleteButton.layer.cornerRadius = 10.0f;
        [self.view addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.trailing.equalTo(self.addButton.mas_leading);
        }];
        [_deleteButton addTarget:self action:@selector(onDelete:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (UIButton *)selectButton {
    if (!_selectButton) {
        UIButton *selectButton = UIButton.new;
        _selectButton = selectButton;
        [_selectButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_selectButton setTitle:@"Table" forState:UIControlStateNormal];
        [_selectButton setTitle:@"Collection" forState:UIControlStateSelected];
        _selectButton.backgroundColor = UIColor.grayColor;
        _selectButton.clipsToBounds = YES;
        _selectButton.layer.cornerRadius = 10.0f;
        [self.view addSubview:_selectButton];
        [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.trailing.equalTo(self.deleteButton.mas_leading);
        }];
        [_selectButton addTarget:self action:@selector(onSelect:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

@end
