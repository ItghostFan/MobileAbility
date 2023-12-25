//
//  RootViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RowViewModel;

@interface RootViewModel : NSObject

@property (strong, nonatomic, readonly) NSArray<__kindof RowViewModel *> *viewModels;

@end

NS_ASSUME_NONNULL_END
