//
//  AudioPlayer.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/3/20.
//

#import "AudioPlayer.h"

#import <AVKit/AVKit.h>

@interface AudioPlayer () <AVAudioPlayerDelegate>
@property (assign, nonatomic) AudioPlayerState state;
@property (strong, nonatomic) AVAudioPlayer *player;
@property (weak, nonatomic) NSTimer *timer;
@end

@implementation AudioPlayer

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        NSURL *url = [NSURL fileURLWithPath:path];
        NSError *error;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
        NSAssert(!error, @"Check %@!", error);
        _player.meteringEnabled = YES;
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)startPlay {
    self.state = AudioPlayerStatePlaying;
    [self prepareToPlay];
    [_player play];
}

- (void)stopPlay {
    self.state = AudioPlayerStateStop;
    [_player stop];
    NSError *error;
    [AVAudioSession.sharedInstance setActive:NO error:&error];
    NSAssert(!error, @"Check %@!", error);
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - Private

- (void)prepareToPlay {
    if (![_player prepareToPlay]) {
        NSAssert(NO, @"Check!");
    }
    NSError *error;
    [AVAudioSession.sharedInstance setActive:YES error:&error];
    NSAssert(!error, @"Check %@!", error);
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryPlayback error:&error];
    NSAssert(!error, @"Check %@!", error);
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(onPlayingTimer:) userInfo:nil repeats:YES];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onAudioInterruptNotification:) name:AVAudioSessionInterruptionNotification object:nil];
}

#pragma mark - Timer

- (void)onPlayingTimer:(NSTimer *)timer {
    [_player updateMeters];
    NSNumber *channelCount = _player.settings[AVNumberOfChannelsKey];
    for (NSInteger index = 0; index < channelCount.integerValue; ++index) {
        CGFloat power = [_player peakPowerForChannel:index];
        NSLog(@"Player Channel %ld power: %f", index, power);
    }
}

#pragma mark - Notifications

- (void)onAudioInterruptNotification:(NSNotification *)notification {
    [self stopPlay];
}

#pragma mark - AVAudioPlayerDelegate


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self stopPlay];
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    [self stopPlay];
}

@end
