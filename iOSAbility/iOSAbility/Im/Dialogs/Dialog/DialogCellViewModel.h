//
//  DialogCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/27.
//

#import <UIKit/UIKit.h>

#import "CellViewModel+TableView.h"
#import "TableViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol IDialogCellViewModelDelegate <ICellViewModelDelegate>

- (NSString *)nicknameOfUid:(NSNumber *)uid;

@end

@interface DialogCellViewModel : CellViewModel

@property (strong, nonatomic, readonly) NSNumber *uid;
@property (strong, nonatomic, readonly) NSString *lastMessage;
@property (strong, nonatomic, readonly) TableViewModel *messagesViewModel;

- (instancetype)initWithUid:(NSNumber *)uid
                   messages:(NSMutableArray *)messages
                   delegate:(id<IDialogCellViewModelDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
