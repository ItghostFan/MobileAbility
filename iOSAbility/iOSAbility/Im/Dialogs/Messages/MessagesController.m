//
//  MessagesController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/28.
//

#import "MessagesController.h"

#import <Masonry/Masonry.h>

#import "DialogCellViewModel.h"

@interface MessagesController ()

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation MessagesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setViewModel:(DialogCellViewModel *)viewModel {
    _viewModel = viewModel;
    viewModel.messagesViewModel.tableView = self.tableView;
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

@end
