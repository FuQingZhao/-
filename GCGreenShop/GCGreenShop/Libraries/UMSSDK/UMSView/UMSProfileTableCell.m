//
//  UMSProfileTableCell.m
//  PRJ_JINTAN
//
//  Created by Min Lin on 2017/12/10.
//  Copyright © 2017年 com.jsbc. All rights reserved.
//

#import "UMSProfileTableCell.h"
#import "UMSAvatar.h"

@interface UMSProfileTableCell ()
@property (nonatomic, strong) UILabel *detailTitleLabel;
@property (nonatomic, strong) UIImageView *avatarView;
@end

static CGFloat const defTextFieldPadding = 15.0;
static CGFloat const defLineHeight = 0.6;

@implementation UMSProfileTableCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _setDefaultUI];
    }
    return self;
}

- (void)configureDetailWithObject:(NSDictionary *)obj {
    
    NSString *name = [obj objectForKey:kPROTitleField];
    UMSProfileCellStyle style = [[obj objectForKey:kPROTableCellType] integerValue];
    id value = [obj objectForKey:kPROValueField];
    
    self.textLabel.text = name;
    
    if (style == UMSProfileCellStyleNormal) {
        [self.detailTitleLabel setText:(NSString *)value];
    }
    else if (style == UMSProfileCellStyleWithAvatar) {
        if ([value isKindOfClass:[NSString class]]) {
            if ([value containsString:@"http://"] || [value containsString:@"https://"]) {
                [UMSAvatar middleAvatarWithURL:[NSURL URLWithString:value] placeholder:nil block:^(UIImage *image, NSError *error) {
                    if (image && !error) {
                        [self.avatarView setImage:image];
                    } else {
                        [self.avatarView setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_border_avatar"]];
                    }
                }];
            } else {
                [self.avatarView setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_border_avatar"]];
            }
        }
        else if ([value isKindOfClass:[NSURL class]]) {
            [UMSAvatar middleAvatarWithURL:[NSURL URLWithString:value] placeholder:nil block:^(UIImage *image, NSError *error) {
                if (image && !error) {
                    [self.avatarView setImage:image];
                } else {
                    [self.avatarView setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_border_avatar"]];
                }
            }];
        }
        else if ([value isKindOfClass:[UIImage class]]) {
            [self.avatarView setImage:(UIImage *)value];
        }
        else {
            [self.avatarView setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_border_avatar"]];
        }
    }
    
    [self _layoutSubviewsWithStyle:style];
}

- (void)_layoutSubviewsWithStyle:(UMSProfileCellStyle)style {
    
    if (style == UMSProfileCellStyleNormal) {
        self.avatarView.hidden = YES;
        self.detailTitleLabel.hidden = NO;
        CGFloat textW = [self.detailTitleLabel.text sizeWithFont:self.detailTitleLabel.font constrainedToWidth:kScreenWidth * 0.7].width;
        self.detailTitleLabel.size = CGSizeMake(textW, defProfileNormalHeight);
        self.detailTitleLabel.right = kScreenWidth - 20.0;
    }
    else if (style == UMSProfileCellStyleWithAvatar) {
        self.avatarView.hidden = NO;
        self.detailTitleLabel.hidden = YES;
        self.avatarView.size = CGSizeMake(46.0, 46.0);
        self.avatarView.right = kScreenWidth - 20.0;
        self.avatarView.centerY = defProfileAvatarHeight / 2.0;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (rect.size.width > 0 && rect.size.height > 0 && self.linePadding >= 0.0) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self _drawLineInContext:context];
        CGContextStrokePath(context);
    }
}


#pragma mark - Default UI

- (void)_setDefaultUI {
    
    self.avatarView = [UIImageView new];
    self.avatarView.backgroundColor = [UIColor clearColor];
    self.avatarView.size = CGSizeMake(46.0, 46.0);
    [self.avatarView setImage:[UMSAppConfiguration imageWithBundleResource:@"ums_border_avatar"]];
    [self.contentView addSubview:self.avatarView];
    
    self.detailTitleLabel = [UILabel new];
    self.detailTitleLabel.backgroundColor = [UIColor clearColor];
    self.detailTitleLabel.size = CGSizeMake(90.0, defProfileNormalHeight);
    self.detailTitleLabel.font = BTKFONT_NAME_SIZED(@"AdobeHeitiStd-Regular", 15.0);
    self.detailTitleLabel.textColor = TT_BLACK_COLOR;
    [self.contentView addSubview:self.detailTitleLabel];
    
    self.avatarView.hidden = YES;
    self.detailTitleLabel.hidden = YES;
}

- (void)_drawLineInContext:(CGContextRef)context {
    CGFloat top = self.frame.size.height - defLineHeight;
    CGFloat hex = 217.0 / 255.0;
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetLineWidth(context, defLineHeight);
    CGContextSetRGBStrokeColor(context, hex, hex, hex, 1.0);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, defTextFieldPadding, top);
    CGContextAddLineToPoint(context, self.frame.size.width, top);
}

@end
