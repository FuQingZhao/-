//
//  UMSCountDownButton.m
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/18.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import "UMSCountDownButton.h"

typedef void(^ButtonClickedBlock) (void);
typedef void(^CountDownStartBlock) (void);
typedef void(^CountDownUnderwayBlock) (NSInteger restCountDownNum);
typedef void(^CountDownCompletionBlock) (void);

@interface UMSCountDownButton ()

/** 控制倒计时的timer */
@property (nonatomic, strong) NSTimer *timer;
/** 按钮点击事件的回调 */
@property (nonatomic, copy) ButtonClickedBlock buttonClickedBlock;
/** 倒计时开始时的回调 */
@property (nonatomic, copy) CountDownStartBlock countDownStartBlock;
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) CountDownUnderwayBlock countDownUnderwayBlock;
/** 倒计时完成时的回调 */
@property (nonatomic, copy) CountDownCompletionBlock countDownCompletionBlock;

@end

@implementation UMSCountDownButton {
    /** 倒计时开始值 */
    NSInteger _startCountDownNum;
    /** 剩余倒计时的值 */
    NSInteger _restCountDownNum;
}

- (void)setEnabled:(BOOL)enabled {
    if (enabled) {
        self.userInteractionEnabled = YES;
        self.layer.borderColor = [UIColor colorWithHexString:@"#3c434c"].CGColor;
        [self setTitleColor:[UIColor colorWithHexString:@"#3c434c"] forState:UIControlStateNormal];
    }
    else {
        self.userInteractionEnabled = NO;
        self.layer.borderColor = [UIColor colorWithHexString:@"#3c434c"].CGColor;
        [self setTitleColor:[UIColor colorWithHexString:@"#3c434c"] forState:UIControlStateNormal];
    }
}

/**
 构造方法
 
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithButtonClicked:(void(^)(void))buttonClicked
                       countDownStart:(void(^)(void))countDownStart
                    countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
                  countDownCompletion:(void(^)(void))countDownCompletion {
    if (self = [super init]) {
        _startCountDownNum = [UMSCountDownHandler handler].restCountDownNum;
        self.buttonClickedBlock       = buttonClicked;
        self.countDownStartBlock      = countDownStart;
        self.countDownUnderwayBlock   = countDownUnderway;
        self.countDownCompletionBlock = countDownCompletion;
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        if ([UMSCountDownHandler handler].state == UMSCountDownStarting) {
            [self startCountDown];
        }
    }
    return self;
}

/** 按钮点击 */
- (void)buttonClicked:(UMSCountDownButton *)sender {
    sender.enabled = NO;
    [[UMSCountDownHandler handler] start];
    self.buttonClickedBlock();
}

/** 开始倒计时 */
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    self.countDownStartBlock(); // 调用倒计时开始的block
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        [self refreshButton];
    } repeats:YES];
}

- (void)stopCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [[UMSCountDownHandler handler] stop];
    _startCountDownNum = [UMSCountDownHandler handler].restCountDownNum;
    _restCountDownNum = _startCountDownNum;
    self.countDownCompletionBlock(); // 调用倒计时完成的回调
    self.enabled = YES;
}

/** 刷新按钮内容 */
- (void)refreshButton {
    _restCountDownNum --;
    self.countDownUnderwayBlock(_restCountDownNum); // 调用倒计时进行中的回调
    if (_restCountDownNum == 0) {
        [self stopCountDown];
    }
}

- (void)dealloc {
    NSLog(@"倒计时按钮已释放");
}

@end



@interface UMSCountDownHandler ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation UMSCountDownHandler

+ (instancetype)handler {
    static dispatch_once_t onceToken;
    static UMSCountDownHandler *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[UMSCountDownHandler alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.restCountDownNum = kStartCountDownNum;
        self.state = UMSCountDownNotStarted;
    }
    return self;
}

- (void)start {
    [self stop];
    self.state = UMSCountDownStarting;
    self.timer = [NSTimer bk_scheduledTimerWithTimeInterval:1.0 block:^(NSTimer *timer) {
        self.restCountDownNum --;
        if (self.restCountDownNum == 0) {
            [self stop];
        }
    } repeats:YES];
}

- (void)stop {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.restCountDownNum = kStartCountDownNum;
    self.state = UMSCountDownStopped;
}

@end
