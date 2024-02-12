//
//  MvvmCollectionFooterView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/12.
//

#import "MvvmCollectionFooterView.h"

@implementation MvvmCollectionFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.blueColor;
    }
    return self;
}

+ (CGSize)footerSizeForSize:(CGSize *)size viewModel:(SectionViewModel *)viewModel {
    return CGSizeMake(30.0f, 20.0f);
}

@end
