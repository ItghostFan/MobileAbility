//
//  CollectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

#import "BaseViewModel.h"

#import "CollectionSectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CollectionCellViewModel;

@interface CollectionViewModel : BaseViewModel

@property (strong, nonatomic, readonly) BaseViewModels<__kindof CollectionSectionViewModel<__kindof CollectionCellViewModel *> *> *sectionViewModels;

@property (weak, nonatomic, nullable) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
