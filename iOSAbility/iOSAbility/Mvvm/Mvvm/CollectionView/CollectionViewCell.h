//
//  CollectionViewCell.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CollectionCellViewModel;

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) CollectionCellViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
