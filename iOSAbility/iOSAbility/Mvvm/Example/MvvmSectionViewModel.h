//
//  MvvmSectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "SectionViewModel+TableView.h"
#import "SectionViewModel+CollectionView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MvvmSectionViewModel : SectionViewModel

@property (assign, nonatomic) CGFloat collectionMinimumLineSpacing;

@property (assign, nonatomic) CGFloat collectionMinimumInteritemSpacing;

@end

NS_ASSUME_NONNULL_END
