//
//  BTKWebViewBoard.m
//  BTKLib
//
//  Created by launching on 2017/10/12.
//  Copyright © 2017年 Min Lin. All rights reserved.
//

#import "BTKWebViewBoard.h"
#import "UIBarButtonItem+BTKLib.h"
#import "BTKMacros.h"
#import <YYKit/UIImage+YYAdd.h>

static void *BTKWebBrowserContext = &BTKWebBrowserContext;

@interface BTKWebViewBoard ()
@property (nonatomic, assign) BOOL previousNavigationControllerNavigationBarHidden;
@property (nonatomic, strong) NSTimer *fakeProgressTimer;
@property (nonatomic, assign) BOOL uiWebViewIsLoading;
@property (nonatomic, strong) NSURL *uiWebViewCurrentURL;
@end

@implementation BTKWebViewBoard

#pragma mark - Static Initializers

+ (instancetype)webBrowser {
    BTKWebViewBoard *webBrowser = [[self alloc] init];
    return webBrowser;
}

+ (UINavigationController *)navigationControllerWithWebBrowser {
    BTKWebViewBoard *webBrowser = [[self alloc] init];
    return [BTKWebViewBoard navigationControllerWithBrowser:webBrowser];
}

+ (UINavigationController *)navigationControllerWithBrowser:(BTKWebViewBoard *)webBrowser {
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:webBrowser action:@selector(doneButtonPressed:)];
    [webBrowser.navigationItem setRightBarButtonItem:doneButton];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:webBrowser];
    return navigationController;
}


#pragma mark - View Lifecycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = YES;
    self.previousNavigationControllerNavigationBarHidden = self.navigationController.navigationBarHidden;
    
    self.uiWebView = [[UIWebView alloc] init];
    [self.uiWebView setFrame:self.view.bounds];
    [self.uiWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.uiWebView setDelegate:self];
    [self.uiWebView setMultipleTouchEnabled:YES];
    [self.uiWebView setAutoresizesSubviews:YES];
    [self.uiWebView setScalesPageToFit:YES];
    [self.uiWebView.scrollView setAlwaysBounceVertical:YES];
    [self.view addSubview:self.uiWebView];
    
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    [self.progressView setTrackTintColor:[UIColor colorWithWhite:1.0f alpha:0.0f]];
    [self.progressView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height-self.progressView.frame.size.height, self.view.frame.size.width, self.progressView.frame.size.height)];
    [self.progressView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin];
    
    // 自动加载Web页
    if (self.webUrl.absoluteString.length > 0) {
        [self loadURL:self.webUrl];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 调整左侧按钮
    [self adjustLeftBarButtonItems];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:self.previousNavigationControllerNavigationBarHidden animated:animated];
    
    [self.uiWebView setDelegate:nil];
    [self.progressView removeFromSuperview];
}

- (void)adjustLeftBarButtonItems {
    
    /*
    UIBarButtonItem *fixedSpace = [UIBarButtonItem fixedSpaceItemWithWidth:-10];
    
    UIImage *backItemImage = [[UIImage imageNamed:@"backItem"] imageByTintColor:_tintColor];
    UIBarButtonItem *backBarButtonItem = [UIBarButtonItem itemWithImage:backItemImage handler:^(id sender) {
        if ([self.uiWebView canGoBack]) {
            [self.uiWebView goBack];
        } else {
            [self popBoard];
        }
    }];
    
    if ([self.uiWebView canGoBack]) {
        UIImage *closeItemImage = [[UIImage imageNamed:@"closeItem"] imageByTintColor:_tintColor];
        UIBarButtonItem *closeButtonItem = [UIBarButtonItem itemWithImage:closeItemImage handler:^(id sender) {
            [self popBoard];
        }];
        UIButton *closeButton = (UIButton *)closeButtonItem.customView;
        [closeButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        self.navigationItem.leftBarButtonItems = @[fixedSpace, backBarButtonItem, closeButtonItem];
    } else {
        self.navigationItem.leftBarButtonItems = @[fixedSpace, backBarButtonItem];
    }
     */
}


#pragma mark - Public Interface

- (void)setTintColor:(UIColor *)tintColor {
    _tintColor = tintColor;
    [self.progressView setTintColor:tintColor];
    [self.navigationController.navigationBar setTintColor:tintColor];
}

- (void)setBarTintColor:(UIColor *)barTintColor {
    _barTintColor = barTintColor;
    [self.navigationController.navigationBar setBarTintColor:barTintColor];
}

- (NSURL *)webUrl {
    return _webUrl;
}

- (void)loadRequest:(NSURLRequest *)request {
    self.webUrl = request.URL;
    [self.uiWebView loadRequest:request];
}

- (void)loadURL:(NSURL *)URL {
    [self loadRequest:[NSURLRequest requestWithURL:URL]];
}

- (void)loadURLString:(NSString *)URLString {
    NSURL *URL = [NSURL URLWithString:URLString];
    [self loadURL:URL];
}

- (void)clearCookies {
    NSHTTPCookieStorage *storage = NSHTTPCookieStorage.sharedHTTPCookieStorage;
    
    for (NSHTTPCookie *cookie in storage.cookies)
        [storage deleteCookie:cookie];
    
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void)clearURLCached {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}


#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if (![self externalAppRequiredToOpenURL:request.URL]) {
        
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(adjustLeftBarButtonItems) withObject:nil afterDelay:0.5];
        
        self.uiWebViewCurrentURL = request.URL;
        self.uiWebViewIsLoading = YES;
        [self fakeProgressViewStartLoading];
        
        if ([self.delegate respondsToSelector:@selector(webBrowser:didStartLoadingURL:)]) {
            [self.delegate webBrowser:self didStartLoadingURL:request.URL];
        }
        return YES;
    }
    else {
        return NO;
    }
    
    return NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (!self.uiWebView.isLoading) {
        self.uiWebViewIsLoading = NO;
        [self fakeProgressBarStopLoading];
    }
    
    if ([self.delegate respondsToSelector:@selector(webBrowser:didFinishLoadingURL:)]) {
        [self.delegate webBrowser:self didFinishLoadingURL:self.uiWebView.request.URL];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    if (!self.uiWebView.isLoading) {
        self.uiWebViewIsLoading = NO;
        [self fakeProgressBarStopLoading];
    }
    
    if ([self.delegate respondsToSelector:@selector(webBrowser:didFailToLoadURL:error:)]) {
        [self.delegate webBrowser:self didFailToLoadURL:self.uiWebView.request.URL error:error];
    }
}


#pragma mark - Done Button Action

- (void)doneButtonPressed:(id)sender {
    [self dismissAnimated:YES];
}


#pragma mark - Fake Progress Bar Control (UIWebView)

- (void)fakeProgressViewStartLoading {
    [self.progressView setProgress:0.0f animated:NO];
    [self.progressView setAlpha:1.0f];
    
    if (!self.fakeProgressTimer) {
        self.fakeProgressTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f/60.0f target:self selector:@selector(fakeProgressTimerDidFire:) userInfo:nil repeats:YES];
    }
}

- (void)fakeProgressBarStopLoading {
    if (self.fakeProgressTimer) {
        [self.fakeProgressTimer invalidate];
    }
    
    if (self.progressView) {
        [self.progressView setProgress:1.0f animated:YES];
        [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:0.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:0.0f animated:NO];
        }];
    }
}

- (void)fakeProgressTimerDidFire:(id)sender {
    CGFloat increment = 0.005/(self.progressView.progress + 0.2);
    if ([self.uiWebView isLoading]) {
        CGFloat progress = (self.progressView.progress < 0.75f) ? self.progressView.progress + increment : self.progressView.progress + 0.0005;
        if (self.progressView.progress < 0.95) {
            [self.progressView setProgress:progress animated:YES];
        }
    }
}

#pragma mark - External App Support

- (BOOL)externalAppRequiredToOpenURL:(NSURL *)URL {
    NSSet *validSchemes = [NSSet setWithArray:@[@"http", @"https"]];
    return ![validSchemes containsObject:URL.scheme];
}

#pragma mark - Dismiss

- (void)dismissAnimated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(webBrowserWillDismiss:)]) {
        [self.delegate webBrowserWillDismiss:self];
    }
    [self popBoard];
}

#pragma mark - Interface Orientation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (BOOL)shouldAutorotate {
    return YES;
}

@end
