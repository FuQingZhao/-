//
//  BTKImageButton.m
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKImageButton.h"

static inline NSString * NSStringFromImagePosition(BTKImagePosition position) {
    switch (position) {
        case BTKImagePositionTop:
            return @"Top";
            break;
        case BTKImagePositionLeft:
            return @"Left";
            break;
        case BTKImagePositionRight:
            return @"Right";
            break;
        case BTKImagePositionBottom:
            return @"Bottom";
            break;
        default:
            break;
    }
    return @"Unknown";
}

@implementation BTKImageButton

@synthesize imageSize = _imageSize;

- (void)commonInit {
    self.autoresizesSubviews = NO;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (CGSize)imageSize {
    if (CGSizeEqualToSize(_imageSize, CGSizeZero)) {
        return [super imageRectForContentRect:CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX)].size;
    }
    if (self.currentImage)
        return _imageSize;
    return CGSizeZero;
}

- (CGSize)titleSize {
    CGSize size = CGSizeZero;
    if (self.currentAttributedTitle) {
        size = [self.currentAttributedTitle size];
    }
    else if (self.currentTitle) {
        size = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    }
    return size;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    
    CGSize size = [super titleRectForContentRect:CGRectMake(0, 0, CGFLOAT_MAX, CGFLOAT_MAX)].size;
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentFill) {
        size.height = MIN(size.height, CGRectGetHeight(contentRect));
    }
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill) {
        size.width = MIN(size.width, CGRectGetWidth(contentRect));
    };
    
    CGSize iconSize = self.imageSize;
    CGFloat margin = self.imageMargin;
    if (CGSizeEqualToSize(iconSize, CGSizeZero)) {
        margin = 0;
    }
    CGFloat totalWidth = size.width + iconSize.width + margin;
    CGFloat totalHeight = size.height + iconSize.height + margin;
    CGRect rect = {{0, 0}, size};
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + totalWidth - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - totalWidth;
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
        default:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - totalWidth) / 2;
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + CGRectGetWidth(contentRect) - (CGRectGetWidth(contentRect) - totalWidth) / 2 - size.width;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
    }
    
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect) + totalHeight - size.height;
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - totalHeight;
                    break;
                default:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentFill:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
        default:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - (CGRectGetHeight(contentRect) - totalHeight) / 2 - size.height;
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - totalHeight) / 2;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
    }
    return CGRectIntegral(rect);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    
    CGSize size = self.imageSize;
    if (self.contentVerticalAlignment == UIControlContentVerticalAlignmentFill) {
        size.height = MIN(size.height, CGRectGetHeight(contentRect));
    }
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentFill) {
        size.width = MIN(size.width, CGRectGetWidth(contentRect));
    };
    
    CGSize titleSize = [self titleSize];
    CGFloat margin = self.imageMargin;
    if (CGSizeEqualToSize(titleSize, CGSizeZero)) {
        margin = 0;
    }
    
    switch (_imagePosition) {
        case BTKImagePositionTop:
        case BTKImagePositionBottom:
            size.height = MAX(MIN(CGRectGetHeight(contentRect) - margin - titleSize.height, size.height), size.height);
            break;
        default:
            size.width = MAX(MIN(CGRectGetWidth(contentRect) - margin - titleSize.width, size.width), size.width);
            break;
    }
    
    CGFloat totalWidth = size.width + titleSize.width + margin;
    CGFloat totalHeight = size.height + titleSize.height + margin;
    CGRect rect = {{0, 0}, size};
    switch (self.contentHorizontalAlignment) {
        case UIControlContentHorizontalAlignmentLeft:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + totalWidth - size.width;
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentRight:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMaxX(contentRect) - totalWidth;
                    break;
                default:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
            }
            break;
        case UIControlContentHorizontalAlignmentFill:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMaxX(contentRect) - size.width;
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect);
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
        default:
            switch (_imagePosition) {
                case BTKImagePositionRight:
                    rect.origin.x = CGRectGetMinX(contentRect) + CGRectGetWidth(contentRect) - (CGRectGetWidth(contentRect) - totalWidth) / 2 - size.width;
                    break;
                case BTKImagePositionLeft:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - totalWidth) / 2;
                    break;
                default:
                    rect.origin.x = CGRectGetMinX(contentRect) + (CGRectGetWidth(contentRect) - size.width) / 2;
                    break;
            }
            break;
    }
    
    switch (self.contentVerticalAlignment) {
        case UIControlContentVerticalAlignmentTop:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMinY(contentRect) + totalHeight - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentBottom:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMaxY(contentRect) - totalHeight;
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
            }
            break;
        case UIControlContentVerticalAlignmentFill:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect);
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
        default:
            switch (_imagePosition) {
                case BTKImagePositionTop:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - totalHeight) / 2;
                    break;
                case BTKImagePositionBottom:
                    rect.origin.y = CGRectGetMaxY(contentRect) - (CGRectGetHeight(contentRect) - totalHeight) / 2 - size.height;
                    break;
                default:
                    rect.origin.y = CGRectGetMinY(contentRect) + (CGRectGetHeight(contentRect) - size.height) / 2;
                    break;
            }
            break;
    }
    
    return rect;
}

- (void)setImageSize:(CGSize)imageSize {
    if (!CGSizeEqualToSize(_imageSize, imageSize)) {
        _imageSize = imageSize;
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (void)setImageMargin:(CGFloat)imageMargin {
    if (_imageMargin != imageMargin) {
        _imageMargin = imageMargin;
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (void)setImagePosition:(BTKImagePosition)imagePosition {
    if (_imagePosition != imagePosition) {
        _imagePosition = imagePosition;
        [self invalidateIntrinsicContentSize];
        [self setNeedsLayout];
    }
}

- (void)setEnabled:(BOOL)enabled {
    super.enabled = enabled;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setSelected:(BOOL)selected {
    super.selected = selected;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setHighlighted:(BOOL)highlighted {
    super.highlighted = highlighted;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setContentVerticalAlignment:(UIControlContentVerticalAlignment)contentVerticalAlignment {
    super.contentVerticalAlignment = contentVerticalAlignment;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setContentHorizontalAlignment:(UIControlContentHorizontalAlignment)contentHorizontalAlignment {
    super.contentHorizontalAlignment = contentHorizontalAlignment;
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
    [super setAttributedTitle:title forState:state];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
    [super setImage:image forState:state];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
    [super setContentEdgeInsets:contentEdgeInsets];
    [self invalidateIntrinsicContentSize];
    [self setNeedsLayout];
}

- (CGSize)intrinsicContentSize {
    
    UIEdgeInsets contentInsets = self.contentEdgeInsets;
    
    CGSize titleSize = [self titleSize];
    CGSize imageSize = self.imageSize;
    CGFloat margin = self.imageMargin;
    if (CGSizeEqualToSize(imageSize, CGSizeZero) || CGSizeEqualToSize(titleSize, CGSizeZero)) {
        margin = 0;
    }
    
    CGSize size = {0, 0};
    switch (_imagePosition) {
        case BTKImagePositionTop:
        case BTKImagePositionBottom:
            size = CGSizeMake(MAX(titleSize.width, imageSize.width) + contentInsets.left + contentInsets.right,
                              titleSize.height + imageSize.height + margin + contentInsets.top + contentInsets.bottom);
            
            break;
        default:
            size = CGSizeMake(titleSize.width + imageSize.width + margin + contentInsets.left + contentInsets.right,
                              MAX(titleSize.height, imageSize.height) + contentInsets.top + contentInsets.bottom);
            break;
    }
    return CGRectIntegral((CGRect){{0, 0}, size}).size;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return [self intrinsicContentSize];
}

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"<%@: %p; frame = %@; icon margin = %.6f; icon position = %@; icon size = %@>", NSStringFromClass(self.class), self, NSStringFromCGRect(self.frame), self.imageMargin, NSStringFromImagePosition(self.imagePosition), NSStringFromCGSize(self.imageSize)];
}

@end
