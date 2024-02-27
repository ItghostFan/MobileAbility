//
//  DialogViewModelCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/27.
//

#import "DialogViewModelCell.h"
#import "DialogCellViewModel.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

#import "RichTextView.h"

@interface DialogViewModelCell ()
@property (weak, nonatomic) RichTextView *nicknameLabel;
@property (weak, nonatomic) RichTextView *lastMessageLabel;
@property (weak, nonatomic) UIView *bottomLineView;
@end

@implementation DialogViewModelCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.bottomLineView.hidden = NO;
    }
    return self;
}

- (void)setViewModel:(DialogCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    self.nicknameLabel.text = [(id<IDialogCellViewModelDelegate>)viewModel.delegate nicknameOfUid:viewModel.uid];
    @weakify(self);
    [[RACObserve(viewModel, lastMessage) takeUntil:self.rac_prepareForReuseSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.lastMessageLabel.text = x;
    }];
}

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(DialogCellViewModel *)viewModel {
    return 60.0f;
}

#pragma mark - Getter

- (RichTextView *)nicknameLabel {
    if (!_nicknameLabel) {
        RichTextView *nicknameLabel = RichTextView.new;
        _nicknameLabel = nicknameLabel;
        [self.contentView addSubview:_nicknameLabel];
        [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(10.0);
            make.leadingMargin.mas_equalTo(10.0);
        }];
    }
    return _nicknameLabel;
}

- (RichTextView *)lastMessageLabel {
    if (!_lastMessageLabel) {
        RichTextView *lastMessageLabel = RichTextView.new;
        _lastMessageLabel = lastMessageLabel;
        [self.contentView addSubview:_lastMessageLabel];
        [_lastMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leadingMargin.mas_equalTo(10.0);
            make.bottomMargin.mas_equalTo(-10.0);
        }];
    }
    return _lastMessageLabel;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        UIView *bottomLineView = UIView.new;
        _bottomLineView = bottomLineView;
        _bottomLineView.backgroundColor = UIColor.lightGrayColor;
        [self.contentView addSubview:_bottomLineView];
        [_bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0.5f);
            make.leading.bottom.trailing.equalTo(self.contentView);
        }];
    }
    return _bottomLineView;
}

@end
