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

- (Class)headerClass {
    return MvvmTableHeaderView.class;
}

- (Class)footerClass {
    return MvvmTableFooterView.class;
}

@end
