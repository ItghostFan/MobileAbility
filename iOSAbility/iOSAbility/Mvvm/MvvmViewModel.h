//
//  MvvmViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "RowViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class ViewModels;

@interface MvvmViewModel : RowViewModel

@property (strong, nonatomic, readonly) ViewModels *sectionViewModels;

@end

NS_ASSUME_NONNULL_END
