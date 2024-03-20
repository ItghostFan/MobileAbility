//
//  DialogCellViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/27.
//

#import "DialogCellViewModel.h"
#import "DialogViewModelCell.h"

#import <ReactiveObjC/ReactiveObjC.h>

#import "MessageCellViewModel.h"

@interface DialogCellViewModel ()
@property (strong, nonatomic) NSString *lastMessage;
@end

@implementation DialogCellViewModel

- (instancetype)initWithUid:(NSNumber *)uid
                   messages:(NSMutableArray *)messages
                   delegate:(id<IDialogCellViewModelDelegate>)delegate {
    if (self = [super init]) {
        self.delegate = delegate;
        _uid = uid;
        _messagesViewModel = TableViewModel.new;
        SectionViewModel *sectionViewModel = SectionViewModel.new;
        for (NSDictionary *message in messages) {
            MessageCellViewModel *cellViewModel = [[MessageCellViewModel alloc] initWithUid:message[@"From"] message:message dialogDelegate:delegate];
            [sectionViewModel addViewModel:cellViewModel];
        }
        @weakify(self);
        [[RACObserve(sectionViewModel, viewModels) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSArray<__kindof MessageCellViewModel *> * _Nullable x) {
            @strongify(self);
            self.lastMessage = x.lastObject.message;
        }];
        [_messagesViewModel.sectionViewModels addViewModel:sectionViewModel];
    }
    return self;
}

- (Class)tableCellClass {
    return DialogViewModelCell.class;
}

@end
