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

@class CellViewModel;

@interface CollectionViewModel : BaseViewModel

@property (strong, nonatomic, readonly) BaseViewModels<__kindof CollectionSectionViewModel<__kindof CellViewModel *> *> *sectionViewModels;

@property (weak, nonatomic, nullable) UICollectionView *collectionView;

@end

NS_ASSUME_NONNULL_END
