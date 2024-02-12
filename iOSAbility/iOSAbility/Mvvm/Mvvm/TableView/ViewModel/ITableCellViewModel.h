//
//  ITableCellViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/7.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ITableCellViewModel <NSObject>

@property (weak, nonatomic, nullable) NSIndexPath *tableIndexPath;
@property (strong, nonatomic, readonly) Class tableCellClass;     // TableView中展示的Cell类。
@property (assign, nonatomic, readonly) CGSize tableCellSize;               // 最后一次tableCellHeightForWidth的size。

- (CGFloat)tableCellHeightForWidth:(CGFloat)width;                          // 在计算Table View Cell高度时调用。

@end

NS_ASSUME_NONNULL_END
