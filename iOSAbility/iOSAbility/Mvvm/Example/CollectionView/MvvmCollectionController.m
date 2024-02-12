//
//  MvvmCollectionController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/12.
//

#import "MvvmCollectionController.h"

#import <Masonry/Masonry.h>

@interface MvvmCollectionController ()

@end

@implementation MvvmCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
