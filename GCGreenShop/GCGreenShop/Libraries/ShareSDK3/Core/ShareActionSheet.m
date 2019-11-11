//
//  ShareActionSheet.m
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "ShareActionSheet.h"

static CGFloat const defActionSheetHeight = 272.0;

@interface ShareActionSheet ()
@property (nonatomic, copy) ISSShareBlock tapBlock;
@property (nonatomic, strong) NSMutableArray<ISSActionItem *> *extraItems;
@end

#define kItemWidth    56.0
#define kItemHeight   82.0
#define kItemPadding  24.0

#define kExtraBaseTag  964

@implementation ShareActionSheet

+ (instancetype)actionSheetWithShareList:(NSArray *)shareList tappedBlock:(ISSShareBlock)tappedBlock {
    ShareActionSheet *actionSheet = [[ShareActionSheet alloc] initWithShareList:shareList];
    actionSheet.tapBlock = tappedBlock;
    return actionSheet;
}

- (instancetype)initWithShareList:(NSArray *)shareList {
    self = [super initWithContainerHeight:defActionSheetHeight];
    if (self) {
        self.extraItems = [NSMutableArray array];
        [self _configureUI];
        [self _setupShareItems:shareList];
    }
    return self;
}

- (void)addActionItem:(ISSActionItem *)item handler:(void(^)(ISSActionItem *item))handler {
    NSInteger extraItemCount = [self.extraItems count];
    CGFloat x = kLeftPadding + extraItemCount * (kItemWidth + kItemPadding);
    CGRect rect = CGRectMake(x, (defActionSheetHeight - 46.0) / 2.0 + 14.0, kItemWidth, kItemHeight);
    UIControl *itemView = [self _itemViewWithRect:rect actionItem:item];
    itemView.tag = kExtraBaseTag + extraItemCount;
    [self.containerView addSubview:itemView];
    [self.extraItems addObject:item];
    [itemView bk_addEventHandler:^(UIControl *sender) {
        if (handler) { handler(item); }
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)replaceOldItem:(ISSActionItem *)oldItem
           withNewItem:(ISSActionItem *)newItem
               handler:(void(^)(ISSActionItem *item))handler {
    
    NSInteger index = NSNotFound;
    for (int i = 0; i < [self.extraItems count]; i++) {
        ISSActionItem *item = [self.extraItems objectAtIndex:i];
        if ([oldItem.name is:item.name]) {
            index = i;
            break;
        }
    }
    if (index < [self.extraItems count]) {
        UIView *itemView = [self.containerView viewWithTag:kExtraBaseTag + index];
        UIImageView *icon = [itemView.subviews firstObject];
        if ([icon respondsToSelector:@selector(setImage:)]) {
            [icon setImage:newItem.icon];
        }
        UILabel *label = [itemView.subviews lastObject];
        if ([label respondsToSelector:@selector(setText:)]) {
            [label setText:newItem.name];
        }
    }
}


#pragma mark - UI Helpers

- (void)_configureUI {
    
    [self.containerView enableBlur:YES];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.blurTintColor = [UIColor whiteColor];
    self.containerView.blurStyle = UIViewBlurExtraLightStyle;
    self.containerView.blurTintColorIntensity = 0.5;
    
    CGFloat lineY = (defActionSheetHeight - 46.0) / 2.0;
    [self.containerView drawLineInRect:CGRectMake(kLeftPadding, lineY, self.width - kLeftPadding, 0.6)];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.size = CGSizeMake(self.width, 46.0);
    cancelButton.bottom = self.containerView.height;
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = BTKFONT_SIZED(17.0);
    [cancelButton setTitleColor:TT_BLACK_COLOR forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.containerView addSubview:cancelButton];
    [cancelButton bk_addEventHandler:^(id sender) {
        [self dismiss];
    } forControlEvents:UIControlEventTouchUpInside];
}

- (void)_setupShareItems:(NSArray *)shareList {
    
    NSMutableArray *actionItems = [NSMutableArray arrayWithCapacity:[shareList count]];
    for (NSNumber *platform in shareList) {
        SSDKPlatformType pf = [platform integerValue];
        switch (pf) {
            case SSDKPlatformTypeQQ: {
                UIImage *image = [self _imageWithName:@"sns_icon_qq"];
                [actionItems addObject:[ISSActionItem actionItemWithPlatform:pf title:@"QQ分享" image:image]];
            }
                break;
            case SSDKPlatformTypeSinaWeibo: {
                UIImage *image = [self _imageWithName:@"sns_icon_weibo"];
                [actionItems addObject:[ISSActionItem actionItemWithPlatform:pf title:@"新浪微博" image:image]];
            }
                break;
            case SSDKPlatformSubTypeWechatSession: {
                UIImage *image = [self _imageWithName:@"sns_icon_wechat"];
                [actionItems addObject:[ISSActionItem actionItemWithPlatform:pf title:@"微信分享" image:image]];
            }
                break;
            case SSDKPlatformSubTypeWechatTimeline: {
                UIImage *image = [self _imageWithName:@"sns_icon_timeline"];
                [actionItems addObject:[ISSActionItem actionItemWithPlatform:pf title:@"朋友圈" image:image]];
            }
                break;
            default:
                break;
        }
    }
    
    for (int i = 0; i < [actionItems count]; i++) {
        ISSActionItem *item = [actionItems objectAtIndex:i];
        CGFloat x = kLeftPadding + i * (kItemWidth + kItemPadding);
        CGRect rect = CGRectMake(x, 14.0, kItemWidth, kItemHeight);
        UIControl *itemView = [self _itemViewWithRect:rect actionItem:item];
        itemView.integerProperty = item.platform;
        [self.containerView addSubview:itemView];
        [itemView bk_addEventHandler:^(UIControl *sender) {
            if (self.tapBlock) {
                self.tapBlock(sender.integerProperty);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIControl *)_itemViewWithRect:(CGRect)rect actionItem:(ISSActionItem *)item {
    
    UIControl *itemView = [UIControl new];
    itemView.backgroundColor = [UIColor clearColor];
    itemView.frame = rect;
    
    UIImageView *icon = [UIImageView new];
    icon.size = CGSizeMake(rect.size.width, rect.size.width);
    icon.image = item.icon;
    [itemView addSubview:icon];
    
    UILabel *label = [UILabel new];
    label.size = CGSizeMake(rect.size.width, rect.size.height - rect.size.width);
    label.bottom = itemView.height;
    label.font = BTKFONT_SIZED(10.0);
    label.textColor = [UIColor darkGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = item.name;
    [itemView addSubview:label];
    
    return itemView;
}

- (UIImage *)_imageWithName:(NSString *)name {
    NSString *contents = [[NSBundle mainBundle] pathForResource:@"ShareSDKCore" ofType:@".bundle"];
    NSString *path = [contents stringByAppendingPathComponent:name];
    return [UIImage imageWithContentsOfFile:path];
}

@end


@implementation ISSActionItem
+ (ISSActionItem *)actionItemWithPlatform:(SSDKPlatformType)platform title:(NSString *)title image:(UIImage *)image {
    ISSActionItem *actionItem = [ISSActionItem new];
    actionItem.platform = platform;
    actionItem.name = title;
    actionItem.icon = image;
    return actionItem;
}
+ (ISSActionItem *)extraItemWithTitle:(NSString *)title image:(UIImage *)image {
    ISSActionItem *actionItem = [ISSActionItem new];
    actionItem.name = title;
    actionItem.icon = image;
    return actionItem;
}
@end
