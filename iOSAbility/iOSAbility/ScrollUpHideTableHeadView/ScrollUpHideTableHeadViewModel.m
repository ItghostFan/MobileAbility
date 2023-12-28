//
//  ScrollUpHideTableHeadViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/26.
//

#import "ScrollUpHideTableHeadViewModel.h"

#import "ScrollUpHideTableHeadController.h"

@interface ScrollUpHideTableHeadViewModel ()
@property (strong, nonatomic) NSMutableArray<__kindof RowViewModel *> *viewModels;
@end

@implementation ScrollUpHideTableHeadViewModel

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    ScrollUpHideTableHeadController *controller = [ScrollUpHideTableHeadController new];
    controller.viewModel = self;
    [navigationController pushViewController:controller animated:YES];
}

#pragma mark - Getter

- (NSMutableArray<__kindof RowViewModel *> *)viewModels {
    if (!_viewModels) {
        _viewModels = [NSMutableArray new];
        for (NSUInteger index = 0; index < 100; ++index) {
            [_viewModels addObject:RowViewModel.new];
        }
    }
    return _viewModels;
}

@end
