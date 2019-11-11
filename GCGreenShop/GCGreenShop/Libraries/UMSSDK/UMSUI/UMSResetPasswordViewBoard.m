//
//  UMSResetPasswordViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSResetPasswordViewBoard.h"
#import "UMSIndicatorTextView.h"
#import "UMSCountDownButton.h"

@interface UMSResetPasswordViewBoard ()
@property (nonatomic, strong) UMSIndicatorTextView *mobileTextView;
@property (nonatomic, strong) UMSIndicatorTextView *smsCodeTextView;
@property (nonatomic, strong) UMSIndicatorTextView *passwordTextView;
@property (nonatomic, strong) UMSCountDownButton *sendSmsButton;
@property (nonatomic, strong) UIButton *submitButton;
@end

@implementation UMSResetPasswordViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置用户密码";
    [self _initDefaultUI];
}


#pragma mark - Default UI

- (void)_initDefaultUI {
    /** Logo */
    [self _initLogoImageView];
    /** 输入框 */
    [self _initIndicatorTextViews];
    /** 登录和获取验证码按钮 */
    [self _initButtons];
}

- (void)_initLogoImageView {
    UIImage *logo = [UMSAppConfiguration imageWithBundleResource:@"ums_login_logo"];
    UIImageView *logoView = [UIImageView new];
    logoView.size = logo.size;
    logoView.top = 30.0;
    logoView.centerX = self.view.frame.size.width / 2.0;
    logoView.image = logo;
    [self.view addSubview:logoView];
}

- (void)_initIndicatorTextViews {
    
    self.mobileTextView = [UMSIndicatorTextView new];
    self.mobileTextView.top = 148.0;
    self.mobileTextView.size = CGSizeMake(self.view.width, defTextViewHeight);
    self.mobileTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_mobile"];
    self.mobileTextView.innerTextField.placeholder = @"输入手机号码";
    self.mobileTextView.innerTextField.returnKeyType = UIReturnKeyNext;
    self.mobileTextView.innerTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.mobileTextView];
    
    self.smsCodeTextView = [UMSIndicatorTextView new];
    self.smsCodeTextView.top = self.mobileTextView.bottom + 24.0;
    self.smsCodeTextView.size = self.mobileTextView.size;
    self.smsCodeTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_code"];
    self.smsCodeTextView.innerTextField.placeholder = @"输入验证码";
    self.smsCodeTextView.innerTextField.returnKeyType = UIReturnKeyNext;
    self.smsCodeTextView.innerTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.smsCodeTextView.innerTextField.width = self.view.frame.size.width - (16.0 + BTK_THAT_FITS(90.0) + 80.0);
    [self.view addSubview:self.smsCodeTextView];
    
    self.passwordTextView = [UMSIndicatorTextView new];
    self.passwordTextView.top = self.smsCodeTextView.bottom + 24.0;
    self.passwordTextView.size = self.smsCodeTextView.size;
    self.passwordTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_password"];
    self.passwordTextView.innerTextField.placeholder = @"设置登录密码";
    self.passwordTextView.innerTextField.returnKeyType = UIReturnKeyGo;
    self.passwordTextView.innerTextField.secureTextEntry = true;
    [self.view addSubview:self.passwordTextView];
    
    // 手机号和密码限制最大长度
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
    
    [self.passwordTextView.innerTextField bk_addEventHandler:^(UITextField *sender) {
        NSString *text = sender.text;
        if ([text length] > 12) {
            NSString *newText = [text substringToIndex:12];
            self.passwordTextView.innerTextField.text = newText;
        }
    } forControlEvents:UIControlEventEditingChanged];
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    clearButton.backgroundColor = [UIColor clearColor];
    [clearButton setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_close"] forState:UIControlStateNormal];
    [clearButton setSize:CGSizeMake(defTextViewHeight, defTextViewHeight)];
    self.mobileTextView.innerTextField.rightView = clearButton;
    self.mobileTextView.innerTextField.rightViewMode = UITextFieldViewModeWhileEditing;
    [clearButton bk_addEventHandler:^(UIButton *sender) {
        UITextField *textField = (UITextField *)sender.superview;
        if ([textField respondsToSelector:@selector(setText:)]) {
            [textField setText:@""];
        }
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *visibleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    visibleButton.backgroundColor = [UIColor clearColor];
    [visibleButton setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_visible"] forState:UIControlStateNormal];
    [visibleButton setSize:CGSizeMake(defTextViewHeight, defTextViewHeight)];
    self.passwordTextView.innerTextField.rightView = visibleButton;
    self.passwordTextView.innerTextField.rightViewMode = UITextFieldViewModeAlways;
    [visibleButton bk_addEventHandler:^(UIButton *sender) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            self.passwordTextView.innerTextField.secureTextEntry = NO;
            [sender setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_unvisible"] forState:UIControlStateNormal];
        } else {
            self.passwordTextView.innerTextField.secureTextEntry = YES;
            [sender setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_visible"] forState:UIControlStateNormal];
        }
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_initButtons {
    
    self.sendSmsButton = [[UMSCountDownButton alloc] initWithButtonClicked:^{
        //------- 按钮点击 -------//
        [self _handleSmsEvent];
    } countDownStart:^{
        //------- 倒计时开始 -------//
        [self.sendSmsButton setTitle:[NSString stringWithFormat:@"%ld秒", kStartCountDownNum] forState:UIControlStateNormal];
        self.sendSmsButton.enabled = NO;
    } countDownUnderway:^(NSInteger restCountDownNum) {
        //------- 倒计时进行中 -------//
        [self.sendSmsButton setTitle:[NSString stringWithFormat:@"%ld秒", restCountDownNum] forState:UIControlStateNormal];
        self.sendSmsButton.enabled = NO;
    } countDownCompletion:^{
        //------- 倒计时结束 -------//
        [self.sendSmsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.sendSmsButton.enabled = YES;
    }];
    self.sendSmsButton.size = CGSizeMake(84.0, 24.0);
    self.sendSmsButton.right = self.view.frame.size.width - 35.0;
    self.sendSmsButton.centerY = self.smsCodeTextView.frame.origin.y + defTextViewHeight / 2.0;
    self.sendSmsButton.layer.masksToBounds = YES;
    self.sendSmsButton.layer.cornerRadius = 12.0;
    self.sendSmsButton.layer.borderWidth = 1.0;
    self.sendSmsButton.titleLabel.font = BTKFONT_SIZED(11.0);
    [self.sendSmsButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.sendSmsButton.enabled = NO;
    [self.view addSubview:self.sendSmsButton];
    
    if ([UMSCountDownHandler handler].state == UMSCountDownStarting) {
        NSInteger resetCountDown = [UMSCountDownHandler handler].restCountDownNum;
        [self.sendSmsButton setTitle:[NSString stringWithFormat:@"%ld秒", resetCountDown] forState:UIControlStateNormal];
        self.sendSmsButton.enabled = NO;
    }
    
    UIImage *loginBg = [UMSAppConfiguration imageWithBundleResource:@"ums_login_bg"];
    self.submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.submitButton.size = loginBg.size;
    self.submitButton.centerX = self.view.frame.size.width / 2.0;
    self.submitButton.top = self.passwordTextView.bottom + 30.0;
    self.submitButton.titleLabel.font = BTKFONT_SIZED(16.0);
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.submitButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.submitButton setBackgroundImage:loginBg forState:UIControlStateNormal];
    [self.view addSubview:self.submitButton];
    
    [self.submitButton bk_addEventHandler:^(id sender) {
        [self _handleResetEvent];
    } forControlEvents:UIControlEventTouchUpInside];
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
    [UMSSDK getVerificationCodeWithPhone:phone verifyType:VerificationTypeResetPassword result:^(id response, NSError *error) {
        if (!error) {
            [self showWithStatus:@"验证码已发送"];
        } else {
            [self showError:error.why];
            [self.sendSmsButton stopCountDown];
        }
    }];
}

- (void)_handleResetEvent {
    
    NSString *phone = self.mobileTextView.innerTextField.text;
    NSString *smscode = self.smsCodeTextView.innerTextField.text;
    NSString *password = self.passwordTextView.innerTextField.text;
    
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
    if ([password length] == 0) {
        [self showError:@"请输入密码"];
        return;
    }
    if ([password length] < 6 || [password length] > 12) {
        [self showError:@"密码长度不正确"];
        return;
    }
    
    [UMSSDK resetPasswordWithPhone:phone newPassword:password smsCode:smscode result:^(NSError *error) {
        if (!error) {
            [self showWithStatus:@"修改成功"];
            [self performBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelay:1.0];
        }
        else {
            [self showError:[error why]];
        }
    }];
}

@end
