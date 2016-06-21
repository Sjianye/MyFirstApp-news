//
//  SingleTapGR.h
//  news_APP
//
//  Created by qingyun on 16/6/19.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
@interface SingleTapGR : UITapGestureRecognizer//子类换手势类，传递model

@property (nonatomic ,strong)ItemModel *model;

@end
