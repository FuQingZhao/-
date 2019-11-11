//
//  BTKWebViewBoard.h
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKViewBoard.h"
#import <WebKit/WebKit.h>

@class BTKWebViewBoard;

@interface UINavigationController (BTKWebViewBoard)
- (BTKWebViewBoard *)rootWebBrowser;
@end

@protocol BTKWebBrowserDelegate <NSObject>
@optional
- (void)webBrowser:(BTKWebViewBoard *)webBrowser didStartLoadingURL:(NSURL *)URL;
- (void)webBrowser:(BTKWebViewBoard *)webBrowser didFinishLoadingURL:(NSURL *)URL;
- (void)webBrowser:(BTKWebViewBoard *)webBrowser didFailToLoadURL:(NSURL *)URL error:(NSError *)error;
- (void)webBrowserWillDismiss:(BTKWebViewBoard *)webBrowser;
@end

@interface BTKWebViewBoard : BTKViewBoard <WKNavigationDelegate, WKUIDelegate, UIWebViewDelegate>

#pragma mark - Public Properties

@property (nonatomic, weak) id <BTKWebBrowserDelegate> delegate;

// The main and only UIProgressView
@property (nonatomic, strong) UIProgressView *progressView;

// The web views
// Depending on the version of iOS, one of these will be set
@property (nonatomic, strong) UIWebView *uiWebView;

//
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *barTintColor;

@property (nonatomic, strong) NSURL *webUrl;


#pragma mark - Static Initializers

/*
 Initialize a basic KINWebBrowserViewController instance for push onto navigation stack
 
 Ideal for use with UINavigationController pushViewController:animated: or initWithRootViewController:
 
 Optionally specify KINWebBrowser options or WKWebConfiguration
 */
+ (instancetype)webBrowser;

/*
 Initialize a UINavigationController with a KINWebBrowserViewController for modal presentation.
 
 Ideal for use with presentViewController:animated:
 
 Optionally specify KINWebBrowser options or WKWebConfiguration
 */
+ (UINavigationController *)navigationControllerWithWebBrowser;


#pragma mark - Public Interface

// Load a NSURLURLRequest to web view
// Can be called any time after initialization
- (void)loadRequest:(NSURLRequest *)request;

// Load a NSURL to web view
// Can be called any time after initialization
- (void)loadURL:(NSURL *)URL;

// Loads a URL as NSString to web view
// Can be called any time after initialization
- (void)loadURLString:(NSString *)URLString;

// Clear WebView Cookies
- (void)clearCookies;

// Clear WebView Cached
- (void)clearURLCached;

@end
