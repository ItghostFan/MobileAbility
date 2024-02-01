//
//  BannerView.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BannerView;

@protocol BannerViewDataSource <NSObject>

- (NSInteger)numberOfBanner;
- (UIView *)bannerView:(BannerView *)bannerView bannerAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BannerView : UIView

@property (weak, nonatomic) id<BannerViewDataSource> dataSource;

@end

NS_ASSUME_NONNULL_END
