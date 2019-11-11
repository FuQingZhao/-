//
//  TTRouterUtil.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTRouterUtil : NSObject

+ (void)routeToBoardWithPresentingBoard:(UIViewController *)presentingViewBoard dataId:(NSInteger)dataId withinType:(NSInteger)type;

@end
