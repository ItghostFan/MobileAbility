//
//  MvvmController.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class MvvmViewModel;

@interface MvvmController : UIViewController

@property (weak, nonatomic) MvvmViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
