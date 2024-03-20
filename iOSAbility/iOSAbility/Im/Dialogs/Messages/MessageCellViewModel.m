//
//  MessageCellViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/27.
//

#import "MessageCellViewModel.h"
#import "MessageViewModelCell.h"

@interface MessageCellViewModel ()
@end

@implementation MessageCellViewModel

- (instancetype)initWithUid:(NSNumber *)uid
                    message:(NSDictionary *)message
             dialogDelegate:(id<IDialogCellViewModelDelegate>)dialogDelegate {
    if (self = [super init]) {
        _uid = uid;
        _dialogDelegate = dialogDelegate;
        _from = message[@"From"];
        _message = message[@"Message"];
    }
    return self;
}

- (BOOL)isMe {
    return [_uid isEqualToNumber:@0];
}

- (Class)tableCellClass {
    return MessageViewModelCell.class;
}

@end
