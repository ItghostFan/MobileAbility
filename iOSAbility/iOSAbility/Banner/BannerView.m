//
//  BannerView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/3.
//

#import "BannerView.h"

@interface BannerView ()
@property (strong, nonatomic) NSMutableArray<__kindof UIView *> *visibleBanners;
@property (strong, nonatomic) NSMutableArray<__kindof NSIndexPath *> *indexPathsForVisibleRows;
@property (assign, nonatomic) CGPoint startPoint;
@property (assign, nonatomic) UISwipeGestureRecognizerDirection direction;
@end

@implementation BannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        [self addSwipeDirection:UISwipeGestureRecognizerDirectionLeft];
//        [self addSwipeDirection:UISwipeGestureRecognizerDirectionRight];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
        [self addGestureRecognizer:pan];
        self.userInteractionEnabled = YES;
        _indexPathsForVisibleRows = [NSMutableArray new];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

#pragma mark - Private

- (void)addSwipeDirection:(UISwipeGestureRecognizerDirection)direction {
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(onSwipe:)];
    swipe.direction = direction;
    [self addGestureRecognizer:swipe];
}

- (void)addPanBanner:(UIView *)banner {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan:)];
    banner.userInteractionEnabled = YES;
    [banner addGestureRecognizer:pan];
}

#pragma mark - Setter

- (void)setDataSource:(id<BannerViewDataSource>)dataSource {
    [self.superview layoutIfNeeded];
    _dataSource = dataSource;
    if (_dataSource.numberOfBanner) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        [_indexPathsForVisibleRows addObject:indexPath];
        UIView *banner = [self.dataSource bannerView:self bannerAtIndexPath:indexPath];
        [self addSubview:banner];
        banner.frame = self.bounds;
    }
}

#pragma mark - Actions

- (void)onSwipe:(UISwipeGestureRecognizer *)swipe {
    if ([self.dataSource numberOfBanner] < 2) {
        return;
    }
    NSIndexPath *indexPath = nil;
    UIView *endDisplayBanner = nil;
    CGRect displayFrame = self.bounds;
    CGRect endDisplayFrame = self.bounds;
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionRight: {
            indexPath = _indexPathsForVisibleRows.firstObject;
            if (!indexPath) {
                return;
            }
            displayFrame = CGRectOffset(displayFrame, -CGRectGetWidth(self.bounds), 0.0f);
            endDisplayFrame = CGRectOffset(endDisplayFrame, CGRectGetWidth(self.bounds), 0.0f);
            NSInteger item = (indexPath.item - 1 + [self.dataSource numberOfBanner]) % [self.dataSource numberOfBanner];
            indexPath = [NSIndexPath indexPathForItem:item inSection:0];
            endDisplayBanner = [self.dataSource bannerView:self bannerAtIndexPath:_indexPathsForVisibleRows.lastObject];
            [_indexPathsForVisibleRows removeLastObject];
            [_indexPathsForVisibleRows insertObject:indexPath atIndex:0];
            break;
        }
        case UISwipeGestureRecognizerDirectionLeft: {
            indexPath = _indexPathsForVisibleRows.lastObject;
            if (!indexPath) {
                return;
            }
            displayFrame = CGRectOffset(displayFrame, CGRectGetWidth(self.bounds), 0.0f);
            endDisplayFrame = CGRectOffset(endDisplayFrame, -CGRectGetWidth(self.bounds), 0.0f);
            NSInteger item = (indexPath.item + 1) % [self.dataSource numberOfBanner];
            indexPath = [NSIndexPath indexPathForItem:item inSection:0];
            endDisplayBanner = [self.dataSource bannerView:self bannerAtIndexPath:_indexPathsForVisibleRows.firstObject];
            [_indexPathsForVisibleRows removeObjectAtIndex:0];
            [_indexPathsForVisibleRows addObject:indexPath];
            break;
        }
        default: {
            return;
        }
    }
    UIView *banner = [self.dataSource bannerView:self bannerAtIndexPath:indexPath];
    [self addSubview:banner];
    banner.frame = displayFrame;
    [UIView animateWithDuration:0.25f animations:^{
        banner.frame = self.bounds;
        endDisplayBanner.frame = endDisplayFrame;
    } completion:^(BOOL finished) {
        [endDisplayBanner removeFromSuperview];
    }];
}

- (void)onPan:(UIPanGestureRecognizer *)pan {
    if ([self.dataSource numberOfBanner] < 2) {
        return;
    }
    switch (pan.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *indexPath = _indexPathsForVisibleRows.firstObject;
            UIView *banner = [self.dataSource bannerView:self bannerAtIndexPath:indexPath];
            self.startPoint = banner.frame.origin;
            break;
        }
        case UIGestureRecognizerStateChanged: {
            NSIndexPath *indexPath = nil;
            if (_indexPathsForVisibleRows.count > 1) {
                switch (self.direction) {
                    case UISwipeGestureRecognizerDirectionLeft: {
                        indexPath = _indexPathsForVisibleRows.firstObject;
                        break;
                    }
                    case UISwipeGestureRecognizerDirectionRight: {
                        indexPath = _indexPathsForVisibleRows.lastObject;
                        break;
                    }
                    default: {
                        NSAssert(NO, @"Inpossible!");
                        break;
                    }
                }
            } else {
                indexPath = _indexPathsForVisibleRows.firstObject;
            }
            UIView *banner = [self.dataSource bannerView:self bannerAtIndexPath:indexPath];
            CGPoint translation = [pan translationInView:pan.view];
            CGRect frame = banner.frame;
            frame.origin = CGPointMake(self.startPoint.x + translation.x, self.startPoint.y);
            banner.frame = frame;
            
            CGRect nexFrame = self.bounds;
            UIView *willDisplayBanner = nil;
            if (frame.origin.x < 0.0f) {
                // Move Left
                if (self.direction == UISwipeGestureRecognizerDirectionRight && _indexPathsForVisibleRows.count >= 2) {
                    [_indexPathsForVisibleRows removeObjectAtIndex:0];
                }
                if (_indexPathsForVisibleRows.count < 2) {
                    NSInteger item = (indexPath.item - 1 + [self.dataSource numberOfBanner]) % [self.dataSource numberOfBanner];
                    indexPath = [NSIndexPath indexPathForItem:item inSection:0];
                    willDisplayBanner = [self.dataSource bannerView:self bannerAtIndexPath:_indexPathsForVisibleRows.firstObject];
                    [_indexPathsForVisibleRows addObject:indexPath];
                } else {
                    willDisplayBanner = [self.dataSource bannerView:self bannerAtIndexPath:_indexPathsForVisibleRows.lastObject];
                }
                self.direction = UISwipeGestureRecognizerDirectionLeft;
                nexFrame = CGRectOffset(nexFrame, CGRectGetWidth(nexFrame) - frame.origin.x, self.startPoint.y);
            }
            if (frame.origin.x > 0.0f) {
                // Move Right
                if (self.direction == UISwipeGestureRecognizerDirectionLeft && _indexPathsForVisibleRows.count >= 2) {
                    [_indexPathsForVisibleRows removeLastObject];
                }
                if (_indexPathsForVisibleRows.count < 2) {
                    NSInteger item = (indexPath.item + 1) % [self.dataSource numberOfBanner];
                    indexPath = [NSIndexPath indexPathForItem:item inSection:0];
                    willDisplayBanner = [self.dataSource bannerView:self bannerAtIndexPath:_indexPathsForVisibleRows.firstObject];
                    [_indexPathsForVisibleRows addObject:indexPath];
                } else {
                    willDisplayBanner = [self.dataSource bannerView:self bannerAtIndexPath:_indexPathsForVisibleRows.lastObject];
                }
                
                self.direction = UISwipeGestureRecognizerDirectionRight;
                nexFrame = CGRectOffset(nexFrame, -(CGRectGetWidth(nexFrame) - frame.origin.x), self.startPoint.y);
            }
            
            break;
        }
        case UIGestureRecognizerStateEnded: {
            
            break;
        }
        default: {
            break;
        }
    }
}

@end
