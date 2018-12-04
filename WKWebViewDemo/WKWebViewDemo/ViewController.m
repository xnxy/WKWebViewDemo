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
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle]bundleURL];

    [webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    
//    NSURL *url = [NSURL URLWithString:@"……"];
//
//    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    WKUserContentController *userContentController = config.userContentController;
    
    //JS调用OC代码  添加处理脚本
    [userContentController addScriptMessageHandler:self name:@"test"];
    
    //layout
    [webView makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(300);
    }];
    
    NSLog(@"----title:%@---URL:%@---",self.webView.title,self.webView.URL);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor blueColor];
    [self.view addSubview:btn];
    
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.bottomLayoutGuide).offset(-20);
        make.width.height.equalTo(100);
    }];
    
    @weakify(self)
    [btn bk_whenTapped:^{
        @strongify(self)
        [self getDeviceInfo];
    }];
    
}

#pragma mark -
#pragma mark --- WKScriptMessageHandler ---
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"-----message:%@-----name:%@-----body:%@-----",message,message.name,message.body);
}

- (void)getDeviceInfo{

    NSDictionary *msg = @{@"msg": @"12345678"
                          };
    NSString *jsCode = [NSString stringWithFormat:@"deviceInfo('%@')", [msg yy_modelToJSONString]];
    [self.webView evaluateJavaScript:jsCode completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"response %@", response);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
