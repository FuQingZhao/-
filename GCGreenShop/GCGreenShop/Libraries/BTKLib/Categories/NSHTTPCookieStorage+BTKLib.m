//
//  NSHTTPCookieStorage+BTKLib.m
//  BTKLib
//
//  Created by launching on 2017/10/9.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "NSHTTPCookieStorage+BTKLib.h"

@implementation NSHTTPCookieStorage (BTKLib)

- (void)save {
    
    NSMutableArray *cookieData = [NSMutableArray new];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in [cookieStorage cookies]) {
        NSMutableDictionary* cookieDictionary = [NSMutableDictionary new];
        cookieDictionary[NSHTTPCookieName] = cookie.name;
        cookieDictionary[NSHTTPCookieValue] = cookie.value;
        cookieDictionary[NSHTTPCookieDomain] = cookie.domain;
        cookieDictionary[NSHTTPCookiePath] = cookie.path;
        cookieDictionary[NSHTTPCookieSecure] = (cookie.isSecure ? @"YES" : @"NO");
        cookieDictionary[NSHTTPCookieVersion] = [NSString stringWithFormat:@"%zd", cookie.version];
        if (cookie.expiresDate) {
            cookieDictionary[NSHTTPCookieExpires] = cookie.expiresDate;
        }
        [cookieData addObject:cookieDictionary];
    }
    
    [cookieData writeToFile:[self storagePath] atomically:TRUE];
}

- (void)load {
    NSMutableArray *cookies = [NSMutableArray arrayWithContentsOfFile:[self storagePath]];
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSDictionary *cookieData in cookies) {
        [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:cookieData]];
    }
}

- (NSString *)storagePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/Cookies.data", paths[0]];
}

@end
