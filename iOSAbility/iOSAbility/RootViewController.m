//
//  RootViewController.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RootViewController.h"

#import <Masonry/Masonry.h>

#import "RootViewModel.h"
#import "RowViewModel.h"

#import "RowCell.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) RootViewModel *viewModel;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _viewModel = [RootViewModel new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [UITableView new];
        _tableView = tableView;
        [self.view addSubview:_tableView];
        [_tableView registerClass:RowCell.class forCellReuseIdentifier:NSStringFromClass(RowCell.class)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RowCell.class) forIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    _viewModel.viewModels[indexPath.row].indexPath = indexPath;
    ((RowCell *)cell).viewModel = _viewModel.viewModels[indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [_viewModel.viewModels[indexPath.row] pushToNavigationController:self.navigationController];
}

@end
