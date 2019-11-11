//
//  TTTableViewPager.m
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import "TTTableViewPager.h"

@interface TTTableViewPager ()

@end

static NSUInteger const kMaxRefreshTime = 1800;  // 最大刷新时间，默认为30分钟

@implementation TTTableViewPager

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self setHasLoadData:NO];
}

- (void)setHasLoadData:(BOOL)hasLoadData {
    NSString *timeStr = nil;
    if (hasLoadData) {
        timeStr = [NSDate stringWithDate:[NSDate date] format:[NSDate ymdHmsFormat]];
    } else {
        timeStr = @"1970-01-01 00:00:00";
    }
    if ([self.title length] > 0) {
        [NSUserDefaults setObject:timeStr forKey:self.title];
    }
}

- (BOOL)hasLoadData {
    if ([self.title length] > 0) {
        NSString *timeStr = [NSUserDefaults objectForKey:self.title];
        if ([timeStr length] > 0) {
            NSDate *lastSaveTime = [NSDate dateWithString:timeStr format:[NSDate ymdHmsFormat]];
            NSTimeInterval offset = [[NSDate date] timeIntervalSinceDate:lastSaveTime];
            return (offset <= kMaxRefreshTime);
        } else {
            return NO;
        }
    }
    return NO;
}

- (void)fetchPageData {
    // TODO:
}

@end
