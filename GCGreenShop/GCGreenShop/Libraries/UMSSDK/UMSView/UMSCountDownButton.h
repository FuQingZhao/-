//
//  UMSCountDownButton.h
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/18.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSInteger const kStartCountDownNum = 60;

typedef NS_ENUM(NSInteger, UMSCountDownState) {
    UMSCountDownNotStarted = 0,
    UMSCountDownStarting,
    UMSCountDownStopped,
};

@interface UMSCountDownButton : UIButton

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
                  countDownCompletion:(void(^)(void))countDownCompletion;

/** 开始倒计时 */
- (void)startCountDown;

/** 停止倒计时 */
- (void)stopCountDown;

@end


/**
 倒计时处理
 */
@interface UMSCountDownHandler : NSObject

@property (nonatomic, assign) UMSCountDownState state;
@property (nonatomic, assign) NSInteger restCountDownNum;  /** 当前倒计时 */

+ (instancetype)handler;

/** 开始倒计时 */
- (void)start;

/** 停止倒计时 */
- (void)stop;

@end
