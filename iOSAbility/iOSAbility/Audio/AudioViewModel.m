//
//  AudioViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/3/18.
//

#import "AudioViewModel.h"

#import "AudioController.h"

@implementation AudioViewModel

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    AudioController *controller = [AudioController new];
    controller.viewModel = self;
    controller.title = self.content;
    [navigationController pushViewController:controller animated:YES];
}

@end
