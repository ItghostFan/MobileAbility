//
//  DialogsViewModel.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/2/21.
//

#import "DialogsViewModel.h"

#import "SectionViewModel.h"
#import "DialogCellViewModel.h"

@interface DialogsViewModel () <IDialogCellViewModelDelegate>
// 👦🏻👩🏻🧔🏻
@property (strong, nonatomic) NSDictionary<__kindof NSString *, __kindof NSDictionary<__kindof NSString *, __kindof NSString *> *> *users;
@end

@implementation DialogsViewModel

- (instancetype)init {
    if (self = [super init]) {
        NSString *path = [NSBundle.mainBundle pathForResource:@"Users" ofType:@"plist"];
        _users = [NSDictionary dictionaryWithContentsOfFile:path];
        
        path = [NSBundle.mainBundle pathForResource:@"Dialogs" ofType:@"plist"];
        NSMutableArray *userMessages = [NSDictionary dictionaryWithContentsOfFile:path][@"UserMessages"];
        SectionViewModel *sectionViewModel = SectionViewModel.new;
        for (NSDictionary *userMessage in userMessages) {
            DialogCellViewModel *cellViewModel = [[DialogCellViewModel alloc] initWithUid:userMessage[@"Uid"] messages:userMessage[@"Messages"] delegate:self];
            [sectionViewModel addViewModel:cellViewModel];
        }
        [self.sectionViewModels addViewModel:sectionViewModel];
    }
    return self;
}

#pragma mark - IDialogCellViewModelDelegate

- (NSString *)nicknameOfUid:(NSNumber *)uid {
    return _users[uid.stringValue][@"Nickname"];
}

- (NSString *)avatarUrlOfUid:(NSNumber *)uid {
    return _users[uid.stringValue][@"AvatarUrl"];
}

@end
