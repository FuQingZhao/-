//
//  NSHTTPCookieStorage+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPCookieStorage (BTKLib)

/**
 存储cookies到磁盘目录
 */
- (void)save;

/**
 从磁盘目录读取cookies
 */
- (void)load;

@end
