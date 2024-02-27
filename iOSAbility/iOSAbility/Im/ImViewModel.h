//
//  ImViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/21.
//

#import "RowViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class DialogsViewModel;

@interface ImViewModel : RowViewModel

@property (strong, nonatomic, readonly) DialogsViewModel *dialogsViewModel;

@end

NS_ASSUME_NONNULL_END
