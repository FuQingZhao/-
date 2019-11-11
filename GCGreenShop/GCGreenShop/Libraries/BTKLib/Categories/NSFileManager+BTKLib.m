//
//  NSFileManager+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSFileManager+BTKLib.h"

@implementation NSFileManager (BTKLib)

+ (NSString *)appPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)docPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libPrefPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libCachePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/tmp"];
}

+ (NSArray *)pathsForItemsMatchingExtension:(NSString *)ext inFolder:(NSString *)folder {
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:folder];
    while ((file = [dirEnum nextObject])) {
        if ([[file pathExtension] caseInsensitiveCompare:ext] == NSOrderedSame) {
            [results addObject:[folder stringByAppendingPathComponent:file]];
        }
    }
    return results;
}

+ (NSArray *)pathsForDocumentsMatchingExtension:(NSString *)ext {
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSFileManager docPath]];
}

+ (NSArray *)pathsForTmpsMatchingExtension:(NSString *)ext {
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSFileManager tmpPath]];
}

+ (NSArray *)pathsForCachesMatchingExtension:(NSString *)ext {
    return [NSFileManager pathsForItemsMatchingExtension:ext inFolder:[NSFileManager libCachePath]];
}

+ (NSArray *)filesInFolder:(NSString *)folder {
    NSString *file;
    NSMutableArray *results = [NSMutableArray array];
    NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:folder];
    while ((file = [dirEnum nextObject])) {
        BOOL isDir;
        [[NSFileManager defaultManager] fileExistsAtPath:[folder stringByAppendingPathComponent:file] isDirectory:&isDir];
        if (!isDir) [results addObject:file];
    }
    return results;
}

+ (NSString *)pathForDocumentDirectoryFile:(NSString *)file {
    return [[NSFileManager docPath] stringByAppendingPathComponent:file];
}

+ (NSString *)pathForTemporaryFile:(NSString *)file {
    return [[NSFileManager tmpPath] stringByAppendingPathComponent:file];
}

+ (NSString *)pathForCacheFile:(NSString *)file {
    return [[NSFileManager libCachePath] stringByAppendingPathComponent:file];
}

+ (NSString *)pathForDocumentDirectoryFile:(NSString *)file ofType:(NSString *)fileType {
    return [[[NSFileManager docPath] stringByAppendingPathComponent:file] stringByAppendingPathExtension:fileType];
}

+ (NSString *)pathForTemporaryFile:(NSString *)file ofType:(NSString *)fileType {
    return [[[NSFileManager tmpPath] stringByAppendingPathComponent:file] stringByAppendingPathExtension:fileType];
}

+ (NSString *)pathForCacheFile:(NSString *)file ofType:(NSString *)fileType {
    return [[[NSFileManager libCachePath] stringByAppendingPathComponent:file] stringByAppendingPathExtension:fileType];
}

+ (BOOL)touch:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDirectory]) {
        if (isDirectory) {
            return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
        } else {
            return [fileManager createFileAtPath:path contents:nil attributes:nil];
        }
    }
    return YES;
}

+ (double)availableDiskSpace {
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:[NSFileManager docPath] error:nil];
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

@end
