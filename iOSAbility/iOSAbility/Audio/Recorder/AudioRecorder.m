//
//  AudioRecorder.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/3/18.
//

#import "AudioRecorder.h"

#import <AVKit/AVKit.h>

@interface AudioRecorder () <AVAudioRecorderDelegate>
@property (assign, nonatomic) AudioRecorderState state;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (weak, nonatomic) NSTimer *timer;
@end

@implementation AudioRecorder

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        NSURL *url = [NSURL fileURLWithPath:path];
        NSDictionary *setting = @{
            AVFormatIDKey: @(kAudioFormatMPEG4AAC),
            AVSampleRateKey: @(44100),
            AVNumberOfChannelsKey: @(2),
            AVLinearPCMBitDepthKey: @(16),
        };
        NSError *error;
        _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        NSAssert(!error, @"Check %@!", error);
        _recorder.meteringEnabled = YES;
        _recorder.delegate = self;
    }
    return self;
}

- (void)dealloc {
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)startRecord {
    self.state = AudioRecorderStateRecording;
    [self prepareToRecord];
    [_recorder record];
}

- (void)startRecordDuration:(NSTimeInterval)duration {
    self.state = AudioRecorderStateRecording;
    [self prepareToRecord];
    [_recorder recordForDuration:duration];
}

- (void)stopRecord {
    self.state = AudioRecorderStateStop;
    [_recorder stop];
    NSError *error;
    [AVAudioSession.sharedInstance setActive:NO error:&error];
    NSAssert(!error, @"Check %@!", error);
    [_timer invalidate];
    _timer = nil;
    [NSNotificationCenter.defaultCenter removeObserver:self name:AVAudioSessionInterruptionNotification object:nil];
}

#pragma mark - Private

- (void)prepareToRecord {
    if (![_recorder prepareToRecord]) {
        NSAssert(NO, @"Check!");
    }
    NSError *error;
    [AVAudioSession.sharedInstance setActive:YES error:&error];
    NSAssert(!error, @"Check %@!", error);
    [AVAudioSession.sharedInstance setCategory:AVAudioSessionCategoryRecord error:&error];
    NSAssert(!error, @"Check %@!", error);
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(onRecordingTimer:) userInfo:nil repeats:YES];
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onAudioInterruptNotification:) name:AVAudioSessionInterruptionNotification object:nil];
}

#pragma mark - Timer

- (void)onRecordingTimer:(NSTimer *)timer {
    [_recorder updateMeters];
    NSNumber *channelCount = _recorder.settings[AVNumberOfChannelsKey];
    for (NSInteger index = 0; index < channelCount.integerValue; ++index) {
        CGFloat power = [_recorder peakPowerForChannel:index];
        NSLog(@"Recorder Channel %ld power: %f", index, power);
    }
}

#pragma mark - Notifications

- (void)onAudioInterruptNotification:(NSNotification *)notification {
    [self stopRecord];
}

#pragma mark - AVAudioRecorderDelegate


- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    [self stopRecord];
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error {
    [self stopRecord];
}

@end
