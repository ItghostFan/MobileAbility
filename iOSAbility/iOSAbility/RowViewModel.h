//
//  RowViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RowViewModel : NSObject

@property (strong, nonatomic, readonly) NSString *content;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (instancetype)initWithRowContents:(NSDictionary *)rowContents;

#pragma mark - Subclass

- (void)pushToNavigationController:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
