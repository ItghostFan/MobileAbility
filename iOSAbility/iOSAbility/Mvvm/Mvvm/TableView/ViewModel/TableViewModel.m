//
//  TableViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import "TableViewModel.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/NSObject+RACKVOWrapper.h>

#import "TableCellViewModel.h"
#import "TableViewModelCell.h"

@interface TableViewModel () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableSet *registeredCellIdentifiers;
@property (strong, nonatomic) NSMutableSet *registeredHeaderFooterIdentifiers;

@end

@implementation TableViewModel

- (instancetype)init {
    if (self = [super init]) {
        _sectionViewModels = [[BaseViewModels alloc] initWithViewModels:@[]];
        _registeredCellIdentifiers = NSMutableSet.new;
        _registeredHeaderFooterIdentifiers = NSMutableSet.new;
    }
    return self;
}

- (void)dealloc {
}

- (void)setTableView:(UITableView *)tableView {
    @weakify(self);
    [[[_sectionViewModels rac_valuesAndChangesForKeyPath:@keypath(_sectionViewModels.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self);
        [self onSectionsChange:change object:self.sectionViewModels observer:self];
    }];
    
    [_registeredCellIdentifiers removeAllObjects];
    [_registeredHeaderFooterIdentifiers removeAllObjects];
    _tableView = tableView;
    
    for (TableSectionViewModel *sectionViewModel in _sectionViewModels.viewModels) {
        [self registerHeaderFooterClass:sectionViewModel.headerClass];
        [self registerHeaderFooterClass:sectionViewModel.footerClass];
        for (TableCellViewModel *cellViewModel in sectionViewModel.viewModels) {
            [self registerCellClass:cellViewModel.cellClass];
        }
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
}

#pragma mark - KVO Handler

- (void)addKvoSectionViewModel:(BaseViewModels<__kindof TableCellViewModel *> *)viewModel {
    @weakify(self, viewModel);
    RACDisposable *disposable = [[[viewModel rac_valuesAndChangesForKeyPath:@keypath(viewModel.viewModels)
                                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld | NSKeyValueObservingOptionInitial
                                      observer:self] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        RACTupleUnpack(id object OS_UNUSED, NSDictionary *change) = x;
        @strongify(self, viewModel);
        [self onRowsChange:change object:viewModel observer:self];
    }];
}

#pragma mark - KVO

- (void)onSectionsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    [self.tableView beginUpdates];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.tableView deleteSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView reloadSections:indexes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        default: {
            break;
        }
    }
    [self.tableView endUpdates];
}

- (void)onRowsChange:(NSDictionary<NSKeyValueChangeKey,id> *)change object:(id)object observer:(id)observer {
    NSKeyValueChange valueChange = [change[NSKeyValueChangeKindKey] unsignedIntegerValue];
    NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
    NSArray *news = change[NSKeyValueChangeNewKey];
//    NSArray *olds = change[NSKeyValueChangeOldKey];
    NSMutableArray<__kindof NSIndexPath *> *indexPathes = NSMutableArray.new;
    NSInteger section = [_sectionViewModels.viewModels indexOfObject:object];
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        [indexPathes addObject:[NSIndexPath indexPathForRow:idx inSection:section]];
    }];
    [self.tableView beginUpdates];
    switch (valueChange) {
        case NSKeyValueChangeSetting: {
            [self.tableView reloadData];
            break;
        }
        case NSKeyValueChangeInsertion: {
            [self.tableView insertRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeRemoval: {
            [self.tableView deleteRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        case NSKeyValueChangeReplacement: {
            for (BaseViewModels *sectionViewModel in news) {
                [self addKvoSectionViewModel:sectionViewModel];
            }
            [self.tableView reloadRowsAtIndexPaths:indexPathes withRowAnimation:UITableViewRowAnimationNone];
            break;
        }
        default: {
            break;
        }
    }
    [self.tableView endUpdates];
}

#pragma mark - Private

- (void)registerCellClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (![_registeredCellIdentifiers containsObject:identifier]) {
        [self.tableView registerClass:class forCellReuseIdentifier:identifier];
        [_registeredCellIdentifiers addObject:identifier];
    }
}

- (void)registerHeaderFooterClass:(Class)class {
    NSString *identifier = NSStringFromClass(class);
    if (identifier && ![_registeredHeaderFooterIdentifiers containsObject:identifier]) {
        [self.tableView registerClass:class forHeaderFooterViewReuseIdentifier:identifier];
        [_registeredHeaderFooterIdentifiers addObject:identifier];
    }
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.sectionViewModels[indexPath.section].viewModels[indexPath.row] heightForWidth:CGRectGetWidth(tableView.frame)];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.row];
    ((TableViewModelCell *)cell).viewModel = viewModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.row];
    if ([viewModel.delegate respondsToSelector:@selector(didSelectedViewModel:atIndexPath:)]) {
        [viewModel.delegate didSelectedViewModel:viewModel atIndexPath:indexPath];
    }
    if (viewModel.deselectAfterDidSelect) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TableSectionViewModel *viewModel = self.sectionViewModels[section];
    if (viewModel.headerClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(viewModel.headerClass)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    TableSectionViewModel *viewModel = self.sectionViewModels[section];
    return [viewModel headerHeightForWidth:CGRectGetWidth(tableView.bounds)];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    TableSectionViewModel *viewModel = self.sectionViewModels[section];
    if (viewModel.footerClass) {
        return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(viewModel.footerClass)];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    TableSectionViewModel *viewModel = self.sectionViewModels[section];
    return [viewModel footerHeightForWidth:CGRectGetWidth(tableView.bounds)];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionViewModels.viewModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableCellViewModel *viewModel = self.sectionViewModels[indexPath.section].viewModels[indexPath.row];
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(viewModel.cellClass) forIndexPath:indexPath];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sectionViewModels[section].viewModels.count;
}

@end
