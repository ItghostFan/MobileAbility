//
//  ScrollUpHideTableHeadViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/26.
//

#import "ScrollUpHideTableHeadViewModel.h"

#import "ScrollUpHideTableHeadController.h"

@interface ScrollUpHideTableHeadViewModel ()
@end

@implementation ScrollUpHideTableHeadViewModel

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    ScrollUpHideTableHeadController *controller = [ScrollUpHideTableHeadController new];
    controller.viewModel = self;
    [navigationController pushViewController:controller animated:YES];
}

@end
