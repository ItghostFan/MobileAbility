//
//  TableCellViewModel.h
//  AFNetworking
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableCellViewModel : CellViewModel

@property (assign, nonatomic, readonly) CGSize contentSize;    // 最后一次heightForWidth的size。

- (CGFloat)heightForWidth:(CGFloat)width;                    // 在计算Table View Cell高度时调用。

@end

NS_ASSUME_NONNULL_END
