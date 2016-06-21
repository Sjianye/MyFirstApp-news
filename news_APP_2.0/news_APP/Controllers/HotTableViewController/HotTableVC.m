//
//  HotTableVC.m
//  news_APP
//
//  Created by qingyun on 16/6/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "HotTableVC.h"
#import "ThisPageVCHeader.h"
#import "HotNormolCell.h"
#import "SVProgressHUD.h"
#import "DetailsVC.h"
#import "SlidesDetailsVC.h"
#define BASEURL @"http://api.irecommend.ifeng.com/read.php?gv=5.2.0&av=5.2.0&uid=86665402460993"

@interface HotTableVC ()

@property (nonatomic ,strong) AFHTTPSessionManager *manager;
@property (nonatomic )                   NSInteger  pageNumber;
@property (nonatomic ,strong) NSArray              *itemArray;
@end

@implementation HotTableVC
static NSString *normalIDF = @"hotNormalCell";
static NSString *slidesIDF = @"slidesCell";

-(AFHTTPSessionManager *)manager {
    if (!_manager) {
        //创建manager对象
        _manager=[AFHTTPSessionManager manager];
        //设置网络监听
        _manager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}
//获取数据 （）
-(void)getNewsData{
    __weak typeof(self) weakSelf = self;
    [self.refreshControl endRefreshing];
    [self.manager GET:BASEURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject){
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if ( response.statusCode != 200) return ;
        NSArray *newsItems = responseObject[SSitem];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSDictionary *dict in newsItems) {
            ItemModel *SSItemModel = [ItemModel modelWithDictionary:dict];
            if ([SSItemModel.type isMemberOfClass:[NSNull class]]) {
                return;
            }
            if ([SSItemModel.type isEqualToString:@"doc"] || [SSItemModel.type isEqualToString:@"slide"]) {
                [tempArray addObject:SSItemModel];
            };
        }
        NSString *tempStr1 = ((ItemModel *)(tempArray.firstObject)).title;
        NSString *tempStr2 = ((ItemModel *)(self.itemArray.firstObject)).title;
        if ([tempStr1 isEqualToString:tempStr2]){
            self.itemArray = nil;
        }
        self.itemArray = tempArray;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableView reloadData];
            [SVProgressHUD dismiss];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败？？？%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.estimatedRowHeight = 120;
    self.navigationController.navigationBar.translucent = NO;
    //先给存放数据的数组分配内存
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    //加载数据
    [self getNewsData];
    //注册单元格(利用nib文件来注册NormalTableViewCell)
    NSString *normalNibName = NSStringFromClass([HotNormolCell class]);
    UINib *nib = [UINib nibWithNibName:normalNibName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:normalIDF];
    NSString *slidesNibName = NSStringFromClass([SlidesTableViewCell class]);
    UINib *nib1 = [UINib nibWithNibName:slidesNibName bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:slidesIDF];
    //下拉刷新
    self.refreshControl  = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(downLoadMore) forControlEvents:UIControlEventValueChanged];
    //Loading按钮
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtn setTitle:@"换一批看看" forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor colorWithRed:0.64 green:0.87 blue:0.93 alpha:1] forState:UIControlStateNormal];
    [footBtn addTarget:self action:@selector(upLoadMore) forControlEvents:UIControlEventTouchUpInside];
    
    footBtn.frame = CGRectMake(0, 0, 0, 40);
    self.tableView.tableFooterView = footBtn;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)downLoadMore{//下拉刷新
    [self getNewsData];
}
-(void)upLoadMore{//点击加载
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self getNewsData];
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemModel *itemModel = self.itemArray[indexPath.row];
    
    if ([itemModel.type isEqualToString:@"slide"]) {
        SlidesTableViewCell *slidesCell = [tableView dequeueReusableCellWithIdentifier:slidesIDF];
        slidesCell.model = itemModel;
        return slidesCell;
    }else{
        NormalTableViewCell *normalCell = [tableView dequeueReusableCellWithIdentifier:normalIDF forIndexPath:indexPath];
        normalCell.model = itemModel;
        return normalCell;
    }
}

#pragma mark - Table View Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{//选中行，压栈

    ItemModel *itemModel = self.itemArray[indexPath.row];
    if ([itemModel.type isEqualToString:@"doc"]) {
        DetailsVC *detailsVC = [DetailsVC new];
        detailsVC.itemModel = itemModel;
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
    if ([itemModel.type isEqualToString:@"slide"]) {
        SlidesDetailsVC *slideVC = [SlidesDetailsVC new];
        slideVC.itemModel = itemModel;
        [self.navigationController pushViewController:slideVC animated:YES];
    }

}

@end
