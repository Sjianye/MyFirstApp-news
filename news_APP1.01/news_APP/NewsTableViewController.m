//
//  qTableViewController.m
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NewsTableViewController.h"
#import "TextModel.h"
#import "NormalTableViewCell.h"
#import "Masonry.h"
#import "TabBarHeader.h"

#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "AFHTTPSessionManager.h"
#import "ItemModel.h"
#import "Common.h"
#define kFengHuang @"http://api.iclient.ifeng.com/ClientNews"
#define scrollViewImagesCounts 4
@interface NewsTableViewController ()

@property (nonatomic ,strong)NSArray *array;

@property (nonatomic)        NSInteger newsPage; // 标题的页码
@property (nonatomic ,strong)AFHTTPSessionManager *manager;
@property (nonatomic ,strong)NSMutableArray *itemArray;    //新闻数组
@end

@implementation NewsTableViewController

static NSString *Identifier = @"MyCellOne";

#pragma -mark AFHTTPSessionManager 从网络请求数据
-(AFHTTPSessionManager *)manager {
    if (!_manager) {
        //创建manager对象
        _manager=[AFHTTPSessionManager manager];
        //设置网络监听
        _manager.reachabilityManager=[AFNetworkReachabilityManager sharedManager];
        __weak AFNetworkReachabilityManager *reachManager=_manager.reachabilityManager;
        //设置监听回调函数
        [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            //显示监听状态
            NSLog(@"=====当前网络状态=%@",[reachManager localizedNetworkReachabilityStatusString]);
        }];
        //启动监听
        [_manager.reachabilityManager startMonitoring];
    }
    return _manager;
}
//获取数据 （buggggggg）
-(void)getNewsData:(NSDictionary *)pageDic{
    __weak typeof(self) weakSelf = self;
    NSDictionary *parameters=@{@"id":@"SYLB10,SYDT10,SYRECOMMEND",@"page":@"1"};
    [self.manager GET:kFengHuang parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            NSLog(@"%@",responseObject);
            //定义一个数组 获取字典里的内容
            NSArray *newsItems = (NSArray *)responseObject;
            //遍历这个数组 newsItems
            for (NSDictionary *dict in newsItems) {
                if ([dict[SStype] isEqualToString:@"list"]) {
                    NSArray *items = dict[SStype];
                    for (NSDictionary *ZH_NewsItem in items) {
                        //判断一下 类型内没有“phvideo”的话就显示其他内容
                        if (!([ZH_NewsItem[SStype] isEqualToString:@"text_live"]||[ZH_NewsItem [SStype] isEqualToString:@"sports_live"])) {
                            
                            ItemModel *SSitemModel = [ItemModel modelWithDictionary:ZH_NewsItem];
                            [weakSelf.itemArray addObject:SSitemModel];
                        }
                    }
                    //轮播图的数据
                }
            }
          //  dispatch_async(dispatch_get_main_queue(), ^{
                
            //    if (weakSelf.scrollerArray.count > 0) {
            //        [weakSelf addScrollView];
            //    }
            //    [weakSelf.tableView reloadData];
          //  });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
}


//plist文件读取数据 转模型
-(NSArray *)array{
    if (_array == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Test" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *muAttay = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            TextModel *model = [TextModel modelWithDictionary:dic];
            [muAttay addObject:model];
        }
        _array = muAttay;
    }
    return _array;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.rowHeight = MyScreenH / 7.0;
    //注册单元格(利用nib文件来注册单元格)
    NSString *nibName = NSStringFromClass([NormalTableViewCell class]);
    UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:Identifier];
    //添加tableView的头部滚动视图
    [self addScrollView];
    
    
    [self getNewsData:nil];
    NSLog(@"%@",self.itemArray);
}
//添加tableView的头部滚动视图
-(void)addScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,MyScreenW,MyScreenH / 4.0 ) ];
    scrollView.backgroundColor = [UIColor grayColor];
    scrollView.pagingEnabled = YES;
    self.tableView.tableHeaderView = scrollView;
    scrollView.contentSize = CGSizeMake(MyScreenW * scrollViewImagesCounts, 0);
    for (int i = 0; i < scrollViewImagesCounts; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MyScreenW * i, 0, CGRectGetWidth(scrollView.frame), CGRectGetHeight(scrollView.frame))];
        [scrollView addSubview:imageView];
        NSString *name = [NSString stringWithFormat:@"guanggao%d",i+1];
        imageView.image = [UIImage imageNamed:name];
        //imageView.contentMode = UIViewContentModeCenter;
    }

    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    TextModel *model = self.array[indexPath.row];
    cell.model = model;
    return cell;
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
