//
//  UIWebView+BTKLib.h
//  BTKLib
//
//  Created by launching on 16/10/8.
//  Copyright © 2016年 launching. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (BTKLib)

#pragma mark -
#pragma mark 获取网页中的数据

/// 获取某个标签的结点个数
- (int)nodeCountOfTag:(NSString *)tag;

/// 获取当前页面URL
- (NSString *)getCurrentURL;

/// 获取标题
- (NSString *)getTitle;
/// 获取图片
- (NSArray *)getImgs;

/// 获取当前页面所有链接
- (NSArray *)getOnClicks;

/// 获取网页meta信息
- (NSArray *)getMetaData;

#pragma mark -
#pragma mark 改变网页样式和行为

/// 改变背景颜色
- (void)setBackgroundColor:(UIColor *)color;

/// 为所有图片添加点击事件(网页中有些图片添加无效)
- (void)addClickEventOnImg;

/// 改变所有图像的宽度
- (void)setImgWidth:(int)size;

/// 改变所有图像的高度
- (void)setImgHeight:(int)size;

/// 改变指定标签的字体颜色
- (void)setFontColor:(UIColor *) color withTag:(NSString *)tagName;

/// 改变指定标签的字体大小
- (void)setFontSize:(int) size withTag:(NSString *)tagName;

#pragma mark -
#pragma mark 改变WebView控件的样式

/// 是否显示阴影
- (void)setShadowViewHidden:(BOOL)b;

/// 是否显示水平滑动指示器
- (void)setShowsHorizontalScrollIndicator:(BOOL)b;

/// 是否显示垂直滑动指示器
- (void)setShowsVerticalScrollIndicator:(BOOL)b;

/// 使网页透明
- (void)makeTransparent;

/// 网页透明移除+阴影
- (void)makeTransparentAndRemoveShadow;

@end
