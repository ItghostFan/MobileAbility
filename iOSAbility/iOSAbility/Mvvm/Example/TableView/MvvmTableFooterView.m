//
//  MvvmTableFooterView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableFooterView.h"

#import "MvvmSectionViewModel.h"

@implementation MvvmTableFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.blueColor;
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.blueColor;
    }
    return self;
}

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(MvvmSectionViewModel *)viewModel {
    return 5.0f;
}

@end
