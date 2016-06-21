//
//  SlidesDetailsVC.m
//  news_APP
//
//  Created by qingyun on 16/6/14.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "SlidesDetailsVC.h"
#import "ThisPageVCHeader.h"
#import "Masonry.h"

#define screenW [UIScreen mainScreen].bounds.size.width


@interface SlidesDetailsVC ()<UIScrollViewDelegate>

@property (strong, nonatomic)  UIScrollView *scrollView;
@property (nonatomic,strong)AFHTTPSessionManager *manager;
@property (nonatomic,strong) NSArray *slidesArray;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *currentLabel;

@end

@implementation SlidesDetailsVC

-(AFHTTPSessionManager *)manager{//懒加载AFHTTPSessionManager
    if (_manager == nil) {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"application/json",nil];
        _manager = manager;
    }
    return _manager;
}
-(UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _scrollView;
}
-(UILabel *)titleLabel{
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.textColor = [UIColor greenColor];
        _titleLabel = titleLabel;
        
    }
    return _titleLabel;
}
-(UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor whiteColor];
        contentLabel.font = [UIFont systemFontOfSize:13];
        contentLabel.numberOfLines = 0 ;
        _contentLabel = contentLabel;
    }
    return _contentLabel;
}
-(UILabel *)currentLabel{
    if (_currentLabel == nil) {
        UILabel *currentLabel = [[UILabel alloc] init];
        currentLabel.textColor = [UIColor whiteColor];
        _currentLabel = currentLabel;
    }
    return _currentLabel;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadDocType];
    self.view.backgroundColor = [UIColor blackColor];
    self.scrollView.delegate = self;
    [self.view addSubview:self.scrollView];
    [self scrollViewreload];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
    UISwipeGestureRecognizer *upGesture = [[UISwipeGestureRecognizer alloc] init];
    [upGesture addTarget:self action:@selector(upGestureAction)];
    upGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:upGesture];
    
    UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc] init];
    [downGesture addTarget:self action:@selector(downGestureAction)];
    downGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:downGesture];
}
-(void)upGestureAction{//上滑手势
    __weak SlidesDetailsVC *weekSelf = self;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.5 animations:^{
        
        weekSelf.scrollView.alpha = 0.2;
        [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//标题
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-400);
        }];
        [_contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//内容
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-60);
            make.top.mas_equalTo(weekSelf.view.mas_bottom).with.offset(-395);
            
        }];
        [_currentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//索引
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.left.mas_equalTo(8);
            make.bottom.mas_equalTo(weekSelf.view.mas_bottom).with.offset(-400);
        }];
        [weekSelf.view layoutIfNeeded]; // Called on parent view
    }];
}
-(void)downGestureAction{//下滑手势
    __weak SlidesDetailsVC *weekSelf = self;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.8 animations:^{
        weekSelf.scrollView.alpha = 1.0;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//标题
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-80);
        }];
        [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//内容
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(-60);
            make.top.mas_equalTo(weekSelf.view.mas_bottom).with.offset(-75);
        }];
        [self.currentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//索引
            make.left.mas_equalTo(8);
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.top.mas_equalTo(weekSelf.view.mas_bottom).with.offset(-100);
        }];
        [weekSelf.view layoutIfNeeded]; // Called on parent view
    }];
}
-(void)backClick{//点击返回
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = NO;
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)scrollViewreload{//给_scrollView添加imageView
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.scrollView.autoresizesSubviews = NO;
    self.scrollView.contentSize = CGSizeMake((MyScreenW * (self.slidesArray.count)), MyScreenH);
    
    self.scrollView.pagingEnabled = YES;
    for (int i = 0; i < self.slidesArray.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView  sd_setImageWithURL:[NSURL URLWithString:_slidesArray[i][@"image"]] placeholderImage:nil];
        NSString *imageUrl = self.slidesArray[i][@"image"];//网页链接内有_w和_h,取出数值,求出宽高比
        NSRange rangeW = [imageUrl rangeOfString:@"_w"];
        NSRange rangeH = [imageUrl rangeOfString:@"_h"];
        CGFloat imageViewH ;
        if (rangeW.location > 200 && rangeH.location > 200) {
            imageViewH = 400;
        }else{
            NSString *widthStr = [imageUrl substringWithRange:NSMakeRange(rangeW.location + 2, 4)];
            NSString *heightStr = [imageUrl substringWithRange:NSMakeRange(rangeH.location + 2, 4)];
            CGFloat aspectRatio = [heightStr floatValue] / [widthStr floatValue];
            imageViewH = SelfWidth * aspectRatio;
        }
        imageView.contentMode = UIViewContentModeScaleToFill;
        [self.scrollView addSubview:imageView];//根据宽高比设置imageView的约束
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(-30);
            make.width.mas_equalTo(MyScreenW);
            make.height.mas_equalTo(imageViewH);//1，锁定横屏  2，scrollView偏移有BUG
            make.left.mas_equalTo(MyScreenW * i);
        }];
        [self.scrollView addSubview:imageView];
    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"back_btn"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {//返回btn
        make.right.mas_equalTo(-5);
        make.bottom.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(60, 45));
    }];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    self.titleLabel.numberOfLines = 0;///////////换行
    self.titleLabel.text = _slidesArray[0][@"title"];
    self.contentLabel.text = _slidesArray[0][@"description"];
    self.currentLabel.text =[NSString stringWithFormat:@"%d/%d",1,_slidesArray.count];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.contentLabel];
    [self.view  addSubview:self.currentLabel];
    __weak SlidesDetailsVC *weekSelf = self;
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//标题
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-80);
    }];
    [self.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//内容
        make.left.mas_equalTo(50);
        make.right.mas_equalTo(-60);
        make.top.mas_equalTo(weekSelf.view.mas_bottom).with.offset(-75);
    }];
    [self.currentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {//索引
        make.left.mas_equalTo(8);
        make.size.mas_equalTo(CGSizeMake(50, 30));
        make.top.mas_equalTo(weekSelf.view.mas_bottom).with.offset(-100);
    }];

}


-(void)reloadDocType{//slides类型的新闻
    __weak  SlidesDetailsVC *weakSelf = self;
    [self.manager GET:self.itemModel.hotLink parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
        if (httpResponse.statusCode == 200) {
            NSArray *slidesArray = responseObject[@"body"][@"slides"];
            if (slidesArray) {
                _slidesArray = slidesArray;
                [weakSelf scrollViewreload];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--->%@",error);
    }];
}

#pragma mark -ScrollViewDelaget

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{//监听ScrollView的偏移量,计算索引
    
    NSInteger currentIndex = scrollView.contentOffset.x / MyScreenW;
    if (currentIndex == 0) {
        self.titleLabel.text = _slidesArray[currentIndex][@"title"];
    }else{
        self.titleLabel.text = @"";
    }
    self.contentLabel.text = _slidesArray[currentIndex][@"description"];
    self.currentLabel.text =[NSString stringWithFormat:@"%d/%d",currentIndex + 1,_slidesArray.count];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
