//
//  MvvmSectionViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmSectionViewModel.h"

#import "MvvmTableHeaderView.h"
#import "MvvmTableFooterView.h"
#import "MvvmCollectionHeaderView.h"
#import "MvvmCollectionFooterView.h"

@implementation MvvmSectionViewModel

- (Class)tableHeaderClass {
    return MvvmTableHeaderView.class;
}

- (Class)tableFooterClass {
    return MvvmTableFooterView.class;
}

- (Class)collectionHeaderClass {
    return MvvmCollectionHeaderView.class;
}

- (Class)collectionFooterClass {
    return MvvmCollectionFooterView.class;
}

@end
