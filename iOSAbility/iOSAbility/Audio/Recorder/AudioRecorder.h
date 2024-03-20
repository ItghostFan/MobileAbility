//
//  AudioRecorder.h
//  iOSAbility
//
//  Created by ItghostFan on 2024/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AudioRecorderState) {
    AudioRecorderStateNone,
    AudioRecorderStateRecording,
    AudioRecorderStateStop,
};

@interface AudioRecorder : NSObject

@property (assign, nonatomic, readonly) AudioRecorderState state;

- (instancetype)initWithPath:(NSString *)path;
- (void)startRecord;
- (void)startRecordDuration:(NSTimeInterval)duration;
- (void)stopRecord;

@end

NS_ASSUME_NONNULL_END
