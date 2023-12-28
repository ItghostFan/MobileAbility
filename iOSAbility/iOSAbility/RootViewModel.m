//
//  RootViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RootViewModel.h"

#import "RowViewModel.h"
#import "ScrollUpHideNavigationBarViewModel.h"
#import "ScrollUpHideTableHeadViewModel.h"

@interface RootViewModel ()
@property (strong, nonatomic) NSMutableArray<__kindof RowViewModel *> *viewModels;
@end

@implementation RootViewModel

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [NSBundle.mainBundle pathForResource:@"RowContents" ofType:@"plist"];
        NSDictionary *rowContents = [NSDictionary dictionaryWithContentsOfFile:path];
        
        _viewModels = [NSMutableArray new];
        [_viewModels addObject:[[ScrollUpHideNavigationBarViewModel alloc] initWithRowContents:rowContents]];
        [_viewModels addObject:[[ScrollUpHideTableHeadViewModel alloc] initWithRowContents:rowContents]];
    }
    return self;
}

@end
