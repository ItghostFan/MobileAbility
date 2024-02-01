//
//  BannerViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/4.
//

#import "BannerViewModel.h"

#import "BannerController.h"

@implementation BannerViewModel

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    BannerController *controller = [BannerController new];
    controller.viewModel = self;
    [navigationController pushViewController:controller animated:YES];
}

@end
