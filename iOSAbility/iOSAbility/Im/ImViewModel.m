//
//  ImViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/21.
//

#import "ImViewModel.h"
#import "ImController.h"

#import "DialogsViewModel.h"

@implementation ImViewModel

- (instancetype)initWithRowContents:(NSDictionary *)rowContents {
    if (self = [super initWithRowContents:rowContents]) {
        _dialogsViewModel = DialogsViewModel.new;
    }
    return self;
}

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    ImController *controller = [ImController new];
    controller.viewModel = self;
    [navigationController pushViewController:controller animated:YES];
}

@end
