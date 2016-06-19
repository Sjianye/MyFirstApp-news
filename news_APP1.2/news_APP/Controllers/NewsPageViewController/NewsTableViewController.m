//
//  qTableViewController.m
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ThisPageVCHeader.h"
#import "DetailsVC.h"
#import "SlidesDetailsVC.h"
@interface NewsTableViewController ()

@property (nonatomic)        NSInteger newsPage; // 标题的页码
@property (nonatomic ,strong)AFHTTPSessionManager *manager;
@property (nonatomic ,strong)NSMutableArray *itemArray;    //新闻数组(内部为itemModel模型)
@property (nonatomic ,strong)NSMutableArray *focusArray;   //头部滚动视图数据
@property (nonatomic ,assign)NSInteger pageNumber;
@end

@implementation NewsTableViewController

static NSString *normalIDF = @"normalCell";
static NSString *slidesIDF = @"slidesCell";

#pragma -mark AFHTTPSessionManager 从网络请求数据
-(AFHTTPSessionManager *)manager {
    if (!_manager) {
        //创建manager对象
        _manager=[AFHTTPSessionManager manager];
        //设置网络监听
        _manager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
//        __weak AFNetworkReachabilityManager *reachManager=_manager.reachabilityManager;
//        //设置监听回调函数
//        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//            //显示监听状态
//            NSLog(@"=====当前网络状态=%@",[reachManager localizedNetworkReachabilityStatusString]);
//        }];
        //启动监听
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}
//获取数据 （）
-(void)getNewsData:(NSDictionary *)page{
    __weak typeof(self) weakSelf = self;
    [self.refreshControl endRefreshing];
    [self.manager GET:_newsUrlsKey parameters:page progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if ( response.statusCode != 200) return ;
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSArray *newsItems = (NSArray *)responseObject;
            NSMutableArray *tempArray = [NSMutableArray array];
            NSMutableArray *tempArray1 = [NSMutableArray array];
            NSInteger responsePage = [responseObject[0][@"currentPage"] integerValue];
            if (responsePage != _pageNumber) return ;
            for (NSDictionary *dict in newsItems) {
                if ([dict[SStype] isEqualToString:@"list"]) {
                    NSArray *items = dict[SSitem];
                    for (NSDictionary *NewsItem in items) {
                        ItemModel *SSItemModel = [ItemModel modelWithDictionary:NewsItem];
                        if ([SSItemModel.type isMemberOfClass:[NSNull class]]) {
                            return;
                        }
                        if ([SSItemModel.type isEqualToString:@"doc"] || [SSItemModel.type isEqualToString:@"slide"]) {
                            [tempArray addObject:SSItemModel];
                        };
                    }
                }
                if ([dict[SStype] isEqualToString:@"focus"]) {//获取头部focus轮播图的数据
                    NSArray *focus = dict[SSitem];
                    for (NSDictionary *focusDict in focus) {
                        ItemModel *SSFocusModel = [ItemModel modelWithDictionary:focusDict];
                        [tempArray1 addObject:SSFocusModel];
                    }
                }
            }
            NSString *tempStr1 = ((ItemModel *)(tempArray.firstObject)).title;
            NSString *tempStr2 = ((ItemModel *)(self.itemArray.firstObject)).title;
            if ([tempStr1 isEqualToString:tempStr2]){
                self.itemArray = nil;
                [self.itemArray addObjectsFromArray:tempArray];
            }else{
                self.itemArray = tempArray;//?待实验
            }
            NSString *tempStr3 = ((ItemModel *)(tempArray.firstObject)).title;
            NSString *tempStr4 = ((ItemModel *)(self.itemArray.firstObject)).title;
            if ([tempStr3 isEqualToString:tempStr4]){
                self.focusArray = nil;
            }
            self.focusArray = tempArray1;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.focusArray.count > 0) { //添加tableView的头部滚动视图
                    [weakSelf addScrollView];
                }
                [weakSelf.tableView reloadData];
            });
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败？？？%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 120;
    //先给存放数据的数组分配内存
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    if (_focusArray == nil) {
        _focusArray = [NSMutableArray array];
    }
    //注册单元格(利用nib文件来注册NormalTableViewCell)
    NSString *normalNibName = NSStringFromClass([NormalTableViewCell class]);
    UINib *nib = [UINib nibWithNibName:normalNibName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:normalIDF];
    NSString *slidesNibName = NSStringFromClass([SlidesTableViewCell class]);
    UINib *nib1 = [UINib nibWithNibName:slidesNibName bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:slidesIDF];
    //加载数据
    _pageNumber = 1;
    NSDictionary *page = @{@"page":@(_pageNumber)};
    
    [self getNewsData:page];
    //下拉刷新
    self.refreshControl  = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(downLoadMore) forControlEvents:UIControlEventValueChanged];
    //Loading按钮
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
    [footBtn setTitleColor:[UIColor colorWithRed:0.64 green:0.87 blue:0.93 alpha:1] forState:UIControlStateNormal];
    [footBtn setImage:[UIImage imageNamed:@"btn_down"] forState:UIControlStateNormal];
    [footBtn addTarget:self action:@selector(upLoadMore) forControlEvents:UIControlEventTouchUpInside];
    
    footBtn.frame = CGRectMake(0, 0, 0, 20);
    self.tableView.tableFooterView = footBtn;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

-(void)downLoadMore{//下拉刷新
    NSDictionary *page = @{@"page":@(1)};
    [self getNewsData:page];
}
-(void)upLoadMore{//上拉加载
    
    _pageNumber ++ ;
    NSDictionary *page = @{@"page":@(_pageNumber)};
    [self getNewsData:page];
}
//添加tableView的头部滚动视图
-(void)addScrollView{
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,MyScreenW,200)];
    self.tableView.tableHeaderView = bottomView;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,MyScreenW,200) ];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.pagingEnabled = YES;
    [bottomView addSubview:scrollView];
    scrollView.contentSize = CGSizeMake(MyScreenW * self.focusArray.count, 0);
    for (int i = 0; i < self.focusArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MyScreenW * i, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
        [scrollView addSubview:imageView];
        ItemModel *focusModel = self.focusArray[i];
        NSURL *focusUrl = [NSURL URLWithString:focusModel.newsThumbnail];
        [imageView sd_setImageWithURL:focusUrl placeholderImage:nil];
        //给imageView添加标题和索引
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textColor = [UIColor whiteColor];
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.textColor = [UIColor whiteColor];
        titleLabel.text = focusModel.title;///////这里添加点击BTN
        NSString *currentNum = [NSString stringWithFormat:@"%d/%ld",i+1,self.focusArray.count];
        numLabel.text = currentNum;
        [imageView addSubview:titleLabel];
        [imageView addSubview:numLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@5);
            make.bottom.equalTo(@-5);
        }];
        [numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.bottom.equalTo(@-5);
            make.centerY.mas_equalTo(titleLabel);
        }];
        
        imageView.userInteractionEnabled = YES;
        SingleTapGR *singleTap = [[SingleTapGR alloc] initWithTarget:self action:@selector(buttonpress:)];
        singleTap.model = focusModel;
        [imageView addGestureRecognizer:singleTap];

    }
}

-(void)buttonpress:(SingleTapGR *)singleTap{//focus点击手势
    
    SlidesDetailsVC *slideVC = [SlidesDetailsVC new];
    slideVC.itemModel = singleTap.model;
    [self.navigationController pushViewController:slideVC animated:YES];
    
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






