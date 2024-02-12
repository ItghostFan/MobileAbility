//
//  MvvmCollectionHeaderView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/12.
//

#import "MvvmCollectionHeaderView.h"

@implementation MvvmCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.redColor;
    }
    return self;
}

+ (CGSize)headerSizeForSize:(CGSize *)size viewModel:(SectionViewModel *)viewModel {
    return CGSizeMake(20.0f, 30.0f);
}

@end
