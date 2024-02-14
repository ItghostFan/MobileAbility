//
//  RootViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import "RootViewModel.h"

#import "RowViewModel.h"

@interface RootViewModel ()
@end

@implementation RootViewModel

- (instancetype)initWithDelegate:(id<ICellViewModelDelegate>)delegate {
    if (self = [super init]) {
        NSString *path = [NSBundle.mainBundle pathForResource:@"RowContents" ofType:@"plist"];
        NSDictionary *rowContents = [NSDictionary dictionaryWithContentsOfFile:path];
        [self.sectionViewModels addViewModel:[[SectionViewModel alloc] initWithViewModels:@[]]];
        for (NSString *cls in rowContents.allKeys) {
            RowViewModel *cellViewModel = [[NSClassFromString(cls) alloc] initWithRowContents:rowContents];
            cellViewModel.delegate = delegate;
            [self.sectionViewModels[0] addViewModel:cellViewModel];
        }
    }
    return self;
}

@end
