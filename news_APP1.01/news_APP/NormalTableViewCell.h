//
//  NormalTableViewCell.h
//  news_APP
//
//  Created by qingyun on 16/5/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextModel.h"

@interface NormalTableViewCell : UITableViewCell

@property (nonatomic ,strong)TextModel *model;          //利用setmodel方法设置cell各个属性


@end
