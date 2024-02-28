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
#import <SDWebImage/SDWebImage.h>

#import "RichTextView.h"

@interface DialogViewModelCell ()
@property (weak, nonatomic) RichTextView *nicknameLabel;
@property (weak, nonatomic) RichTextView *lastMessageLabel;
@property (weak, nonatomic) UIView *bottomLineView;
@property (weak, nonatomic) UIImageView *avatarImageView;
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
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[(id<IDialogCellViewModelDelegate>)viewModel.delegate avatarUrlOfUid:viewModel.uid]]];
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

- (UIImageView *)avatarImageView {
    if (!_avatarImageView) {
        UIImageView *avatarImageView = UIImageView.new;
        _avatarImageView = avatarImageView;
        [self.contentView addSubview:_avatarImageView];
        [_avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.leading.equalTo(self.contentView).offset(10.0f);
            make.bottom.equalTo(self.contentView).offset(-10.0f);
            make.width.equalTo(_avatarImageView.mas_height);
        }];
    }
    return _avatarImageView;
}

- (RichTextView *)nicknameLabel {
    if (!_nicknameLabel) {
        RichTextView *nicknameLabel = RichTextView.new;
        _nicknameLabel = nicknameLabel;
        [self.contentView addSubview:_nicknameLabel];
        [_nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(10.0);
            make.leading.equalTo(self.avatarImageView.mas_trailing).offset(5.0);
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
            make.leading.equalTo(self.avatarImageView.mas_trailing).offset(5.0);
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
