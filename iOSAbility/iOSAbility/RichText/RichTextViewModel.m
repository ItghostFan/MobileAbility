//
//  RichTextViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/1/29.
//

#import "RichTextViewModel.h"

#import "RichTextController.h"

@implementation RichTextViewModel

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    RichTextController *controller = [RichTextController new];
    controller.viewModel = self;
    [navigationController pushViewController:controller animated:YES];
}

@end
