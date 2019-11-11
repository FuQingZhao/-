//
//  NSRunLoop+BTKLib.h
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const NSRunloopTimeoutException;

@interface NSRunLoop (BTKLib)

/**
 extension of NSRunLoop for waiting(Defaults is 10).
 */
- (void)performBlockAndWait:(void (^)(BOOL *finish))block;

/**
 extension of NSRunLoop for waiting.
 */
- (void)performBlockAndWait:(void (^)(BOOL *finish))block timeoutInterval:(NSTimeInterval)timeoutInterval;

@end
