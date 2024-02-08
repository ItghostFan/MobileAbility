//
//  CollectionSectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionSectionViewModel<__covariant ObjectType> : BaseViewModels<ObjectType>

@property (strong, nonatomic, readonly) Class collectionHeaderClass;
@property (strong, nonatomic, readonly) Class collectionFooterClass;

@property (assign, nonatomic) CGFloat collectionMinimumLineSpacing;
@property (assign, nonatomic) CGFloat collectionMinimumInteritemSpacing;
@property (assign, nonatomic) CGSize collectionHeaderSize;
@property (assign, nonatomic) CGSize collectionFooterSize;

@end

NS_ASSUME_NONNULL_END
