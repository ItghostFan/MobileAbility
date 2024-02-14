//
//  RowViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RowViewModel.h"

#import "RowCell.h"

@interface RowViewModel ()
@property (strong, nonatomic) NSString *content;
@end

@implementation RowViewModel

- (instancetype)initWithRowContents:(NSDictionary *)rowContents {
    if (self = [super init]) {
        self.content = rowContents[NSStringFromClass(self.class)];
    }
    return self;
}

- (void)pushToNavigationController:(UINavigationController *)navigationController {
    NSAssert(NO, @"%@ Subclass Should Implement %s", NSStringFromClass(self.class), __FUNCTION__);
}

#pragma mark - Subclass

- (Class)tableCellClass {
    return RowCell.class;
}

@end
