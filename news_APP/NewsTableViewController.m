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
#define scrollViewImagesCounts 4
@interface NewsTableViewController ()

@property (nonatomic ,strong)NSArray *array;
@end

@implementation NewsTableViewController

static NSString *Identifier = @"MyCellOne";

-(NSArray *)array{
    if (!_array) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    TextModel *model = self.array[indexPath.row];
    cell.model = model;
    cell.lableType.text = _type; ///////
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
