//
//  ScrollUpHideTableHeadController.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/26.
//

#import "ScrollUpHideTableHeadController.h"

#import <Masonry/Masonry.h>

#import "TableViewModel.h"
#import "ScrollUpHideTableHeadViewModel.h"
#import "RowCell.h"

@interface ScrollUpHideTableHeadController () <UIScrollViewDelegate>

@property (strong, nonatomic) TableViewModel *tableViewModel;
@property (weak, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat minTableHeaderViewHeight;
@property (weak, nonatomic) UIImageView *headView;

@end

@implementation ScrollUpHideTableHeadController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableViewModel = TableViewModel.new;
    SectionViewModel *sectionViewModel = SectionViewModel.new;
    [sectionViewModel addViewModel:RowViewModel.new];
    [self.tableViewModel.sectionViewModels addViewModel:sectionViewModel];
    self.tableViewModel.tableView = self.tableView;
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
