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

@property (nonatomic ,strong)TextModel *model;

@property (weak, nonatomic) IBOutlet UILabel *lableType;

@end
