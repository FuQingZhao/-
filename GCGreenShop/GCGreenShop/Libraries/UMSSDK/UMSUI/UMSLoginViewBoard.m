//
//  UMSLoginViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSLoginViewBoard.h"
#import "UMSIndicatorTextView.h"
#import "TTSandboxUtil.h"

#import "UMSRegisterViewBoard.h"
#import "UMSResetPasswordViewBoard.h"
#import "UMSPhoneBindViewBoard.h"

@interface UMSLoginViewBoard ()
@property (nonatomic, strong) UMSIndicatorTextView *mobileTextView;
@property (nonatomic, strong) UMSIndicatorTextView *passwordTextView;
@property (nonatomic, strong) UIButton *loginButton;
@end

static CGFloat const defRestPasswordTextHeight = 14.0;  // 忘记密码按钮默认字体大小

@implementation UMSLoginViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleVerticalPositionAdjustment:4.0 forBarMetrics:UIBarMetricsDefault];
    self.title = @"登录";
    [self wr_setNavBarBarTintColor:[UIColor whiteColor]];
    [self wr_setNavBarBackgroundAlpha:1.0];
    [self wr_setNavBarShadowImageHidden:YES];
    [self _initDefaultUI];
}

+ (void)pushLoginFrom:(UIViewController *)from loginHandler:(void(^) (NSError *error))loginHandler {
    UMSLoginViewBoard *loginViewBoard = [UMSLoginViewBoard new];
    loginViewBoard.loginHandler = loginHandler;
    [from.navigationController pushViewController:loginViewBoard animated:YES];
}

+ (void)presentLoginFrom:(UIViewController *)from loginHandler:(void(^) (NSError *error))loginHandler {
    UMSLoginViewBoard *loginViewBoard = [UMSLoginViewBoard new];
    loginViewBoard.loginHandler = loginHandler;
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginViewBoard];
    [from presentViewController:loginNav animated:YES completion:^{
        NSLog(@"启动登录页面");
    }];
}


#pragma mark - Default UI

- (void)_initDefaultUI {
    /** 左边关闭按钮 */
    [self _initLeftCloseItem];
    /** Logo */
    [self _initLogoImageView];
    /** 手机号和密码输入框 */
    [self _initIndicatorTextViews];
    /** 登录按钮 */
    [self _initLoginButton];
    /** 快速注册 */
    [self _initRegisterButton];
    /** 忘记密码 */
    [self _initResetPasswordButton];
}

- (void)_initLeftCloseItem {
    UIButton *leftCloseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftCloseButton setImage:BTKIMAGE(@"nav_close") forState:UIControlStateNormal];
    [leftCloseButton sizeToFit];
    UIBarButtonItem *leftCloseItem = [[UIBarButtonItem alloc] initWithCustomView:leftCloseButton];
    self.navigationItem.leftBarButtonItem = leftCloseItem;
    [leftCloseButton bk_addEventHandler:^(id sender) {
        [self.navigationController.navigationBar setShadowImage:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    } forControlEvents:UIControlEventTouchUpInside];
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
    self.mobileTextView.innerTextField.placeholder = @"请输入手机号码";
    self.mobileTextView.innerTextField.returnKeyType = UIReturnKeyNext;
    self.mobileTextView.innerTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.mobileTextView.innerTextField.text = [TTSandboxUtil phoneFromSandbox];
    [self.view addSubview:self.mobileTextView];
    
    self.passwordTextView = [UMSIndicatorTextView new];
    self.passwordTextView.top = self.mobileTextView.bottom + 24.0;
    self.passwordTextView.size = self.mobileTextView.size;
    self.passwordTextView.icon = [UMSAppConfiguration imageWithBundleResource:@"ums_password"];
    self.passwordTextView.innerTextField.placeholder = @"请输入密码";
    self.passwordTextView.innerTextField.returnKeyType = UIReturnKeyGo;
    self.passwordTextView.innerTextField.secureTextEntry = true;
    [self.view addSubview:self.passwordTextView];
    
    // 手机号和密码限制最大长度
    [self.mobileTextView.innerTextField bk_addEventHandler:^(UITextField *sender) {
        NSString *text = sender.text;
        if ([text length] > 11) {
            NSString *newText = [text substringToIndex:11];
            self.mobileTextView.innerTextField.text = newText;
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

- (void)_initLoginButton {
    
    UIImage *loginBg = [UMSAppConfiguration imageWithBundleResource:@"ums_login_bg"];
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.size = loginBg.size;
    self.loginButton.centerX = self.view.frame.size.width / 2.0;
    self.loginButton.top = self.passwordTextView.bottom + 30.0;
    self.loginButton.titleLabel.font = BTKFONT_SIZED(16.0);
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setBackgroundImage:loginBg forState:UIControlStateNormal];
    [self.view addSubview:self.loginButton];
    
    [self.loginButton bk_addEventHandler:^(id sender) {
        [self _handleLoginEvent];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_initRegisterButton {
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.size = self.loginButton.size;
    registerButton.centerX = self.view.frame.size.width / 2.0;
    registerButton.top = self.loginButton.bottom + 20.0;
    registerButton.layer.masksToBounds = YES;
    registerButton.layer.cornerRadius = registerButton.size.height / 2.0;
    registerButton.layer.borderWidth = 1.0;
    registerButton.layer.borderColor = TT_RED_COLOR.CGColor;
    registerButton.titleLabel.font = BTKFONT_SIZED(16.0);
    [registerButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.view addSubview:registerButton];
    
    [registerButton bk_addEventHandler:^(id sender) {
        UMSRegisterViewBoard *registerViewBoard = [UMSRegisterViewBoard new];
        [self.navigationController pushViewController:registerViewBoard animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_initResetPasswordButton {
    UIButton *resetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    resetPasswordButton.backgroundColor = [UIColor clearColor];
    resetPasswordButton.size = CGSizeMake(84.0, 32.0);
    resetPasswordButton.centerX = self.view.frame.size.width / 2.0;
    resetPasswordButton.bottom = self.view.frame.size.height - (20.0 + BTK_NAVIBAR_HEIGHT + BTK_SAFE_BOTTOM);
    resetPasswordButton.titleLabel.font = BTKFONT_SIZED(defRestPasswordTextHeight);
    [resetPasswordButton setTitleColor:[UIColor colorWithHexString:@"#f36250"] forState:UIControlStateNormal];
    [resetPasswordButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.view addSubview:resetPasswordButton];
    [resetPasswordButton bk_addEventHandler:^(id sender) {
        UMSResetPasswordViewBoard *resetPasswordBoard = [UMSResetPasswordViewBoard new];
        [self.navigationController pushViewController:resetPasswordBoard animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_handleLoginEvent {
    
    NSString *phone = self.mobileTextView.text;
    NSString *password = self.passwordTextView.text;
    
    if ([phone length] == 0) {
        [self showError:@"请输入手机号码"];
        return;
    }
    if ([phone length] != 11 || ![phone isMobileNumber]) {
        [self showError:@"请输入正确的手机号码"];
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
    
    [UMSSDK loginWithPhone:phone password:password result:^(UMSUser *user, NSError *error) {
        
        if (self.loginHandler) {
            self.loginHandler(error);
        }
        
        if (!error) {
            [self postNotification:kLoginSucceedNotification];
            // 登录成功后把手机号和密码保存到沙盒中
            [TTSandboxUtil storeUserId:@""];
            [TTSandboxUtil storePhone:phone];
            [TTSandboxUtil storePassword:password];
            [self performBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelay:0.35];
        }
        else {
            [self showError:[error why]];
        }
    }];
}

- (void)_thirdPartyLogInWithProperty:(NSString *)property {
    UMSPlatformType platform = UMSPlatformTypeUnknown;
    if ([property is:@"wechat"]) {
        platform = UMSPlatformTypeWechat;
    } else if ([property is:@"qq"]) {
        platform = UMSPlatformTypeQQ;
    } else if ([property is:@"weibo"]) {
        platform = UMSPlatformTypeSinaWeibo;
    }
    if (platform != UMSPlatformTypeUnknown) {
        [UMSSDK loginWithPlatformType:platform result:^(UMSUser *user, NSError *error) {
            if (!error) {
                if ([user.phone length] > 0) {
                    [UMSUser copyUserData:user];
                    // 自动登录成功后把ID保存到沙盒中
                    [TTSandboxUtil clearLoginInfo];
                    [TTSandboxUtil storeUserId:user.uid];
                    if (self.loginHandler) {
                        self.loginHandler(nil);
                    }
                    [self postNotification:kLoginSucceedNotification];
                    [self performBlock:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    } afterDelay:0.35];
                }
                else {
                    UMSPhoneBindViewBoard *phoneBindBoard = [[UMSPhoneBindViewBoard alloc] initWithTempUser:user];
                    [self.navigationController pushViewController:phoneBindBoard animated:YES];
                    phoneBindBoard.bindHandler = ^(NSError *error) {
                        if (!error) {
                            [self postNotification:kLoginSucceedNotification];
                        }
                        if (self.loginHandler) {
                            self.loginHandler(error);
                        }
                    };
                }
            }
            else {
                [self showError:[error why]];
            }
        }];
    }
}

@end
