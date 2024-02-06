//
//  CollectionFooterView.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionSectionViewModel;

@interface CollectionFooterView : UICollectionReusableView

@property (weak, nonatomic) CollectionSectionViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
