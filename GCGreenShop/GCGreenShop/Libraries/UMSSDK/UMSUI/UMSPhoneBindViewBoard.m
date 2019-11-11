//
//  UMSPhoneBindViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSPhoneBindViewBoard.h"
#import "UMSIndicatorTextView.h"
#import "UMSCountDownButton.h"
#import "TTSandboxUtil.h"

@interface UMSPhoneBindViewBoard ()
@property (nonatomic, strong) UMSIndicatorTextView *mobileTextView;
@property (nonatomic, strong) UMSIndicatorTextView *smsCodeTextView;
@property (nonatomic, strong) UMSIndicatorTextView *inviteCodeTextView;
@property (nonatomic, strong) UMSCountDownButton *sendSmsButton;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UMSUser *tempUser;
@end

@implementation UMSPhoneBindViewBoard

- (instancetype)initWithTempUser:(UMSUser *)tempUser {
    self = [super init];
    if (self) {
        self.tempUser = tempUser;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定手机";
    [self _initDefaultUI];
    [self performBlock:^{
        [self showWithStatus:@"根据国家相关规定, 用户注册、发帖、回帖等功能将需要首先绑定手机号。"];
    } afterDelay:0.5];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    [IQKeyboardManager sharedManager].toolbarManageBehaviour = IQAutoToolbarBySubviews;
    // 控制是否显示键盘上的工具条
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}


#pragma mark - Default UI

- (void)_initDefaultUI {
    
    /** 输入框 */
    [self _initIndicatorTextViews];
    
    /** 登录和获取验证码按钮 */
    [self _initButtons];
}

- (void)_initButtons {
    
    self.sendSmsButton = [[UMSCountDownButton alloc] initWithButtonClicked:^{
        //------- 按钮点击 -------//
        [self _handleSmsEvent];
    } countDownStart:^{
        //------- 倒计时开始 -------//
        self.sendSmsButton.backgroundColor = TT_LIGHT_GRAY_COLOR;
        [self.sendSmsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.sendSmsButton setTitle:[NSString stringWithFormat:@"%ld秒", kStartCountDownNum] forState:UIControlStateNormal];
        self.sendSmsButton.enabled = NO;
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        self.sendSmsButton.backgroundColor = TT_LIGHT_GRAY_COLOR;
        [self.sendSmsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.sendSmsButton setTitle:[NSString stringWithFormat:@"%ld秒", restCountDownNum] forState:UIControlStateNormal];
        self.sendSmsButton.enabled = NO;
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        self.sendSmsButton.backgroundColor = TT_ORANGE_COLOR;
        [self.sendSmsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.sendSmsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.sendSmsButton.enabled = YES;
    }];
    self.sendSmsButton.size = CGSizeMake(90.0, 37.0);
    self.sendSmsButton.right = self.view.frame.size.width - 16.0;
    self.sendSmsButton.centerY = defTextViewHeight * 1.5;
    self.sendSmsButton.layer.masksToBounds = YES;
    self.sendSmsButton.layer.cornerRadius = 3.0;
    self.sendSmsButton.backgroundColor = TT_ORANGE_COLOR;
    self.sendSmsButton.titleLabel.font = BTKFONT_SIZED(16.0);
    [self.sendSmsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.sendSmsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.sendSmsButton.enabled = NO;
    [self.view addSubview:self.sendSmsButton];
    
    if ([UMSCountDownHandler handler].state == UMSCountDownStarting) {
        self.sendSmsButton.backgroundColor = TT_LIGHT_GRAY_COLOR;
        [self.sendSmsButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.sendSmsButton setTitle:[NSString stringWithFormat:@"%ld秒", [UMSCountDownHandler handler].restCountDownNum] forState:UIControlStateNormal];
        self.sendSmsButton.enabled = NO;
    }
    
    CGFloat leftPadding = BTK_THAT_FITS(15.0);
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.origin = CGPointMake(leftPadding, defTextViewHeight * 3 + BTK_THAT_FITS(30.0));
    self.submitButton.size = CGSizeMake(self.view.frame.size.width - leftPadding * 2, BTK_THAT_FITS(46.0));
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.cornerRadius = 3.0;
    self.submitButton.backgroundColor = TT_ORANGE_COLOR;
    self.submitButton.titleLabel.font = BTKFONT_SIZED(21.0);
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitle:@"提  交" forState:UIControlStateNormal];
    self.submitButton.enabled = ([self.tempUser.uid length] > 0);
    [self.view addSubview:self.submitButton];
    
    [self.submitButton bk_addEventHandler:^(id sender) {
        [self _handleBindEvent];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_initIndicatorTextViews {
    
    self.mobileTextView = [UMSIndicatorTextView new];
    self.mobileTextView.size = CGSizeMake(self.view.width, defTextViewHeight);
    self.mobileTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_mobile"];
    self.mobileTextView.innerTextField.placeholder = @"手机号码";
    self.mobileTextView.innerTextField.returnKeyType = UIReturnKeyNext;
    self.mobileTextView.innerTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.mobileTextView];
    [self.mobileTextView.innerTextField bk_addEventHandler:^(UITextField *sender) {
        NSString *text = sender.text;
        if ([text length] > 11) {
            NSString *newText = [text substringToIndex:11];
            self.mobileTextView.innerTextField.text = newText;
            if ([newText isMobileNumber]) {
                self.sendSmsButton.enabled = ([UMSCountDownHandler handler].state != UMSCountDownStarting);
            }
        } else if ([text length] == 11) {
            if ([text isMobileNumber]) {
                self.sendSmsButton.enabled = ([UMSCountDownHandler handler].state != UMSCountDownStarting);
            }
        } else {
            self.sendSmsButton.enabled = NO;
        }
    } forControlEvents:UIControlEventEditingChanged];
    
    self.smsCodeTextView = [UMSIndicatorTextView new];
    self.smsCodeTextView.top = self.mobileTextView.bottom;
    self.smsCodeTextView.size = self.mobileTextView.size;
    self.smsCodeTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_smscode"];
    self.smsCodeTextView.innerTextField.placeholder = @"验证码";
    self.smsCodeTextView.innerTextField.returnKeyType = UIReturnKeyNext;
    self.smsCodeTextView.innerTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.smsCodeTextView.innerTextField.width = self.view.frame.size.width - (16.0 + BTK_THAT_FITS(90.0) + 80.0);
    [self.view addSubview:self.smsCodeTextView];
    
    self.inviteCodeTextView = [UMSIndicatorTextView new];
    self.inviteCodeTextView.top = self.smsCodeTextView.bottom;
    self.inviteCodeTextView.size = self.mobileTextView.size;
    self.inviteCodeTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_invitecode"];
    self.inviteCodeTextView.innerTextField.placeholder = @"邀请码";
    self.inviteCodeTextView.innerTextField.returnKeyType = UIReturnKeyGo;
    [self.view addSubview:self.inviteCodeTextView];
}


#pragma mark - Events

- (void)_handleSmsEvent {
    
    NSString *phone = self.mobileTextView.innerTextField.text;
    if ([phone length] == 0) {
        [self showError:@"请输入手机号码"];
        return;
    }
    if ([phone length] != 11 || ![phone isMobileNumber]) {
        [self showError:@"请输入正确的手机号码"];
        return;
    }
    
    // 启动倒计时
    [self.sendSmsButton startCountDown];
    // 获取验证码
    [UMSSDK getVerificationCodeWithPhone:phone verifyType:VerificationTypePhoneBind result:^(id response, NSError *error) {
        if (!error) {
            [self showWithStatus:@"验证码已发送"];
        } else {
            [self showError:error.why];
            [self.sendSmsButton stopCountDown];
        }
    }];
}

- (void)_handleBindEvent {
    
    NSString *phone = self.mobileTextView.innerTextField.text;
    NSString *smscode = self.smsCodeTextView.innerTextField.text;
    NSString *reccode = self.inviteCodeTextView.innerTextField.text;
    
    if ([phone length] == 0) {
        [self showError:@"请输入手机号码"];
        return;
    }
    if ([phone length] != 11 || ![phone isMobileNumber]) {
        [self showError:@"请输入正确的手机号码"];
        return;
    }
    if ([smscode length] == 0) {
        [self showError:@"请输入验证码"];
        return;
    }
    
    [UMSSDK bindPhoneWithUser:self.tempUser.uid phone:phone smsCode:smscode inviteCode:reccode result:^(NSError *error) {
        
        if (self.bindHandler) {
            self.bindHandler(error);
        }
        
        if (!error) {
            [self showWithStatus:@"绑定成功"];
            [UMSUser copyUserData:self.tempUser];
            [UMSSDK currentUser].phone = phone;
            [TTSandboxUtil clearLoginInfo];
            [TTSandboxUtil storeUserId:self.tempUser.uid];
            [self performBlock:^{
                [self.navigationController popToRootViewControllerAnimated:YES];
            } afterDelay:1.0];
        }
        else {
            [self showError:[error why]];
        }
    }];
}

@end
