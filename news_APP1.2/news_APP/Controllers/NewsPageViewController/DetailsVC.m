//
//  DetailsVC.m
//  news_APP
//
//  Created by qingyun on 16/6/12.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "DetailsVC.h"
#import "AFNetworking.h"
//#import "ItemModel.h"

@interface DetailsVC ()<UIWebViewDelegate>

@property (nonatomic,strong)UIWebView *newsWebview;//选中行页面的webVIew
@property (nonatomic,strong)AFHTTPSessionManager *manager;

@end

@implementation DetailsVC


-(UIWebView *)newsWebview{
    if (_newsWebview == nil) {
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        UIWebView *webView = [[UIWebView alloc] init];
        _newsWebview = webView;
    }
    return _newsWebview;
}
-(AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",nil];
        _manager = manager;
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    
    self.newsWebview.frame = [UIScreen mainScreen].bounds;
    CGRect customFrame = self.newsWebview.frame;
    customFrame.size.height -= 113;
    self.newsWebview.frame = customFrame;
    [self.view addSubview:self.newsWebview];
    self.newsWebview.backgroundColor = [UIColor grayColor];
    //self.newsWebview.scalesPageToFit = YES;//网页适应屏幕大小,但字体会很小
    self.newsWebview.delegate = self;
    
    [self reloadDocType];
    
}
-(void)reloadDocType{//doc类型的新闻
    [self.manager GET:self.itemModel.hotLink parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            NSString *textStr = responseObject[@"body"][@"text"];
            textStr = [textStr stringByReplacingOccurrencesOfString:@"凤凰" withString:@"新鲜"];
            if (textStr) {
                [self.newsWebview loadHTMLString:textStr baseURL:nil];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--->%@",error);
    }];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{//调整UIwebView的大小适应屏幕
//    [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body') [0].style.webkitTextSizeAdjust= '120%'"];//修改百分比即可修改字体大小
    NSString *js = @"function imgAutoFit() { \
    var imgs = document.getElementsByTagName('img'); \
    for (var i = 0; i < imgs.length; ++i) {\
    var img = imgs[i];   \
    img.style.maxWidth = %f;   \
    } \
    }";
    js = [NSString stringWithFormat:js, [UIScreen mainScreen].bounds.size.width - 20];
    
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"imgAutoFit()"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
