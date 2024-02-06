//
//  CollectionViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "CollectionViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "CollectionCellViewModel.h"
#import "CollectionViewCell.h"
#import "CollectionHeaderView.h"
#import "CollectionFooterView.h"

@interface CollectionViewModel () <
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableSet *registeredCellIdentifiers;
@property (strong, nonatomic) NSMutableSet *registeredHeaderIdentifiers;
@property (strong, nonatomic) NSMutableSet *registeredFooterIdentifiers;

@end

@implementation CollectionViewModel

- (instancetype)init {
    if (self = [super init]) {
        _sectionViewModels = [[BaseViewModels alloc] initWithViewModels:@[]];
        _registeredCellIdentifiers = NSMutableSet.new;
        _registeredHeaderIdentifiers = NSMutableSet.new;
        _registeredFooterIdentifiers = NSMutableSet.new;
    }
    return self;
}

- (void)dealloc {
}

#pragma mark - Private

- (void)registerCellClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredCellIdentifiers containsObject:identifier]) {
        [self.collectionView registerClass:class forCellWithReuseIdentifier:identifier];
        [_registeredCellIdentifiers addObject:identifier];
    }
}

- (void)registerHeaderClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredHeaderIdentifiers containsObject:identifier]) {
        [self.collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:identifier];
        [_registeredHeaderIdentifiers addObject:identifier];
    }
}

- (void)registerFooterClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredFooterIdentifiers containsObject:identifier]) {
        [self.collectionView registerClass:class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:identifier];
        [_registeredFooterIdentifiers addObject:identifier];
    }
}

#pragma mark - Setter

- (void)setCollectionView:(UICollectionView *)collectionView {
    @weakify(self);
    [[[_sectionViewModels rac_valuesAndChangesForKeyPath:@keypath(_sectionViewModels.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self);
        [self onSectionsChange:change object:self.sectionViewModels observer:self];
    }];
    
    [_registeredCellIdentifiers removeAllObjects];
    [_registeredHeaderIdentifiers removeAllObjects];
    [_registeredFooterIdentifiers removeAllObjects];
    _collectionView = collectionView;
    
    for (CollectionSectionViewModel *sectionViewModel in _sectionViewModels.viewModels) {
        [self registerHeaderClass:sectionViewModel.headerClass];
        [self registerFooterClass:sectionViewModel.footerClass];
        for (CollectionCellViewModel *cellViewModel in sectionViewModel.viewModels) {
            [self registerCellClass:cellViewModel.cellClass];
        }
    }
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
}

#pragma mark - KVO Handler

- (void)addKvoSectionViewModel:(BaseViewModels<__kindof CollectionCellViewModel *> *)viewModel {
    @weakify(self, viewModel);
    RACDisposable *disposable = [[[viewModel rac_valuesAndChangesForKeyPath:@keypath(viewModel.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self, viewModel);
        [self onCellsChange:change object:viewModel observer:self];
    }];
}

#pragma mark - KVO

- (void)onSectionsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView insertSections:indexes];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.collectionView deleteSections:indexes];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView reloadSections:indexes];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)onCellsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    NSMutableArray<__kindof NSIndexPath *> *indexPathes = NSMutableArray.new;
    NSInteger section = [self.sectionViewModels.viewModels indexOfObject:object];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPathes addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
    }];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            [self.collectionView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            [self.collectionView insertItemsAtIndexPaths:indexPathes];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.collectionView deleteItemsAtIndexPaths:indexPathes];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.collectionView reloadItemsAtIndexPaths:indexPathes];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.item];
    return viewModel.cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    CollectionSectionViewModel *viewModel = self.sectionViewModels[section];
    return viewModel.minimumInteritemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    CollectionSectionViewModel *viewModel = self.sectionViewModels[section];
    return viewModel.minimumLineSpacing;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sectionViewModels.viewModels.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sectionViewModels[section].viewModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.item];
    return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(viewModel.cellClass) forIndexPath:indexPath];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionSectionViewModel *viewModel = self.sectionViewModels[indexPath.section];
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(viewModel.headerClass) forIndexPath:indexPath];
    }
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionSectionViewModel *viewModel = self.sectionViewModels[indexPath.section];
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(viewModel.footerClass) forIndexPath:indexPath];
    }
    return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.item];
    ((CollectionViewCell *)cell).viewModel = viewModel;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionSectionViewModel *viewModel = self.sectionViewModels[indexPath.section];
        ((CollectionHeaderView *)view).viewModel = viewModel;
        return;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        CollectionSectionViewModel *viewModel = self.sectionViewModels[indexPath.section];
        ((CollectionFooterView *)view).viewModel = viewModel;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.item];
    if ([viewModel.delegate respondsToSelector:@selector(didSelectedViewModel:atIndexPath:)]) {
        [(id<ICellViewModelDelegate>)viewModel.delegate didSelectedViewModel:viewModel atIndexPath:indexPath];
    }
    if (viewModel.deselectAfterDidSelect) {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

@end
