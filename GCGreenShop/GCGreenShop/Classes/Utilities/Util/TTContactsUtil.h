//
//  TTContactsUtil.h
//  iNanjing
//
//  Created by Min Lin on 2018/4/1.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTInitialsParse) {
    TTInitialsParseFixed = 0,     // 固定26个字母
    TTInitialsParseByFirstLetter  // 根据每个名称的首字母
};

/**
 *  联系人分组管理
 */
@interface TTContactsUtil : NSObject

+ (instancetype)defaultContacts;

/**
 *  首字母的计算方式,默认为固定
 */
@property (assign, nonatomic) TTInitialsParse initialsParse;

/**
 *  导入联系人数组，输出格式化之后的联系人
 *  *注意：输入的联系人在使用该方法前需要先格式化成
 *  {@"uid": @"xx", @"username": @"xxx", @"avatar": @"xxx"}的样式
 *
 *  @param contacts          输入的联系人列表
 *  @param contactsHandler   Block输出格式化之后的联系人列表
 */
- (void)importContacts:(NSArray<UMSUser *> *)contacts contactsHandler:(void (^)(NSArray<UMSUser *> *contacts))contactsHandler;

/**
 *  获取首字母的个数
 */
- (NSUInteger)numberOfInitials;

/**
 *  获取首字母列表
 */
- (NSArray<NSString *> *)initials;

/**
 *  根据Index获取首字母
 */
- (NSString *)initialAtIndex:(NSUInteger)index;

/**
 *  根据Index获取联系人
 */
- (NSArray<UMSUser *> *)contactsForInitialAtIndex:(NSUInteger)index;

/**
 *  根据Index获取联系人的个数
 */
- (NSUInteger)numberOfContactsForInitialAtIndex:(NSUInteger)index;

/**
 *  排序
 */
- (void)sortArrayAccordingToSettings;

/**
 *  根据条件过滤
 */
- (NSArray *)filterWithText:(NSString *)text;

@end
