//
//  NSError+BTKLib.h
//  TTReader
//
//  Created by Min Lin on 2018/1/5.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (BTKLib)

@property (nonatomic, copy, readonly) NSString *why;
@property (nonatomic, copy, readonly) NSString *suggestion;

+ (NSError *)errorWhy:(NSString *)why suggestion:(NSString *)suggestion;
+ (NSError *)errorWhy:(NSString *)why;

@end
