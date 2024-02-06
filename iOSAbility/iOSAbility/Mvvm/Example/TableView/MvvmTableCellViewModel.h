//
//  MvvmTableCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "TableCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MvvmTableCellViewModel : TableCellViewModel

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;

@end

NS_ASSUME_NONNULL_END
