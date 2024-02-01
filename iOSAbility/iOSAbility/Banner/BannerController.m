//
//  BannerController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/3.
//

#import "BannerController.h"

#import <Masonry/Masonry.h>

#import "BannerView.h"

@interface BannerController () <BannerViewDataSource>

@property (strong, nonatomic) NSMutableArray<__kindof UILabel *> *banners;
@property (weak, nonatomic) BannerView *bannerView;

@end

@implementation BannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.bannerView.dataSource = self;
}

#pragma mark - Getter

- (BannerView *)bannerView {
    if (!_bannerView) {
        BannerView *bannerView = [BannerView new];
        _bannerView = bannerView;
        _bannerView.backgroundColor = UIColor.greenColor;
        [self.view addSubview:_bannerView];
        [_bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.view);
            make.centerY.equalTo(self.view);
            make.height.mas_equalTo(300.0f);
        }];
    }
    return _bannerView;
}

- (NSMutableArray<__kindof UILabel *> *)banners {
    if (!_banners) {
        _banners = [NSMutableArray array];
        for (NSInteger index = 0; index < 2; ++index) {
            UILabel *label = [UILabel new];
            label.text = @(index).stringValue;
            label.textColor = UIColor.redColor;
            label.font = [UIFont boldSystemFontOfSize:50.0f];
            [_banners addObject:label];
            label.backgroundColor = index % 2 ? UIColor.yellowColor : UIColor.blueColor;
        }
    }
    return _banners;
}

#pragma mark - BannerViewDataSource

- (NSInteger)numberOfBanner {
    return self.banners.count;
}

- (UIView *)bannerView:(BannerView *)bannerView bannerAtIndexPath:(NSIndexPath *)indexPath {
    return self.banners[indexPath.item];
}

@end
