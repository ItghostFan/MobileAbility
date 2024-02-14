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

@interface RootViewController () <ICellViewModelDelegate>

@property (strong, nonatomic) RootViewModel *viewModel;
@property (weak, nonatomic) UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[RootViewModel alloc] initWithDelegate:self];
    self.viewModel.tableView = self.tableView;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [UITableView new];
        _tableView = tableView;
        [self.view addSubview:_tableView];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _tableView;
}

#pragma mark - ICellViewModelDelegate

- (void)didSelectedViewModel:(RowViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath {
    [viewModel pushToNavigationController:self.navigationController];
}

@end
