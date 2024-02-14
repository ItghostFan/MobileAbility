//
//  RowCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RowCell.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "RowViewModel.h"

@interface RowCell ()
@property (weak, nonatomic) UILabel *rowLabel;
@property (weak, nonatomic) UILabel *contentLabel;
@end

@implementation RowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setViewModel:(RowViewModel *)viewModel {
    [super setViewModel:viewModel];
    self.rowLabel.text = @(viewModel.tableIndexPath.row).stringValue;
    self.contentLabel.text = viewModel.content;
}

#pragma mark - Getter

- (UILabel *)rowLabel {
    if (!_rowLabel) {
        UILabel *rowLabel = [UILabel new];
        _rowLabel = rowLabel;
        _rowLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        _rowLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_rowLabel];
        [_rowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.contentView).offset(5.0f);
            make.width.mas_equalTo(45.0f);
            make.centerY.equalTo(self.contentView);
        }];
    }
    return _rowLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *contentLabel = [UILabel new];
        _contentLabel = contentLabel;
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        _contentLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.rowLabel.mas_trailing).offset(5.0f);
            make.trailing.equalTo(self.contentView).offset(-5.0f);
            make.bottom.equalTo(self.rowLabel);
        }];
    }
    return _contentLabel;
}

#pragma mark - TableViewModelCell

- (Class)tableCellClass {
    return RowCell.class;
}

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(CellViewModel *)viewModel {
    return 30.0f;
}

@end
