//
//  TableSectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableSectionViewModel<__covariant ObjectType> : BaseViewModels<ObjectType>

@property (strong, nonatomic, readonly) Class headerClass;
@property (strong, nonatomic, readonly) Class footerClass;

- (CGFloat)headerHeightForWidth:(CGFloat)width;
- (CGFloat)footerHeightForWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
