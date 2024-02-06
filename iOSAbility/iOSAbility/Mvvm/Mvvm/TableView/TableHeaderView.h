//
//  TableHeaderView.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TableSectionViewModel;

@interface TableHeaderView : UITableViewHeaderFooterView

@property (strong, nonatomic) TableSectionViewModel *viewModel;

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(TableSectionViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
