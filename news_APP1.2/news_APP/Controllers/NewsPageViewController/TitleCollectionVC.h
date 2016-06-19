//
//  TitleCollectionVC.h
//  news_APP
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCollectionVC : UICollectionView
@property (nonatomic, strong) NSArray *titles;

+(instancetype)titleCollectionViewWithTitles:(NSArray *)titles;
@end
