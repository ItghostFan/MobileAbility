//
//  MvvmTableCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "CellViewModel+TableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MvvmTableCellViewModel : CellViewModel

@property (assign, nonatomic) NSInteger section;
@property (assign, nonatomic) NSInteger row;

@end

NS_ASSUME_NONNULL_END
