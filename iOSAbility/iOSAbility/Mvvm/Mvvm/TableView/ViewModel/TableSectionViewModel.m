//
//  TableSectionViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableSectionViewModel.h"

#import "TableHeaderView.h"
#import "TableFooterView.h"

@interface TableSectionViewModel ()

@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *footerWidthHeights;
@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *headerWidthHeights;

@end

@implementation TableSectionViewModel

- (CGFloat)headerHeightForWidth:(CGFloat)width {
    NSNumber *height;
    @synchronized (_headerWidthHeights) {
        height = _headerWidthHeights[@(width)];
        if (!height) {
            CGFloat contentWidth = width;
            CGFloat headerHeight = [self.headerClass heightForWidth:&contentWidth viewModel:self];
            height = @(headerHeight > 0.0f ? headerHeight : 0.1f);
            _headerWidthHeights[@(width)] = height;
        }
    }
    
    return height.doubleValue;
}

- (CGFloat)footerHeightForWidth:(CGFloat)width {
    NSNumber *height;
    @synchronized (_footerWidthHeights) {
        height = _footerWidthHeights[@(width)];
        if (!height) {
            CGFloat contentWidth = width;
            CGFloat footerHeight = [self.footerClass heightForWidth:&contentWidth viewModel:self];
            height = @(footerHeight > 0.0f ? footerHeight : 0.1f);
            _footerWidthHeights[@(width)] = height;
        }
    }
    
    return height.doubleValue;
}

@end
