//
//  TableViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

#import "BaseViewModel.h"

#import "TableSectionViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TableCellViewModel;

@interface TableViewModel : BaseViewModel

@property (strong, nonatomic, readonly) BaseViewModels<__kindof TableSectionViewModel<__kindof TableCellViewModel *> *> *sectionViewModels;

@property (weak, nonatomic) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
