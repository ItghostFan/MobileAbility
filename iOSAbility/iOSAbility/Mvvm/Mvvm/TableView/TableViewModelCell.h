//
//  TableViewModelCell.h
//  AFNetworking
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TableCellViewModel;

@interface TableViewModelCell : UITableViewCell

@property (weak, nonatomic) TableCellViewModel *viewModel;

#pragma mark - Subclass If Need

+ (CGFloat)cellHeightForWidth:(CGFloat *)width viewModel:(TableCellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
