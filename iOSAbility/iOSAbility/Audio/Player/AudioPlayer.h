//
//  AudioPlayer.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/3/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AudioPlayerState) {
    AudioPlayerStateNone,
    AudioPlayerStatePlaying,
    AudioPlayerStateStop,
};

@interface AudioPlayer : NSObject

@property (assign, nonatomic, readonly) AudioPlayerState state;

- (instancetype)initWithPath:(NSString *)path;

- (void)startPlay;
- (void)stopPlay;

@end

NS_ASSUME_NONNULL_END
