//
//  RowViewModel.h
//  iOSAbility
//
//  Created by ItghostFan on 2023/12/25.
//

#import <UIKit/UIKit.h>

#import "CellViewModel+TableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RowViewModel : CellViewModel

@property (strong, nonatomic, readonly) NSString *content;

- (instancetype)initWithRowContents:(NSDictionary *)rowContents;

#pragma mark - Subclass

- (void)pushToNavigationController:(UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
