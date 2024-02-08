//
//  MvvmTableSectionViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableSectionViewModel.h"

#import "MvvmTableHeaderView.h"
#import "MvvmTableFooterView.h"

@implementation MvvmTableSectionViewModel

- (Class)tableHeaderClass {
    return MvvmTableHeaderView.class;
}

- (Class)tableFooterClass {
    return MvvmTableFooterView.class;
}

@end
