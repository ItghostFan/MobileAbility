//
//  MvvmTableController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/6.
//

#import "MvvmTableController.h"

#import <Masonry/Masonry.h>

#import "TableViewModel.h"
#import "MvvmCellViewModel.h"

@interface MvvmTableController ()

@end

@implementation MvvmTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
