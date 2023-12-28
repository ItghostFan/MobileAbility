//
//  ScrollUpHideTableHeadController.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/26.
//

#import "ScrollUpHideTableHeadController.h"

#import <Masonry/Masonry.h>

#import "ScrollUpHideTableHeadViewModel.h"
#import "RowCell.h"

@interface ScrollUpHideTableHeadController () <
UITableViewDataSource,
UITableViewDelegate,
UIScrollViewDelegate
>

@property (weak, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat minTableHeaderViewHeight;
@property (weak, nonatomic) UIImageView *headView;

@end

@implementation ScrollUpHideTableHeadController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)setViewModel:(ScrollUpHideTableHeadViewModel *)viewModel {
    _viewModel = viewModel;
    [self.tableView reloadData];
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
        UIImageView *headView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"natura"]];
        _headView = headView;
        _headView.contentMode = UIViewContentModeScaleAspectFill;
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), 300.0f)];
        [tableHeaderView addSubview:_headView];
        _tableView.tableHeaderView = tableHeaderView;
        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);                            // MARK: 注意这里这样做，才会放大缩小图片效果
            make.leading.trailing.bottom.equalTo(tableHeaderView);
        }];
        _minTableHeaderViewHeight = CGRectGetHeight(tableHeaderView.frame);
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
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
    CGFloat headerViewHeight = CGRectGetHeight(self.tableView.tableHeaderView.frame);
    yOffset = MIN(headerViewHeight, yOffset);
    if (yOffset >= 0.0f) {
        self.headView.alpha = 1.0f - (yOffset / headerViewHeight);
    } else {
//        CGFloat height = -(yOffset * 2) + headerViewHeight;
////        CGRect frame = CGRectInset(self.tableView.tableHeaderView.frame, 0.0f, yOffset);
////        if (CGRectGetHeight(frame) > _minTableHeaderViewHeight) {
////            self.tableView.tableHeaderView.frame = frame;
////        }
//        CGFloat factor = height / headerViewHeight;
//        self.headView.layer.transform = CATransform3DScale(CATransform3DIdentity, factor, factor, 1.0f);
    }
}

@end
