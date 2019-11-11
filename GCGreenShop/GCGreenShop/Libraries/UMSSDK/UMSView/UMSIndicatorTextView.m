//
//  UMSIndicatorTextView.m
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/9.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import "UMSIndicatorTextView.h"

@interface UMSIndicatorTextView ()
@property (nonatomic, strong, readwrite) UITextField *innerTextField;
@property (nonatomic, assign) CGRect iconRect;
@end

static CGFloat const defTextFieldFontSize = 15.0;
static CGFloat const defTextFieldPadding = 55.0;
static CGFloat const defLineHeight = 0.8;

@implementation UMSIndicatorTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self _initDefaultUI];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    
    [super setFrame:frame];
    
    CGFloat viewHeight = self.frame.size.height;
    self.innerTextField.left = defTextFieldPadding + 8.0;
    self.innerTextField.top = 0.0;
    if (self.innerTextField.rightView) {
        self.innerTextField.width = frame.size.width - (defTextFieldPadding + 30.0);
    } else {
        self.innerTextField.width = frame.size.width - (defTextFieldPadding + 38.0);
    }
    self.innerTextField.height = frame.size.height;
    
    if (self.icon) {
        [self _calculateImageRect:self.icon by:viewHeight];
    }
    
    [self setNeedsDisplay];
}

- (void)setIcon:(UIImage *)icon {
    _icon = icon;
    CGFloat viewHeight = self.frame.size.height;
    if (viewHeight > 0) {
        [self _calculateImageRect:icon by:viewHeight];
    }
}

- (NSString *)text {
    return self.innerTextField.text;
}


#pragma mark - Default UI

- (void)_initDefaultUI {
    self.innerTextField = [UITextField new];
    self.innerTextField.backgroundColor = [UIColor clearColor];
    [self.innerTextField setTop:0.0];
    [self.innerTextField setHeight:self.frame.size.height];
    [self.innerTextField setFont:[UIFont systemFontOfSize:defTextFieldFontSize]];
    [self.innerTextField setTextColor:[UIColor colorWithHexString:@"#3c434c"]];
    [self addSubview:self.innerTextField];
    [self setNeedsDisplay];
}

- (void)_calculateImageRect:(UIImage *)icon by:(CGFloat)viewHeight {
    CGSize size = icon.size;
    CGPoint point = CGPointMake(BTK_THAT_FITS(10.0), (viewHeight - size.height) / 2.0);
    self.iconRect = CGRectMake(point.x + 3.0, point.y, size.width, size.height);
}

- (void)_drawLineInContext:(CGContextRef)context {
    CGFloat top = self.frame.size.height - defLineHeight;
    CGFloat hex = 217.0 / 255.0;
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, defLineHeight);
    CGContextSetRGBStrokeColor(context, hex, hex, hex, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, BTK_THAT_FITS(35.0), top);
    CGContextAddLineToPoint(context, self.frame.size.width - BTK_THAT_FITS(35.0), top);
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    if (rect.size.width > 0 && rect.size.height > 0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self.icon drawInRect:self.iconRect];
//        [self _drawLineInContext:context];
        [self _drawLineImageView];
        CGContextStrokePath(context);
    }
}

/** Add LineImage*/
- (void)_drawLineImageView
{
    UIImage *yellowLineImage = [UMSAppConfiguration imageWithBundleResource:@"ums_yellow_line"];
    UIImageView *yellowImage = [[UIImageView alloc] initWithImage:yellowLineImage];
    [yellowImage setTop:defTextViewHeight - yellowLineImage.size.height];
    [yellowImage setSize:CGSizeMake(self.width, yellowLineImage.size.height)];
    [self addSubview:yellowImage];
}

@end
