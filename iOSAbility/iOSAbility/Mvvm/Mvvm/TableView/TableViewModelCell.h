//
//  TableViewModelCell.h
//  AFNetworking
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class CellViewModel;

@interface TableViewModelCell : UITableViewCell

@property (weak, nonatomic) CellViewModel *viewModel;

#pragma mark - Subclass If Need

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(CellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
