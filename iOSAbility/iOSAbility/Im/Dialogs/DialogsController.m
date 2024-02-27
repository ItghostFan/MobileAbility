//
//  DialogsController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/21.
//

#import "DialogsController.h"

#import <Masonry/Masonry.h>

#import "DialogsViewModel.h"

#import "DialogCellViewModel.h"
#import "MessagesController.h"

@interface DialogsController () <ITableViewModelDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation DialogsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setViewModel:(DialogsViewModel *)viewModel {
    _viewModel = viewModel;
    _viewModel.delegate = self;
    viewModel.tableView = self.tableView;
}

#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView = tableView;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = YES;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_14_5
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
#endif
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MessagesController *controller = MessagesController.new;
    [self.navigationController pushViewController:controller animated:YES];
    controller.viewModel = self.viewModel.sectionViewModels[indexPath.section][indexPath.row];
}

@end
