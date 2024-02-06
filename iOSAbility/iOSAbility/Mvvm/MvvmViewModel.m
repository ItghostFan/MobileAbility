//
//  MvvmViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "MvvmViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "MvvmController.h"

@interface MvvmViewModel ()
@end

@implementation MvvmViewModel

- (instancetype)initWithRowContents:(NSDictionary *)rowContents {
    if (self = [super initWithRowContents:rowContents]) {
    }
    return self;
}

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    MvvmController *controller = [MvvmController new];
    controller.viewModel = self;
    [navigationController pushViewController:controller animated:YES];
}

@end
