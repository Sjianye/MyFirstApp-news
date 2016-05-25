//
//  MyNewsCollectionView.h
//  news_APP
//
//  Created by qingyun on 16/5/23.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyNewsCollectionView : UICollectionView
@property (nonatomic) NSUInteger currentIndex;
@property (nonatomic ,strong) NSArray *titles;

@property (nonatomic, copy) void (^changeContentVC)(NSUInteger index);


+(instancetype)titleCollectionViewWithTitles:(NSArray *)titles;

@end
