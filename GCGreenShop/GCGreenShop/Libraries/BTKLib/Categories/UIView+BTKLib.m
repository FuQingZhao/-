//
//  UIView+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "UIView+BTKLib.h"

@implementation UIView (BTKLib)

- (CALayer *)drawLineInRect:(CGRect)rect tintColor:(UIColor *)tintColor {
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = rect;
    lineLayer.name = @"LineLayer";
    lineLayer.backgroundColor = tintColor.CGColor;
    [self.layer addSublayer:lineLayer];
    return lineLayer;
}

- (CALayer *)drawLineInRect:(CGRect)rect {
    return [self drawLineInRect:rect tintColor:RGB(227.0, 227.0, 227.0)];
}

- (void)undrawLine {
    [self.layer.sublayers enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CALayer *layer = (CALayer *)obj;
        if ([layer.name is:@"LineLayer"]) {
            *stop = YES;
        }
        if (*stop == YES) {
            [layer removeFromSuperlayer];
        }
    }];
}


#pragma mark - DrawRect

- (void)drawLineInContext:(CGContextRef)context edgeInsets:(UIEdgeInsets)insets {
    CGFloat hex = 217.0 / 255.0;
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, kDefaultLineThick);
    CGContextSetRGBStrokeColor(context, hex, hex, hex, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, insets.left, insets.top);
    CGContextAddLineToPoint(context, self.frame.size.width - insets.right, insets.top);
}

- (void)drawLineWithEdgeInsets:(UIEdgeInsets)insets {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawLineInContext:context edgeInsets:insets];
    CGContextStrokePath(context);
}

- (void)drawLineInContext:(CGContextRef)context withHeight:(CGFloat)height {
    CGFloat hex = 237.0 / 255.0;
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, 10.0);
    CGContextSetRGBStrokeColor(context, hex, hex, hex, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0.0, 0.0);
    CGContextAddLineToPoint(context, self.frame.size.width, 0.0);
}

- (void)drawLineWithHeight:(CGFloat)height {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawLineInContext:context withHeight:height];
    CGContextStrokePath(context);
}

@end
