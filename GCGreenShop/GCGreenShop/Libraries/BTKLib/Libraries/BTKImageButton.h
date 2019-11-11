//
//  BTKImageButton.h
//  BTKLib
//
//  Created by Min Lin on 2017/12/25.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BTKImagePosition) {
    BTKImagePositionTop = 0,
    BTKImagePositionLeft,
    BTKImagePositionBottom,
    BTKImagePositionRight
};

IB_DESIGNABLE
@interface BTKImageButton : UIButton
@property (nonatomic, assign) IBInspectable CGFloat imageMargin;
@property (nonatomic, assign) IBInspectable BTKImagePosition imagePosition;
@property (nonatomic, assign) IBInspectable CGSize imageSize;    // default is image size;
@end
