//
//  qTableViewController.h
//  news_APP
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitlesModel.h"
@interface NewsTableViewController : UITableViewController
@property (nonatomic)   NSString *newsUrlsKey; //新闻的数据源
//@property (nonatomic ,copy) TitlesModel *type;
@property (nonatomic)   NSInteger indexNumber;
@end
