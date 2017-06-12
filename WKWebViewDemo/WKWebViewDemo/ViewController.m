//
//  ViewController.m
//  WKWebViewDemo
//
//  Created by dev on 2017/6/12.
//  Copyright © 2017年 周伟. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController ()<WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupWeb];
    
}

- (void)setupWeb{
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    config.preferences.minimumFontSize = 18;
    
    WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
    self.webView = webView;
    [self.view addSubview:webView];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle]bundleURL];
    
    [webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
    WKUserContentController *userContentController = config.userContentController;
    
    //JS调用OC代码  添加处理脚本
    [userContentController addScriptMessageHandler:self name:@"showMobile"];
    [userContentController addScriptMessageHandler:self name:@"showName"];
    [userContentController addScriptMessageHandler:self name:@"showSendMsg"];
    
    //layout
    [webView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(300);
    }];
    
    NSLog(@"----title:%@---URL:%@---",self.webView.title,self.webView.URL);
    
}

#pragma mark -
#pragma mark --- WKScriptMessageHandler ---
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"-----message:%@-----name:%@-----body:%@-----",message,message.name,message.body);
    
    if ([message.name isEqualToString:@"showMobile"]) {
        
    }
    
    if ([message.name isEqualToString:@"showName"]) {
        
    }
    
    if ([message.name isEqualToString:@"showSendMsg"]) {
        
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
