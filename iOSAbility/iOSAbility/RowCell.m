//
//  RowCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RowCell.h"

#import "RowViewModel.h"

@implementation RowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setViewModel:(RowViewModel *)viewModel {
    _viewModel = viewModel;
}

@end
