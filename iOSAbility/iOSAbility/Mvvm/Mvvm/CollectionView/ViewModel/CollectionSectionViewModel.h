//
//  CollectionSectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionSectionViewModel<__covariant ObjectType> : BaseViewModels<ObjectType>

@property (strong, nonatomic, readonly) Class headerClass;
@property (strong, nonatomic, readonly) Class footerClass;

@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat minimumInteritemSpacing;

@end

NS_ASSUME_NONNULL_END
