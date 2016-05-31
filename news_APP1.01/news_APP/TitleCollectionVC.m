//
//  TitleCollectionVC.m
//  news_APP
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TitleCollectionVC.h"
#import "MyCollectionViewCell.h"
@interface TitleCollectionVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end


@implementation TitleCollectionVC

+(instancetype)titleCollectionViewWithTitles:(NSArray *)titles{
    //1.创建flowLayout
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    //滚动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //item间距
    flowLayout.minimumInteritemSpacing = 10;
    //预估的itemSize
    flowLayout.estimatedItemSize = CGSizeMake(44, 44);
    //sectionInsets
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    //2.创建一个titleCollectionView
    TitleCollectionVC *titleCollectionView = [[TitleCollectionVC alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    
    titleCollectionView.backgroundColor = [UIColor lightGrayColor];
    //设置数据源和代理
    titleCollectionView.dataSource = titleCollectionView;
    titleCollectionView.delegate = titleCollectionView;
    //隐藏水平的滚动条
    titleCollectionView.showsHorizontalScrollIndicator = NO;
    //保存所有的栏目
    titleCollectionView.titles = titles;
    //注册cell
    [titleCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"item"];
    
    
    return titleCollectionView;
}

#pragma mark -Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    item.label.text = self.titles[indexPath.item];
    return item;
}

@end




