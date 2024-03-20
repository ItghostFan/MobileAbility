//
//  MessageCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/27.
//

#import "CellViewModel+TableView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IDialogCellViewModelDelegate;

@interface MessageCellViewModel : CellViewModel

@property (strong, nonatomic, readonly) NSNumber *uid;
@property (strong, nonatomic, readonly) NSNumber *from;
@property (strong, nonatomic, readonly) NSString *message;

@property (assign, nonatomic, readonly) BOOL isMe;

@property (weak, nonatomic, readonly) id<IDialogCellViewModelDelegate> dialogDelegate;

- (instancetype)initWithUid:(NSNumber *)uid
                    message:(NSDictionary *)message
             dialogDelegate:(id<IDialogCellViewModelDelegate>)dialogDelegate;

@end

NS_ASSUME_NONNULL_END
