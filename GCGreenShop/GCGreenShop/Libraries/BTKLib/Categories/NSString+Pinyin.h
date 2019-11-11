//
//  NSString+Pinyin.h
//  Snowball
//
//  Created by croath on 11/11/13.
//  Copyright (c) 2013 Snowball. All rights reserved.
//
// https://github.com/croath/NSString-Pinyin
//  the Chinese Pinyin string of the nsstring

#import <Foundation/Foundation.h>

@interface NSString (Pinyin)

/**
 *  将汉字转换为带音标的拼音
 */
- (NSString *)pinyinWithPhoneticSymbol;

/**
 *  将汉字转换为不带音标的拼音
 */
- (NSString *)pinyin;

/**
 *  将中文转换为不带音标的拼音数组
 */
- (NSArray *)pinyinArray;

/**
 *  将中文转换为不带音标的一串拼音
 */
- (NSString *)pinyinWithoutBlank;

/**
 *  将每个汉字的转化为拼音的首字母
 */
- (NSArray *)pinyinInitialsArray;

/**
 *  将每个汉字的转化为首字母
 */
- (NSString *)pinyinInitialsString;

/**
 *  将每个词组转换为拼音首字母
 */
- (NSString *)firstCharactor;

@end
