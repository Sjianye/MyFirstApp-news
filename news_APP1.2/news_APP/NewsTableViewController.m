//
//  qTableViewController.m
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ThisPageVCHeader.h"

@interface NewsTableViewController ()

@property (nonatomic)        NSInteger newsPage; // 标题的页码
@property (nonatomic ,strong)AFHTTPSessionManager *manager;
@property (nonatomic ,strong)NSMutableArray *itemArray;    //新闻数组(内部为itemModel模型)
@property (nonatomic ,strong)NSMutableArray *focusArray;   //头部滚动视图数据



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
-(void)getNewsData{
    __weak typeof(self) weakSelf = self;
    [self.manager GET:_newsUrlsKey parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        if (response.statusCode == 200) {
            
            if ([responseObject isKindOfClass:[NSArray class]]) {
                //定义一个数组 获取字典里的内容
                //            NSLog(@"%@",responseObject);
                NSArray *newsItems = (NSArray *)responseObject;
                //遍历这个数组 newsItems
                for (NSDictionary *dict in newsItems) {
                    if ([dict[SStype] isEqualToString:@"list"]) {
                        NSArray *items = dict[SSitem];
                        for (NSDictionary *NewsItem in items) {
                            ItemModel *SSItemModel = [ItemModel modelWithDictionary:NewsItem];//会抓到SSItemModel的type为NSNULL ⚠️⚠️⚠️
                            if ([SSItemModel.type isMemberOfClass:[NSNull class]]) {
                                return;
                            }
                            if (![SSItemModel.type isEqualToString:@"sports_live"] || [SSItemModel.type isEqualToString:@"text_live"]) {
                                [weakSelf.itemArray addObject:SSItemModel];
                            }
                        }
                    }
                    if ([dict[SStype] isEqualToString:@"focus"]) {//获取头部focus轮播图的数据
                        NSArray *focus = dict[SSitem];
                        for (NSDictionary *focusDict in focus) {
                            ItemModel *SSFocusModel = [ItemModel modelWithDictionary:focusDict];
                            [weakSelf.focusArray addObject:SSFocusModel];
                            // NSLog(@"--------%@",SSFocusModel);
                        }
                    }
                }
                //dispatch_async(dispatch_get_main_queue(), ^{
                if (weakSelf.focusArray.count > 0) {//添加tableView的头部滚动视图
                    [weakSelf addScrollView];
                }
                //[weakSelf.tableView reloadData];
                // });
                [weakSelf.tableView reloadData];
            }
            
        };
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败？？？%@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.estimatedRowHeight = 120;
    //self.tableView.rowHeight = 110;
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
    //注册单元格(利用nib文件来注册SlidesTableViewCell)
    NSString *slidesNibName = NSStringFromClass([SlidesTableViewCell class]);
    UINib *nib1 = [UINib nibWithNibName:slidesNibName bundle:nil];
    [self.tableView registerNib:nib1 forCellReuseIdentifier:slidesIDF];
    //加载数据
    [self getNewsData];
    
    //下拉刷新
    self.refreshControl  = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(xialashuaxin) forControlEvents:UIControlEventValueChanged];
    
    
    //加载更多
    UIButton *footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footBtn setTitle:@"Loading..." forState:UIControlStateNormal];
    [footBtn setBackgroundColor:[UIColor lightGrayColor]];
    footBtn.frame = CGRectMake(0, 0, 0, 44);
    self.tableView.tableFooterView = footBtn;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);

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
        
        titleLabel.text = focusModel.title;
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
    }
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ItemModel *itemModel = self.itemArray[indexPath.row];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itemModel.newsId]];
//    [self.navigationController pushViewController:singlenewsinfoViewController animated:YES];  22
}

@end






