//
//  RowViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RowViewModel.h"

@interface RowViewModel ()
@property (strong, nonatomic) NSString *content;
@end

@implementation RowViewModel

- (instancetype)initWithRowContents:(NSDictionary *)rowContents {
    if (self = [super init]) {
        _content = rowContents[NSStringFromClass(self.class)];
    }
    return self;
}

@end