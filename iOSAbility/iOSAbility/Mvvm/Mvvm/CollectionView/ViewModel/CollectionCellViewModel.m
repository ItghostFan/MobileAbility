//
//  CollectionCellViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionCellViewModel.h"

#import "CollectionViewModelCell.h"

@interface CollectionCellViewModel ()

@end

@implementation CollectionCellViewModel

- (Class)collectionCellClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return CollectionViewModelCell.class;
}

@end
