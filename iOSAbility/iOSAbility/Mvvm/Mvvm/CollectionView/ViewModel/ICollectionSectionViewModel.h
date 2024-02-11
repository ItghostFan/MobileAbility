//
//  ICollectionSectionViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ICollectionSectionViewModel <NSObject>

@property (assign, nonatomic, readonly) CGSize collectionHeaderSize;               // 最后一次collectionHeaderSizeForSize:的size。
@property (assign, nonatomic, readonly) CGSize collectionFooterSize;               // 最后一次collectionFooterSizeForSize:的size。

@property (strong, nonatomic, readonly) Class collectionHeaderClass;
@property (strong, nonatomic, readonly) Class collectionFooterClass;

@property (assign, nonatomic) CGFloat collectionMinimumLineSpacing;
@property (assign, nonatomic) CGFloat collectionMinimumInteritemSpacing;

- (CGSize)collectionHeaderSizeForSize:(CGSize)size;
- (CGSize)collectionFooterSizeForSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
