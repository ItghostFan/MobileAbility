//
//  MvvmTableViewModelCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableViewModelCell.h"

#import <Masonry/Masonry.h>

#import "MvvmTableCellViewModel.h"

@interface MvvmTableViewModelCell ()
@property (weak, nonatomic) UILabel *cellLabel;
@end

@implementation MvvmTableViewModelCell

- (void)setViewModel:(MvvmTableCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    self.cellLabel.text = [NSString stringWithFormat:@"%lu-%lu", viewModel.section, viewModel.row];
}

#pragma mark - Getter

- (UILabel *)cellLabel {
    if (!_cellLabel) {
        UILabel *cellLabel = [UILabel new];
        _cellLabel = cellLabel;
        _cellLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _cellLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_cellLabel];
        [_cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(5.0f);
            make.width.mas_equalTo(45.0f);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _cellLabel;
}

#pragma mark - Super

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(MvvmTableCellViewModel *)viewModel {
    return 20.0f;
}

@end
