//
//  GuidePage.m
//  news_APP
//
//  Created by qingyun on 16/5/13.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "GuidePage.h"
#import "AppDelegate.h"
#define GuideImagesCount 5
#define MyScreenW [UIScreen mainScreen].bounds.size.width
#define MyScreenH [UIScreen mainScreen].bounds.size.height


@interface GuidePage ()
@property (nonatomic ,strong)NSArray *imageNames;

@end

@implementation GuidePage
#pragma mark -GuideImagePath懒加载
-(NSArray *)imageNames{
    NSMutableArray *mutArray = [NSMutableArray array];
    if (_imageNames == nil) {
        for (int i = 0 ; i < GuideImagesCount; i ++) {
            NSString *imageName = [NSString stringWithFormat:@"guide_%02d",i];
            NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
            [mutArray addObject:path];
        }
        _imageNames = mutArray;
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addScrollView];
    
    
}
#pragma mark -添加轮播视图
-(void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(MyScreenW * GuideImagesCount, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    for (int i =0 ; i < GuideImagesCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MyScreenW * i, 0, MyScreenW, MyScreenH)];
        [imageView setImage:[UIImage imageNamed:self.imageNames[i]]];
        [scrollView addSubview:imageView];
        if (i == GuideImagesCount - 1) {
            CGFloat btnWidth = 120;
            CGFloat btnHeight = 40;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(((MyScreenW - btnWidth) / 2),MyScreenH * 9 / 10, btnWidth, btnHeight)];
            [btn setBackgroundImage:[UIImage imageNamed:@"Guidebtn"] forState:UIControlStateNormal];
            [btn setTitle:@"开启全新之旅" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            imageView.userInteractionEnabled = YES;
            [imageView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        }
    }
}
#pragma mark -btn点击事件
-(void)btnClick{
    UITabBarController *MainTabBar = [[UITabBarController alloc] init];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = MainTabBar;
    
//获取版本号 （写入版本号，确保下次进入程序不会再次进入引导页）
//    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
//
//    [[NSUserDefaults standardUserDefaults] setObject:version forKey:@"app_version"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
