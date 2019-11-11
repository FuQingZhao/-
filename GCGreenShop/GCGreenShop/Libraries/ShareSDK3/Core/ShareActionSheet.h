//
//  ShareActionSheet.h
//  iNanjing
//
//  Created by LinMin on 2018/3/29.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "TTBasePopupView.h"
#import <ShareSDK/SSDKTypeDefine.h>

@class ISSActionItem;

typedef void(^ISSShareBlock) (SSDKPlatformType platformType);

@interface ShareActionSheet : TTBasePopupView

- (instancetype)initWithShareList:(NSArray *)shareList;
+ (instancetype)actionSheetWithShareList:(NSArray *)shareList tappedBlock:(ISSShareBlock)tappedBlock;

/**
 添加其他选项
 */
- (void)addActionItem:(ISSActionItem *)item handler:(void(^)(ISSActionItem *item))handler;

/**
 修改指定选项
 */
- (void)replaceOldItem:(ISSActionItem *)oldItem
           withNewItem:(ISSActionItem *)newItem
               handler:(void(^)(ISSActionItem *item))handler;

@end


/**
 分享选项
 */
@interface ISSActionItem : NSObject
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) SSDKPlatformType platform;
@property (nonatomic, assign) BOOL support;  // 是否收藏
+ (ISSActionItem *)actionItemWithPlatform:(SSDKPlatformType)platform title:(NSString *)title image:(UIImage *)image;
+ (ISSActionItem *)extraItemWithTitle:(NSString *)title image:(UIImage *)image;
@end
