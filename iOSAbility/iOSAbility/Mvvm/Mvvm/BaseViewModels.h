//
//  HGViewModels.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/4.
//

#import <Foundation/Foundation.h>

#import "BaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewModels<__covariant ObjectType> : BaseViewModel

@property (strong, nonatomic, readonly) NSArray<ObjectType> *viewModels;

- (instancetype)initWithViewModels:(NSArray<ObjectType> *)viewModels;

- (void)addViewModel:(ObjectType)viewModel;
- (void)insertViewModel:(ObjectType)viewModel atIndex:(NSUInteger)index;
- (void)replaceViewModelAtIndex:(NSUInteger)index withViewModel:(ObjectType)viewModel;
//- (void)insertViewModels:(NSArray<ObjectType> *)viewModels atIndexes:(NSIndexSet *)indexes;
- (void)removeViewModel:(ObjectType)viewModel;
- (void)removeViewModelsAtIndexes:(NSIndexSet *)indexes;
- (void)removeViewModels:(NSArray<ObjectType> *)viewModels;
- (void)removeAllViewModels;
- (ObjectType)objectAtIndexedSubscript:(NSUInteger)idx;

@end

NS_ASSUME_NONNULL_END
