//
//  UMSInputViewBoard.h
//  UMSSDK
//
//  Created by Min Lin on 2017/12/7.
//  Copyright © 2017年 jsbc. All rights reserved.
//

#import "UMSBaseViewBoard.h"

@interface UMSInputViewBoard : UMSBaseViewBoard

/**
 保存信息回调
 */
@property (nonatomic, copy) void (^doneEditHandler) (NSString *text);

@property (nonatomic, copy) NSString *defInputText;
@property (nonatomic, copy) NSString *placeholderText;

@end
