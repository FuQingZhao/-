//
//  NSFileManager+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (BTKLib)

+ (NSString *)appPath;        // 程序目录，不能存任何东西
+ (NSString *)docPath;        // 文档目录，需要ITUNES同步备份的数据存这里
+ (NSString *)libPrefPath;    // 配置目录，配置文件存这里
+ (NSString *)libCachePath;    // 缓存目录，系统永远不会删除这里的文件，ITUNES会删除
+ (NSString *)tmpPath;        // 缓存目录，APP退出后，系统可能会删除这里的内容

+ (NSArray *)pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)folder;
+ (NSArray *)pathsForDocumentsMatchingExtension:(NSString *)ext;
+ (NSArray *)pathsForTmpsMatchingExtension:(NSString *)ext;
+ (NSArray *)pathsForCachesMatchingExtension:(NSString *)ext;
+ (NSArray *)filesInFolder:(NSString *)folder;

+ (NSString *)pathForDocumentDirectoryFile:(NSString *)file;
+ (NSString *)pathForTemporaryFile:(NSString *)file;
+ (NSString *)pathForCacheFile:(NSString *)file;

+ (NSString *)pathForDocumentDirectoryFile:(NSString *)file ofType:(NSString *)fileType;
+ (NSString *)pathForTemporaryFile:(NSString *)file ofType:(NSString *)fileType;
+ (NSString *)pathForCacheFile:(NSString *)file ofType:(NSString *)fileType;

// 创建文件或者目录
+ (BOOL)touch:(NSString *)path;

// 磁盘可用空间
+ (double)availableDiskSpace;

@end
