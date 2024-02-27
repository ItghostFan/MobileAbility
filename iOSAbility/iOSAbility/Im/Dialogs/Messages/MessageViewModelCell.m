//
//  MessageViewModelCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/28.
//

#import "MessageViewModelCell.h"
#import "MessageCellViewModel.h"

@implementation MessageViewModelCell

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(MessageCellViewModel *)viewModel {
    return 80.0f;
}

@end
