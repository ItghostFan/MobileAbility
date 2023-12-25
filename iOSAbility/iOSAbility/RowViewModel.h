//
//  RowViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RowViewModel : NSObject

@property (strong, nonatomic, readonly) NSString *content;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (instancetype)initWithRowContents:(NSDictionary *)rowContents;

@end

NS_ASSUME_NONNULL_END
