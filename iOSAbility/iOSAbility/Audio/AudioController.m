//
//  AudioController.m
//  iOSAbility
//
//  Created by ItghostFan on 2024/3/18.
//

#import "AudioController.h"

#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>

#import "AudioRecorder.h"
#import "AudioPlayer.h"

@interface AudioController ()

@property (strong, nonatomic) AudioRecorder *recorder;
@property (strong, nonatomic) AudioPlayer *player;

@property (weak, nonatomic) UITextView *audioPathTextView;
@property (weak, nonatomic) UIButton *recordButton;
@property (weak, nonatomic) UIButton *playButton;

@end

@implementation AudioController

- (void)dealloc {
    [_recorder stopRecord];
    [_player stopPlay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.audioPathTextView.hidden = NO;
    [self.recordButton addTarget:self action:@selector(onRecordClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton addTarget:self action:@selector(onPlayClicked:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - Actions

- (void)onRecordClicked:(id)sender {
    if (self.recorder.state == AudioRecorderStateRecording) {
        [self.recorder stopRecord];
        return;
    }
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *recordPath = [cachePath stringByAppendingPathComponent:@((uint64_t)(NSDate.date.timeIntervalSince1970 * 1000)).stringValue];
    self.audioPathTextView.text = recordPath;
    _recorder = [[AudioRecorder alloc] initWithPath:recordPath];
    [_recorder startRecordDuration:10.0f];
    @weakify(self);
    [[RACObserve(_recorder, state) takeUntil:_recorder.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable state) {
        @strongify(self);
        switch (state.integerValue) {
            case AudioRecorderStateStop: {
                self.recorder = nil;
                [self.recordButton setTitle:NSLocalizedString(@"Record", nil) forState:UIControlStateNormal];
                break;
            }
            case AudioRecorderStateRecording: {
                [self.recordButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
                break;
            }
            default: {
                break;
            }
        }
    }];
}

- (void)onPlayClicked:(id)sender {
    if (self.player.state == AudioPlayerStatePlaying) {
        [self.player stopPlay];
        return;
    }
    _player = [[AudioPlayer alloc] initWithPath:self.audioPathTextView.text];
    [_player startPlay];
    @weakify(self);
    [[RACObserve(_player, state) takeUntil:_player.rac_willDeallocSignal] subscribeNext:^(NSNumber * _Nullable state) {
        @strongify(self);
        switch (state.integerValue) {
            case AudioPlayerStateStop: {
                self.player = nil;
                [self.playButton setTitle:NSLocalizedString(@"Play", nil) forState:UIControlStateNormal];
                break;
            }
            case AudioPlayerStatePlaying: {
                [self.playButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateNormal];
                break;
            }
            default: {
                break;
            }
        }
    }];
}

#pragma mark - Getter

- (UITextView *)audioPathTextView {
    if (!_audioPathTextView) {
        UITextView *audioPathTextView = UITextView.new;
        _audioPathTextView = audioPathTextView;
        _audioPathTextView.editable = NO;
        _audioPathTextView.textColor = UIColor.grayColor;
        _audioPathTextView.showsVerticalScrollIndicator = YES;
        _audioPathTextView.font = [UIFont systemFontOfSize:14.0f];
        _audioPathTextView.layer.borderColor = UIColor.systemYellowColor.CGColor;
        _audioPathTextView.layer.borderWidth = 0.5f;
        [self.view addSubview:_audioPathTextView];
        [_audioPathTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.leading.trailing.equalTo(self.view);
            make.height.equalTo(self.view).multipliedBy(1.0f/3);
        }];
    }
    return _audioPathTextView;
}

- (UIButton *)recordButton {
    if (!_recordButton) {
        UIButton *recordButton = UIButton.new;
        _recordButton = recordButton;
        [_recordButton setTitle:NSLocalizedString(@"Record", nil) forState:UIControlStateNormal];
        [_recordButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [self.view addSubview:_recordButton];
        [_recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self.view.mas_centerX).offset(-5.0f);
            make.top.equalTo(self.audioPathTextView.mas_bottom).offset(10.0f);
            make.leading.equalTo(self.view).offset(10.0f);
            make.height.mas_equalTo(30.0f);
        }];
    }
    return _recordButton;
}

- (UIButton *)playButton {
    if (!_playButton) {
        UIButton *playButton = UIButton.new;
        _playButton = playButton;
        [_playButton setTitle:NSLocalizedString(@"Play", nil) forState:UIControlStateNormal];
        [_playButton setTitleColor:UIColor.redColor forState:UIControlStateNormal];
        [self.view addSubview:_playButton];
        [_playButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.view.mas_centerX).offset(5.0f);
            make.top.equalTo(self.audioPathTextView.mas_bottom).offset(10.0f);
            make.trailing.equalTo(self.view).offset(-10.0f);
            make.height.mas_equalTo(30.0f);
        }];
    }
    return _playButton;
}

@end
