//
//  ScrollUpHideNavigationBarViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "ScrollUpHideNavigationBarViewModel.h"

#import "ScrollUpHideNavigationBarController.h"

@implementation ScrollUpHideNavigationBarViewModel

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    ScrollUpHideNavigationBarController *controller = [ScrollUpHideNavigationBarController new];
    [navigationController pushViewController:controller animated:YES];
}

@end
