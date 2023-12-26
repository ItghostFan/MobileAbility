//
//  ScrollUpHideNavigationBarController.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "ScrollUpHideNavigationBarController.h"

#import <Masonry/Masonry.h>

@interface ScrollUpHideNavigationBarController () <UIScrollViewDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIView *contentView;

@end

@implementation ScrollUpHideNavigationBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.contentView.backgroundColor = UIColor.greenColor;
}

#pragma mark - Getter

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        UIScrollView *scrollView = [UIScrollView new];
        _scrollView = scrollView;
        [self.view addSubview:_scrollView];
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        UIView *contentView = [UIView new];
        CGRect contentFrame = UIScreen.mainScreen.bounds;
        contentFrame.size.height *= 2;
        _contentView = contentView;
        _contentView.frame = contentFrame;
        [self.scrollView addSubview:_contentView];
        self.scrollView.contentSize = _contentView.frame.size;
        CAGradientLayer *layer = [CAGradientLayer layer];
        layer.frame = contentFrame;
        layer.startPoint = CGPointMake(0.5f, 0.0f);
        layer.endPoint = CGPointMake(0.5f, 1.0f);
        layer.colors = @[(__bridge id)UIColor.whiteColor.CGColor,
                         (__bridge id)UIColor.redColor.CGColor,
                         (__bridge id)UIColor.whiteColor.CGColor,];
        layer.locations = @[@0.0f, @0.5f, @1.0f];
        [_contentView.layer addSublayer:layer];
    }
    return _contentView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yOffset = scrollView.contentOffset.y;
    CGFloat navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    yOffset = MIN(navigationBarHeight, yOffset);
    self.navigationController.navigationBar.alpha = 1.0f - (yOffset / navigationBarHeight);
}

@end
