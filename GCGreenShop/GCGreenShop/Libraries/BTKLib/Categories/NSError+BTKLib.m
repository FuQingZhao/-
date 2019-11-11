//
//  NSError+BTKLib.m
//  TTReader
//
//  Created by Min Lin on 2018/1/5.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "NSError+BTKLib.h"

static NSString const *kLCErrorDomain = @"com.btk.error";
static NSInteger const kLCErrorCode = -1;

@implementation NSError (BTKLib)

+ (NSError *)errorWhy:(NSString *)why suggestion:(NSString *)suggestion {
    NSMutableDictionary *userInfo = [NSMutableDictionary new];
    [userInfo setValue:why forKey:NSLocalizedDescriptionKey];
    if ([suggestion length] > 0) {
        [userInfo setValue:suggestion forKey:NSLocalizedRecoverySuggestionErrorKey];
    }
    NSError *error = [NSError errorWithDomain:(NSErrorDomain)kLCErrorDomain code:kLCErrorCode userInfo:userInfo];
    return error;
}

+ (NSError *)errorWhy:(NSString *)why {
    return [NSError errorWhy:why suggestion:nil];
}


#pragma mark - Properties

- (NSString *)why {
    return [self.userInfo objectForKey:NSLocalizedDescriptionKey];
}

- (NSString *)suggestion {
    return [self.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
}

@end
