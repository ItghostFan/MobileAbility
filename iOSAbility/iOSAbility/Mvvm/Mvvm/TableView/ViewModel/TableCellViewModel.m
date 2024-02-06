//
//  TableCellViewModel.m
//  AFNetworking
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableCellViewModel.h"

#import "TableViewModelCell.h"

@interface TableCellViewModel ()
@property (assign, nonatomic) CGSize contentSize;
@property (strong, nonatomic, readonly) NSMutableDictionary<__kindof NSNumber *, __kindof NSNumber *> *widthHeights;
@end

@implementation TableCellViewModel

- (instancetype)init {
    if (self = [super init]) {
        _widthHeights = NSMutableDictionary.new;
    }
    return self;
}

- (Class)cellClass {
    NSAssert(NO, @"%@ %s Should Implement By Subclass!", NSStringFromClass(self.class), __FUNCTION__);
    return TableViewModelCell.class;
}

- (CGFloat)heightForWidth:(CGFloat)width {
    NSNumber *height;
    @synchronized (_widthHeights) {
        height = _widthHeights[@(width)];
        if (!height) {
            CGFloat contentWidth = width;
            height = @([self.cellClass cellHeightForWidth:&contentWidth viewModel:self]);
            _widthHeights[@(width)] = height;
            _contentSize = CGSizeMake(contentWidth, height.doubleValue);
        }
    }
    
    return height.doubleValue;
}

@end
