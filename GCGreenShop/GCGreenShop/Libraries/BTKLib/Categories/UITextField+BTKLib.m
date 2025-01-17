//
//  UITextField+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "UITextField+BTKLib.h"
#import <objc/runtime.h>

#define X(view) (view.frame.origin.x)
#define Y(view) (view.frame.origin.y)
#define W(view) (view.frame.size.width)
#define H(view) (view.frame.size.height)

static char kTextFieldIdentifyKey;
static char kTextFieldHistoryviewIdentifyKey;

#define ANIMATION_DURATION 0.3f
#define ITEM_HEIGHT 40
#define CLEAR_BUTTON_HEIGHT 45
#define MAX_HEIGHT 300

@interface UITextField ()
@property (retain, nonatomic) UITableView *historyTableView;
@end

@implementation UITextField (BTKLib)

- (void)setLeftPadding:(CGFloat)leftPadding {
    UIView *paddingView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, leftPadding, self.frame.size.height)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (CGFloat)leftPadding {
    return self.leftView ? self.leftView.frame.size.width : 0;
}

- (NSString *)identify {
    return objc_getAssociatedObject(self, &kTextFieldIdentifyKey);
}

- (void)setIdentify:(NSString *)identify {
    objc_setAssociatedObject(self, &kTextFieldIdentifyKey, identify, OBJC_ASSOCIATION_RETAIN);
}

- (UITableView *)historyTableView {
    UITableView *table = objc_getAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey);
    if (table == nil) {
        table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITextFieldHistoryCell"];
        table.layer.borderColor = [UIColor grayColor].CGColor;
        table.layer.borderWidth = 1;
        table.delegate = (id)self;
        table.dataSource = (id)self;
        objc_setAssociatedObject(self, &kTextFieldHistoryviewIdentifyKey, table, OBJC_ASSOCIATION_RETAIN);
    }
    return table;
}

- (NSArray *)loadHistroy {
    if (self.identify == nil) {
        return nil;
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [def objectForKey:@"UITextField+History"];
    if (dic != nil) {
        return [dic objectForKey:self.identify];
    }
    return nil;
}

- (void)synchronize {
    if (self.identify == nil || [self.text length] == 0) {
        return;
    }
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [def objectForKey:@"UITextField+History"];
    NSArray *history = [dic objectForKey:self.identify];
    
    NSMutableArray *newHistory = [NSMutableArray arrayWithArray:history];
    
    __block BOOL haveSameRecord = false;
    __weak typeof(self) weakSelf = self;
    
    [newHistory enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(NSString *)obj isEqualToString:weakSelf.text]) {
            *stop = true;
            haveSameRecord = true;
        }
    }];
    
    if (haveSameRecord) {
        return;
    }
    
    [newHistory addObject:self.text];
    
    NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:newHistory forKey:self.identify];
    
    [def setObject:dic2 forKey:@"UITextField+History"];
    [def synchronize];
}

- (void)showHistory {
    NSArray *history = [self loadHistroy];
    
    if (self.historyTableView.superview != nil || history == nil || history.count == 0) {
        return;
    }
    
    CGRect frame1 = CGRectMake(X(self), Y(self) + H(self) + 1, W(self), 1);
    CGRect frame2 = CGRectMake(X(self), Y(self) + H(self) + 1, W(self), MIN(MAX_HEIGHT, ITEM_HEIGHT * history.count + CLEAR_BUTTON_HEIGHT));
    
    self.historyTableView.frame = frame1;
    
    [self.superview addSubview:self.historyTableView];
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.historyTableView.frame = frame2;
    }];
}

- (void)clearHistoryButtonClick:(UIButton *)button {
    [self clearHistory];
    [self hideHistroy];
}

- (void)hideHistroy {
    if (self.historyTableView.superview == nil) {
        return;
    }
    
    CGRect frame1 = CGRectMake(X(self), Y(self) + H(self) + 1, W(self), 1);
    
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        self.historyTableView.frame = frame1;
    } completion:^(BOOL finished) {
        [self.historyTableView removeFromSuperview];
    }];
}

- (void)clearHistory {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:nil forKey:@"UITextField+History"];
    [def synchronize];
}


#pragma mark - 数据代理

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self loadHistroy] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"UITextFieldHistoryCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITextFieldHistoryCell"];
    }
    cell.textLabel.text = [self loadHistroy][indexPath.row];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIButton* clearButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(clearHistoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return clearButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ITEM_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CLEAR_BUTTON_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.text = [self loadHistroy][indexPath.row];
    [self hideHistroy];
}


- (NSRange)selectedRange {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextRange *selectedRange = self.selectedTextRange;
    UITextPosition *selectionStart = selectedRange.start;
    UITextPosition *selectionEnd = selectedRange.end;
    NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    return NSMakeRange(location, length);
}

@end
