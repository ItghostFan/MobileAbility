//
//  RowCell.h
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RowViewModel;

@interface RowCell : UITableViewCell

@property (weak, nonatomic) RowViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
