//
//  UMSDatePickerView.h
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/14.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UMSDatePickerView;

@protocol UMSDatePickerDelegate <NSObject>
@optional
- (void)ums_datePickerViewWillPresent:(UMSDatePickerView *)picker;
- (void)ums_datePickerViewWillDismiss:(UMSDatePickerView *)picker;
- (void)ums_datePickerView:(UMSDatePickerView *)picker selectWithButtonIndex:(NSInteger)buttonIndex;
@end

@interface UMSDatePickerView : UIView

@property (nonatomic, weak) id<UMSDatePickerDelegate> delegate;

- (id)initWithTitle:(NSString *)title delegate:(id<UMSDatePickerDelegate>)delegate;
- (void)loadDateWithString:(NSString *)dateStr animated:(BOOL)animated;
- (NSString *)dateString;

- (void)showInView:(UIView *)view;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end
