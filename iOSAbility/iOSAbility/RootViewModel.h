//
//  RootViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import <Foundation/Foundation.h>

#import "TableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ICellViewModelDelegate;
@class RowViewModel;

@interface RootViewModel : TableViewModel

- (instancetype)initWithDelegate:(id<ICellViewModelDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
