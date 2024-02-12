//
//  MvvmCollectionViewModelCell.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/12.
//

#import "MvvmCollectionViewModelCell.h"

@implementation MvvmCollectionViewModelCell

+ (CGSize)cellSizeForSize:(CGSize *)size viewModel:(CellViewModel *)viewModel {
    return CGSizeMake(100.0f, 100.0f);
}

@end
