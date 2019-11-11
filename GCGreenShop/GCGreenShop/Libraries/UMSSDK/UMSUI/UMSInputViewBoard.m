//
//  UMSInputViewBoard.m
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSInputViewBoard.h"

@interface UMSInputViewBoard ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation UMSInputViewBoard

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initSaveBarButtonItem];
    [self _initSubviews];
}

- (void)setDefInputText:(NSString *)defInputText {
    _defInputText = defInputText;
    [self.textField setText:defInputText];
}

- (void)setPlaceholderText:(NSString *)placeholderText {
    _placeholderText = placeholderText;
    [self.textField setPlaceholder:placeholderText];
}


#pragma mark - UI Helpers

- (void)_initSaveBarButtonItem {
    UIBarButtonItem *saveBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"保存" style:UIBarButtonItemStylePlain handler:^(id sender) {
        NSString *text = [self.textField.text stringByTrim];
        if ([text length] > 0) {
            if ([self.title is:@"昵称"] && [text length] > 11) {
                [self showError:@"昵称不能超过11位~"];
            } else {
                if (self.doneEditHandler) {
                    self.doneEditHandler(self.textField.text);
                }
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    self.navigationItem.rightBarButtonItem = saveBarButtonItem;
}

- (void)_initSubviews {
    
    UIView *backgView = [UIView new];
    backgView.backgroundColor = [UIColor whiteColor];
    backgView.top = 14.0;
    backgView.size = CGSizeMake(self.view.width, 48.0);
    [self.view addSubview:backgView];
    
    self.textField = [UITextField new];
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.top = backgView.top;
    self.textField.left = 10.0;
    self.textField.size = CGSizeMake(self.view.width - 20.0, 48.0);
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.font = BTKFONT_SIZED(15.0);
    self.textField.textColor = TT_BLACK_COLOR;
    self.textField.placeholder = self.placeholderText;
    self.textField.text = self.defInputText;
    [self.view addSubview:self.textField];
}

@end
