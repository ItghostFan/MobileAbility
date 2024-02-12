//
//  MvvmCellViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmCellViewModel.h"

#import "MvvmTableViewModelCell.h"
#import "MvvmCollectionViewModelCell.h"

@implementation MvvmCellViewModel

- (Class)tableCellClass {
    return MvvmTableViewModelCell.class;
}

- (Class)collectionCellClass {
    return MvvmCollectionViewModelCell.class;
}

@end
