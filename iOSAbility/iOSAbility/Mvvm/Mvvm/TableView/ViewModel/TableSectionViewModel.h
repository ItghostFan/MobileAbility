//
//  TableSectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModels.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableSectionViewModel<__covariant ObjectType> : BaseViewModels<ObjectType>

@property (strong, nonatomic, readonly) Class tableHeaderClass;
@property (strong, nonatomic, readonly) Class tableFooterClass;

- (CGFloat)tableHeaderHeightForWidth:(CGFloat)width;
- (CGFloat)tableFooterHeightForWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
