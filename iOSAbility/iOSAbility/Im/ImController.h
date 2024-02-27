//
//  ImController.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ImViewModel;

@interface ImController : UIViewController

@property (nonatomic) ImViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
