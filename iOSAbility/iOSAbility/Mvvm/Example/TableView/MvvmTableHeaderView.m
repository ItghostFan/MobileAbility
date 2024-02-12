//
//  MvvmTableHeaderView.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableHeaderView.h"

#import "MvvmSectionViewModel.h"

@implementation MvvmTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.redColor;
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = UIColor.redColor;
    }
    return self;
}

+ (CGFloat)heightForWidth:(CGFloat *)width viewModel:(MvvmSectionViewModel *)viewModel {
    return 40.0f;
}

@end
