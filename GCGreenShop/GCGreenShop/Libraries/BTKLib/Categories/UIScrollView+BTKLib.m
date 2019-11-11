//
//  UIScrollView+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/10.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "UIScrollView+BTKLib.h"

@implementation UIScrollView (BTKLib)

- (CGFloat)contentWidth {
    return self.contentSize.width;
}

- (void)setContentWidth:(CGFloat)width {
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}

- (CGFloat)contentHeight {
    return self.contentSize.height;
}

- (void)setContentHeight:(CGFloat)height {
    self.contentSize = CGSizeMake(self.frame.size.width, height);
}

- (CGFloat)contentOffsetX {
    return self.contentOffset.x;
}

- (void)setContentOffsetX:(CGFloat)x {
    self.contentOffset = CGPointMake(x, self.contentOffset.y);
}

- (CGFloat)contentOffsetY {
    return self.contentOffset.y;
}

- (void)setContentOffsetY:(CGFloat)y {
    self.contentOffset = CGPointMake(self.contentOffset.x, y);
}

- (CGPoint)topContentOffset {
    return CGPointMake(0.0f, -self.contentInset.top);
}

- (CGPoint)bottomContentOffset {
    return CGPointMake(0.0f, self.contentSize.height + self.contentInset.bottom - self.bounds.size.height);
}

- (CGPoint)leftContentOffset {
    return CGPointMake(-self.contentInset.left, 0.0f);
}

- (CGPoint)rightContentOffset {
    return CGPointMake(self.contentSize.width + self.contentInset.right - self.bounds.size.width, 0.0f);
}

- (BTKScrollDirection)scrollDirection {
    BTKScrollDirection direction;
    if ([self.panGestureRecognizer translationInView:self.superview].y > 0.0f) {
        direction = BTKScrollDirectionUp;
    } else if ([self.panGestureRecognizer translationInView:self.superview].y < 0.0f) {
        direction = BTKScrollDirectionDown;
    } else if ([self.panGestureRecognizer translationInView:self].x < 0.0f) {
        direction = BTKScrollDirectionLeft;
    } else if ([self.panGestureRecognizer translationInView:self].x > 0.0f) {
        direction = BTKScrollDirectionRight;
    } else {
        direction = BTKScrollDirectionWTF;
    }
    return direction;
}

- (BOOL)isScrolledToTop {
    return self.contentOffset.y <= [self topContentOffset].y;
}

- (BOOL)isScrolledToBottom {
    return self.contentOffset.y >= [self bottomContentOffset].y;
}

- (BOOL)isScrolledToLeft {
    return self.contentOffset.x <= [self leftContentOffset].x;
}

- (BOOL)isScrolledToRight {
    return self.contentOffset.x >= [self rightContentOffset].x;
}

- (void)scrollToTopAnimated:(BOOL)animated {
    [self setContentOffset:[self topContentOffset] animated:animated];
}

- (void)scrollToBottomAnimated:(BOOL)animated {
    [self setContentOffset:[self bottomContentOffset] animated:animated];
}

- (void)scrollToLeftAnimated:(BOOL)animated {
    [self setContentOffset:[self leftContentOffset] animated:animated];
}

- (void)scrollToRightAnimated:(BOOL)animated {
    [self setContentOffset:[self rightContentOffset] animated:animated];
}

- (NSUInteger)verticalPageIndex {
    return (self.contentOffset.y + (self.frame.size.height * 0.5f)) / self.frame.size.height;
}

- (NSUInteger)horizontalPageIndex {
    return (self.contentOffset.x + (self.frame.size.width * 0.5f)) / self.frame.size.width;
}

- (void)scrollToVerticalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(0.0f, self.frame.size.height * pageIndex) animated:animated];
}

- (void)scrollToHorizontalPageIndex:(NSUInteger)pageIndex animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.frame.size.width * pageIndex, 0.0f) animated:animated];
}

- (NSInteger)pages {
    NSInteger pages = self.contentSize.width / self.frame.size.width;
    return pages;
}

- (NSInteger)currentPage {
    NSInteger pages = self.contentSize.width / self.frame.size.width;
    CGFloat scrollPercent = [self scrollPercent];
    NSInteger currentPage = (NSInteger)roundf((pages - 1) * scrollPercent);
    return currentPage;
}

- (CGFloat)scrollPercent {
    CGFloat width = self.contentSize.width - self.frame.size.width;
    CGFloat scrollPercent = self.contentOffset.x / width;
    return scrollPercent;
}

- (CGFloat)pagesY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat contentHeight = self.contentSize.height;
    return contentHeight / pageHeight;
}

- (CGFloat)pagesX {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat contentWidth = self.contentSize.width;
    return contentWidth / pageWidth;
}

- (CGFloat)currentPageY {
    CGFloat pageHeight = self.frame.size.height;
    CGFloat offsetY = self.contentOffset.y;
    return offsetY / pageHeight;
}

- (CGFloat)currentPageX {
    CGFloat pageWidth = self.frame.size.width;
    CGFloat offsetX = self.contentOffset.x;
    return offsetX / pageWidth;
}

@end
