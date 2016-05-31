//
//  MyNewsCollectionView.m
//  news_APP
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "MyNewsCollectionView.h"
#import "MyNewsCollectionViewCell.h"
#import "TitlesModel.h"

@interface MyNewsCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation MyNewsCollectionView
/**
 *  通过传过来的(NSArray *)titles 创建 collectionView
 *
 *  @param titles 传进来的collectionView的Items的内容（现在为自定义的固定数组）
 *
 *  @return 返回一个创建好的collectionView
 */
+(instancetype)titleCollectionViewWithTitles:(NSArray *)titles{
    //1.创建flowLayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //滚动方向
    //item间距
    flowLayout.minimumInteritemSpacing = 10;
    //预估的itemSize
    flowLayout.estimatedItemSize = CGSizeMake(50, 33);
    //sectionInsets
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    MyNewsCollectionView *newsCollectionView = [[MyNewsCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    newsCollectionView.backgroundColor = [UIColor whiteColor];
    //设置数据源和代理
    newsCollectionView.dataSource = newsCollectionView;
    newsCollectionView.delegate = newsCollectionView;
    //隐藏水平的滚动条
    newsCollectionView.showsHorizontalScrollIndicator = NO;
    //保存所有的栏目
    newsCollectionView.titles = titles;
    //注册cell
    [newsCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyNewsCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"item"];
    
    newsCollectionView.currentIndex = 0;
    return newsCollectionView;
}
#pragma mark -Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MyNewsCollectionViewCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
//    item.label.text = self.titles[indexPath.item];
    TitlesModel *titleModel = self.titles[indexPath.item];
    item.label.text = titleModel.species;
    item.label.textColor = indexPath.item == _currentIndex ? [UIColor redColor] : [UIColor blackColor];
    return item;
}

#pragma mark  -UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndex = indexPath.item;
    
    if (_changeContentVC) {
        _changeContentVC(indexPath.item);
    }
}
-(void)setCurrentIndex:(NSUInteger)currentIndex{
    //1.把之前选中的菜单标题置为黑色(_currentIndex)
    MyNewsCollectionViewCell *cell = (MyNewsCollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:_currentIndex inSection:0]];
    cell.label.textColor = [UIColor blackColor];
    //2.把将要选中的菜单标题置为红色(currentIndex)
    MyNewsCollectionViewCell *willSelctedCell = (MyNewsCollectionViewCell *)[self cellForItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndex inSection:0]];
    willSelctedCell.label.textColor = [UIColor redColor];
    //3.保留将要选中的菜单的索引
    _currentIndex = currentIndex;
    //4.计算偏移量
    CGFloat detalValue = willSelctedCell.center.x - self.center.x;
    if (detalValue < 0) {
        detalValue = 0;
    }else if (detalValue > self.contentSize.width - self.frame.size.width){
        detalValue = self.contentSize.width - self.frame.size.width;
    }
    //5.设置偏移量
    [self setContentOffset:CGPointMake(detalValue, 0) animated:YES];

}


@end



