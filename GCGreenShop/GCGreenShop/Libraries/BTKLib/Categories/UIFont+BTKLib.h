//
//  UIFont+BTKLib.h
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTKSIZE_ADJUST(pointSize)                [UIFont adjustPointSize:pointSize]
#define BTKFONT_SIZED(pointSize)                 [UIFont systemFontOfSize:BTKSIZE_ADJUST(pointSize)]
#define BTKFONT_BOLD_SIZED(pointSize)            [UIFont boldSystemFontOfSize:BTKSIZE_ADJUST(pointSize)]
#define BTKFONT_NAME_SIZED(fontName, pointSize)  [UIFont fontWithName:fontName size:BTKSIZE_ADJUST(pointSize)]

@interface UIFont (BTKLib)

+ (CGFloat)adjustPointSize:(CGFloat)pointSize;

@end
