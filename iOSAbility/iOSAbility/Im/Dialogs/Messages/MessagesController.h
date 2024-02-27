//
//  MessagesController.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DialogCellViewModel;

@interface MessagesController : UIViewController

@property (weak, nonatomic) DialogCellViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
