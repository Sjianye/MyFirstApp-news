//
//  NewsPageViewController.m
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsPageViewController.h"
#import "NewsTableViewController.h"
#import "MyNewsCollectionView.h"
#import "Masonry.h"
#import "TextModel.h"
@interface NewsPageViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (nonatomic ,strong) MyNewsCollectionView *newsCollectionView; //头部滑动collectionView
@property (nonatomic ,strong) NSArray *array;                           //模拟头部数据
@property (nonatomic ,strong) NewsTableViewController * tableViewController;//内容tableVC

@property (nonatomic ,strong) NSArray *linshiModels;

@end

@implementation NewsPageViewController
//懒加载导航头部数据
-(NSArray *)linshiModels{
    if (!_linshiModels) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *muAttay = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            TextModel *model = [TextModel modelWithDictionary:dic];
            [muAttay addObject:model];
        }
        _linshiModels = muAttay;
    }
    return _linshiModels;
}
-(NSArray *)array{
    if (!_array) {
        _array = @[@"头条",@"郑州",@"黑科技",@"互联网",@"娱乐",@"社会",@"国际",@"智能设备",@"历史",@"体育",@"星座",@"内涵图",@"段子",@"游戏"];
        
    }
    return _array;
}
//懒加载newsCollectionView
-(MyNewsCollectionView *)newsCollectionView{
    if (_newsCollectionView == nil) {
        _newsCollectionView = [MyNewsCollectionView titleCollectionViewWithTitles:self.array];
        __weak NewsPageViewController *weakSelf = self;
        _newsCollectionView.changeContentVC = ^(NSUInteger index){
            //更改内容控制器
            [weakSelf changeContentViewControllerWithIndex:index];
        };
    }
    
    return _newsCollectionView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;       //设置 pageViewController的数据源和代理
    self.dataSource = self;
    NewsTableViewController *contentVC = [self viewControllerWithIndex:0];  //
    [self setViewControllers:@[contentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    self.navigationItem.titleView = self.newsCollectionView;   //设置导航栏
    [_newsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    self.navigationController.navigationBar.translucent = NO;


}
//根据选中的栏目的索引来更改内容控制器
-(void)changeContentViewControllerWithIndex:(NSUInteger)index{
    //1.获取当前控制器的type在titles中的索引currentIndex
    NewsTableViewController *currentTBVC = self.viewControllers.firstObject;
    NSUInteger currentIndex = [self indexOfViewController:currentTBVC];
    //2.currentIndex == index,return;
    if (currentIndex == index) {
        return;
    }
    //3.根据index获取对应的内容控制器,然后设置内容控制器
    NewsTableViewController *willChangedVC = [self viewControllerWithIndex:index];
    [self setViewControllers:@[willChangedVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}
//根据索引获取内容控制器
-(NewsTableViewController *)viewControllerWithIndex:(NSUInteger)index{
    if (self.array.count == 0 || index >= self.array.count) {
        return nil;
    }
    
    NewsTableViewController *tableVC = [[NewsTableViewController alloc] initWithStyle:UITableViewStylePlain];
    tableVC.type = self.array[index];                      //给tableVC传入 类型
    [tableVC setValue:self.linshiModels forKey:@"array"];  //再次给tableVC传入一遍数据
    return tableVC;
}
//获取当前控制器的type在titles中的索引currentIndex
-(NSUInteger)indexOfViewController:(NewsTableViewController *)vc{
    return [self.array indexOfObject:vc.type];
}
#pragma mark  -UIPageViewControllerDataSource
//上一个内容控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSUInteger currentIndex = [self indexOfViewController:(NewsTableViewController *)viewController];
    if (currentIndex == 0) {
        return nil;
    }
    currentIndex -= 1;
    //根据currentIndex获取上一个内容控制器
    return [self viewControllerWithIndex:currentIndex];
}

//下一个内容控制器
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    //获取当前控制器的type在titles中的索引currentIndex
    NSUInteger currentIndex = [self indexOfViewController:(NewsTableViewController *)viewController];
    currentIndex++;
    if (currentIndex >= self.array.count) {
        return nil;
    }
    //根据currentIndex获取下一个内容控制器
    return [self viewControllerWithIndex:currentIndex];
}
#pragma mark -UIPageViewControllerDelegate
//结束过渡动画
-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    //1.获取当前控制器的type在titles中的索引currentIndex
    NewsTableViewController *currentDataVC = self.viewControllers.firstObject;
    NSUInteger currentIndex = [self indexOfViewController:currentDataVC];
    
    //2.获取上一个内容控制器的type在titles中的索引previousIndex
    NSUInteger previousIndex = [self indexOfViewController:(NewsTableViewController *)previousViewControllers.firstObject];
    //3.判断currentIndex != previousIndex,设置_newsCollectionView的currentIndex等于currentIndex
    if (currentIndex != previousIndex) {
        _newsCollectionView.currentIndex = currentIndex;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
