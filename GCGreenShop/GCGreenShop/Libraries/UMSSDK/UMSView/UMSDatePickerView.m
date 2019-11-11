//
//  UMSDatePickerView.m
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/14.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import "UMSDatePickerView.h"

@interface UMSDatePickerView ()
@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIDatePicker *picker;
@end

static CGFloat const kContainerHeight = 260.0;

@implementation UMSDatePickerView

- (id)initWithTitle:(NSString *)title delegate:(id<UMSDatePickerDelegate>)delegate {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.delegate = delegate;
        self.backgroundColor = [UIColor clearColor];
        [self _initSubviewsWithTitle:title];
    }
    return self;
}

- (void)_initSubviewsWithTitle:(NSString *)title {
    
    self.container = [UIView new];
    self.container.backgroundColor = [UIColor whiteColor];
    self.container.size = CGSizeMake(self.width, kContainerHeight);
    self.container.top = self.frame.size.height;
    [self.container drawLineInRect:CGRectMake(0.0, 0.0, self.container.width, 0.6)];
    [self.container drawLineInRect:CGRectMake(0.0, 44.0, self.container.width, 0.6)];
    [self addSubview:self.container];
    
    UILabel *caption = [UILabel new];
    caption.backgroundColor = [UIColor clearColor];
    caption.origin = CGPointMake(80.0, 0.0);
    caption.size = CGSizeMake(self.container.width - 160.0, 44.0);
    caption.font = BTKFONT_NAME_SIZED(@"AdobeHeitiStd-Regular", 15.0);
    caption.textColor = TT_BLACK_COLOR;
    caption.textAlignment = NSTextAlignmentCenter;
    caption.text = title;
    [self.container addSubview:caption];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor clearColor];
    cancelButton.frame = CGRectMake(10.0, 0.0, 60.0, 44.0);
    cancelButton.titleLabel.font = BTKFONT_NAME_SIZED(@"AdobeHeitiStd-Regular", 15.0);
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.container addSubview:cancelButton];
    
    UIButton *okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.backgroundColor = [UIColor clearColor];
    okButton.frame = CGRectMake(kScreenWidth - 70.0, 0.0, 60.0, 44.0);
    okButton.titleLabel.font = BTKFONT_NAME_SIZED(@"AdobeHeitiStd-Regular", 15.0);
    [okButton setTitleColor:TT_RED_COLOR forState:UIControlStateNormal];
    [okButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.container addSubview:okButton];
    
    self.picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 44.0, self.width, 216.0)];
    NSLocale *locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    self.picker.locale = locale;
    self.picker.datePickerMode = UIDatePickerModeDate;
    self.picker.date = [NSDate date];
//    self.picker.maximumDate = self.picker.date;
    self.picker.minimumDate = [NSDate dateWithString:@"1900-01-01" format:@"yyyy-MM-dd"];
    [self.container addSubview:self.picker];
    
    [cancelButton bk_addEventHandler:^(id sender) {
        [self dismissWithClickedButtonIndex:0 animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [okButton bk_addEventHandler:^(id sender) {
        [self dismissWithClickedButtonIndex:1 animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadDateWithString:(NSString *)dateStr animated:(BOOL)animated {
    if ([dateStr length] > 0) {
        NSDate *defDate = [NSDate dateWithString:dateStr format:@"yyyy-MM-dd"];
        if (defDate) {
            [self.picker setDate:defDate animated:YES];
        }
    }
}

- (void)showInView:(UIView *)view {
    
    if ([self.delegate respondsToSelector:@selector(ums_datePickerViewWillPresent:)]) {
        [self.delegate ums_datePickerViewWillPresent:self];
    }
    
    [view addSubview:self];
    [self setFrame:view.bounds];
    
    self.container.frame = CGRectMake(0, self.frame.size.height, kScreenWidth, 260);
    
    CATransition *animation = [CATransition animation];
    animation.duration = 0.35;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.type = kCATransitionPush;
    animation.subtype = kCATransitionFromTop;
    self.container.frame = CGRectMake(0, self.frame.size.height - kContainerHeight, self.width, kContainerHeight);
    [self.container.layer addAnimation:animation forKey:@"DatePickerSheet"];
}

- (NSString *)dateString {
    NSDate *date = [self.picker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
    
}


#pragma mark - private methods

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if ([self.delegate respondsToSelector:@selector(ums_datePickerViewWillDismiss:)]) {
        [self.delegate ums_datePickerViewWillDismiss:self];
    }
    
    if (animated) {
        CATransition *animation = [CATransition animation];
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionPush;
        animation.subtype = kCATransitionFromBottom;
        [self.container setAlpha:0.f];
        [self.container.layer addAnimation:animation forKey:@"DatePickerSheet"];
        [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.3];
    } else {
        [self.container setAlpha:0.f];
        [self removeFromSuperview];
    }
    
    if ([self.delegate respondsToSelector:@selector(ums_datePickerView:selectWithButtonIndex:)]) {
        [self.delegate ums_datePickerView:self selectWithButtonIndex:buttonIndex];
    }
}

@end
