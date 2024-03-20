//
//  MessageViewModelCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/28.
//

#import "MessageViewModelCell.h"
#import "MessageCellViewModel.h"

#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface MessageViewModelCell ()
@property (weak, nonatomic, nullable) UIImageView *bubbleView;
@end

@implementation MessageViewModelCell

- (void)setViewModel:(MessageCellViewModel *)viewModel {
    [super setViewModel:viewModel];
    UIImage *bubble = nil;
    if (viewModel.isMe) {
        bubble = [[UIImage imageNamed:@"my_chat_bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(10.0f, 14.0f, 29.0f, 19.0f)];
    } else {
        bubble = [[UIImage imageNamed:@"other_chat_bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(29.0f, 19.0f, 10.0f, 14.0f)];
    }
    self.bubbleView.image = bubble;
    [self.bubbleView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(MessageCellViewModel *)viewModel {
    return 80.0f;
}

#pragma mark - Getter

- (UIImageView *)bubbleView {
    if (!_bubbleView) {
        UIImageView *bubbleView = UIImageView.new;
        _bubbleView = bubbleView;
        [self.contentView addSubview:_bubbleView];
    }
    return _bubbleView;
}

@end
