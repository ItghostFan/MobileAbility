//
//  MvvmCollectionViewModelCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/12.
//

#import "MvvmCollectionViewModelCell.h"

#import <Masonry/Masonry.h>

#import "MvvmCellViewModel.h"

@interface MvvmCollectionViewModelCell ()
@property (weak, nonatomic) UILabel *cellLabel;
@end

@implementation MvvmCollectionViewModelCell

- (void)setViewModel:(MvvmCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    self.cellLabel.text = [NSString stringWithFormat:@"%lu-%lu", viewModel.collectionIndexPath.section, viewModel.collectionIndexPath.item];
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

+ (CGSize)cellSizeForSize:(CGSize *)size viewModel:(CellViewModel *)viewModel {
    return CGSizeMake(100.0f, 100.0f);
}

@end
