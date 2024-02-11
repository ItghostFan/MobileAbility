//
//  CellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "BaseViewModel.h"

//#import "ICollectionCellViewModel.h"
//#import "ITableCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@protocol ICellViewModelDelegate <IBaseViewModelDelegate>

@optional

- (void)didSelectedViewModel:(CellViewModel *)viewModel atIndexPath:(NSIndexPath *)indexPath;

@end

@interface CellViewModel : BaseViewModel

@property (weak, nonatomic, nullable) id<ICellViewModelDelegate> delegate;
@property (strong, nonatomic, readonly, nullable) Class cellClass;

@property (assign, nonatomic) BOOL deselectAfterDidSelect;       // Default is YES.

@end

NS_ASSUME_NONNULL_END
