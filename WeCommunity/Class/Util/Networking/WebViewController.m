//
//  WebViewController.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController


- (void)loadView
{
    UIView *view = [[UIView alloc] init];
    
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    [view addSubview:self.webView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // Since self.webView is also a UIScrollView, if self.automaticallyAdjustsScrollViewInsets were allowed to do its normal thing then the webview would resize accordingly - but we want to you adjust it manually so we're forcing it to always be NO.
    
    self.view = view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]]];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.webView.frame = self.view.frame;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // TODO: Set the contentInset property of the webview to the appropriate insets based on the presence of top and bottom bars.
    
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.topLayoutGuide.length, 0, self.bottomLayoutGuide.length, 0);
    self.webView.scrollView.contentOffset = CGPointMake(0, -self.topLayoutGuide.length);
    // TODO: Set the contentOffset property to adjust for the top padding added above
    
}

@end
