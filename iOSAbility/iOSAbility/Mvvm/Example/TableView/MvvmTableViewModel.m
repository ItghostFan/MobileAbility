//
//  MvvmTableViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableViewModel.h"

#import "MvvmTableSectionViewModel.h"
#import "MvvmTableCellViewModel.h"

@implementation MvvmTableViewModel

- (instancetype)init {
    if (self = [super init]) {
        {
            MvvmTableSectionViewModel *sectionViewModel = MvvmTableSectionViewModel.new;
            MvvmTableCellViewModel *cellViewModel = MvvmTableCellViewModel.new;
            cellViewModel.section = 0;
            cellViewModel.row = 0;
            [sectionViewModel addViewModel:cellViewModel];
            [self.sectionViewModels addViewModel:sectionViewModel];
        }
        {
            MvvmTableSectionViewModel *sectionViewModel = MvvmTableSectionViewModel.new;
            MvvmTableCellViewModel *cellViewModel = MvvmTableCellViewModel.new;
            cellViewModel.section = 1;
            cellViewModel.row = 0;
            [sectionViewModel addViewModel:cellViewModel];
            [self.sectionViewModels addViewModel:sectionViewModel];
        }
    }
    return self;
}

@end
