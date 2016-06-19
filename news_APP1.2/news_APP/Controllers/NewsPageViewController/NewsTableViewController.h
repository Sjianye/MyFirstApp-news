//
//  qTableViewController.h
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThisPageVCHeader.h"
@interface NewsTableViewController : UITableViewController
@property (nonatomic)   NSString *newsUrlsKey; //新闻的数据源
@property (nonatomic)   NSInteger indexNumber; //根据新闻分类(热点，体育，军事……)确定头部的索引
@end
