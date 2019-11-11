//
//  TTWebView.h
//  QQCircle
//
//  Created by Min Lin on 2018/3/7.
//  Copyright © 2018年 Min Lin. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface TTWebView : WKWebView
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *progressView;
@end
