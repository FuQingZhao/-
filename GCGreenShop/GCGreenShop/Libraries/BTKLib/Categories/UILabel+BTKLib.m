//
//  UILabel+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "UILabel+BTKLib.h"
#import <objc/runtime.h>

@interface UILabel ()
@property (nonatomic) UILongPressGestureRecognizer *longPressGestureRecognizer;
@end

@implementation UILabel (BTKLib)

- (UILabel *(^)(NSTextAlignment))btk_TextAlignment {
    return ^(NSTextAlignment textAlignment) {
        self.textAlignment = textAlignment;
        return self;
    };
}

- (UILabel *(^)(UIColor *))btk_BackgroundColor {
    return ^(UIColor *backgroundColor) {
        self.backgroundColor = backgroundColor;
        return self;
    };
}

- (UILabel *(^)(UIColor *))btk_TextColor {
    return ^(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}

- (UILabel *(^)(NSString *))btk_Text {
    return ^(NSString *text) {
        self.text = text;
        return self;
    };
}

- (UILabel *(^)(float))btk_FontSize {
    return ^(float fontSize) {
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

- (UILabel *(^)(CGRect))btk_Rect {
    return ^(CGRect frame) {
        self.frame = frame;
        return self;
    };
}

- (UILabel *(^)(UIView *))btk_AddToSuperView {
    return ^(UIView *view) {
        [view addSubview:self];
        return self;
    };
}


#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder {
    return self.copyingEnabled;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    // Only return YES for the copy: action AND the copyingEnabled property is YES.
    return (action == @selector(copy:) && self.copyingEnabled);
}

- (void)copy:(id)sender {
    if (self.copyingEnabled) {
        // Copy the label text
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.text];
    }
}


#pragma mark - UI Actions

- (void)longPressGestureRecognized:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer == self.longPressGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
            [self becomeFirstResponder];
            UIMenuController *copyMenu = [UIMenuController sharedMenuController];
            [copyMenu setTargetRect:self.bounds inView:self];
            copyMenu.arrowDirection = UIMenuControllerArrowDefault;
            [copyMenu setMenuVisible:YES animated:YES];
        }
    }
}


#pragma mark - Properties

- (BOOL)copyingEnabled {
    return [objc_getAssociatedObject(self, @selector(copyingEnabled)) boolValue];
}

- (void)setCopyingEnabled:(BOOL)copyingEnabled {
    if (self.copyingEnabled != copyingEnabled) {
        objc_setAssociatedObject(self, @selector(copyingEnabled), @(copyingEnabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setupGestureRecognizers];
    }
}

- (UILongPressGestureRecognizer *)longPressGestureRecognizer {
    return objc_getAssociatedObject(self, @selector(longPressGestureRecognizer));
}

- (void)setLongPressGestureRecognizer:(UILongPressGestureRecognizer *)longPressGestureRecognizer {
    objc_setAssociatedObject(self, @selector(longPressGestureRecognizer), longPressGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)shouldUseLongPressGestureRecognizer {
    NSNumber *value = objc_getAssociatedObject(self, @selector(shouldUseLongPressGestureRecognizer));
    if (value == nil) {
        // Set the default value
        value = @YES;
        objc_setAssociatedObject(self, @selector(shouldUseLongPressGestureRecognizer), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return [value boolValue];
}

- (void)setShouldUseLongPressGestureRecognizer:(BOOL)useGestureRecognizer {
    if (self.shouldUseLongPressGestureRecognizer != useGestureRecognizer) {
        objc_setAssociatedObject(self, @selector(shouldUseLongPressGestureRecognizer), @(useGestureRecognizer), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self setupGestureRecognizers];
    }
}


#pragma mark - Private Methods

- (void)setupGestureRecognizers {
    
    // Remove gesture recognizer
    if (self.longPressGestureRecognizer) {
        [self removeGestureRecognizer:self.longPressGestureRecognizer];
        self.longPressGestureRecognizer = nil;
    }
    
    if (self.shouldUseLongPressGestureRecognizer && self.copyingEnabled) {
        self.userInteractionEnabled = YES;
        // Enable gesture recognizer
        self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
        [self addGestureRecognizer:self.longPressGestureRecognizer];
    }
}

@end
