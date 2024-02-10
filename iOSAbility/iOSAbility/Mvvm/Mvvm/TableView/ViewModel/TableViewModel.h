//
//  TableViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

#import "BaseViewModel.h"

#import "SectionViewModel+TableView.h"

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@interface TableViewModel : BaseViewModel

@property (strong, nonatomic, readonly) BaseViewModels<__kindof SectionViewModel<__kindof CellViewModel *> *> *sectionViewModels;

@property (weak, nonatomic) UITableView *tableView;

@end

NS_ASSUME_NONNULL_END
