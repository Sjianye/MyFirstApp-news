//
//  ItemModel.h
//  news_APP
//
//  Created by qingyun on 16/5/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject
//@property (nonatomic ,copy) NSString *newsItems;            //测试，item的种类
@property (nonatomic ,copy) NSString *newsThumbnail;      //缩略图
@property (nonatomic      ) NSInteger online;             //是否在线
@property (nonatomic ,copy) NSString *title;              //新闻标题
@property (nonatomic ,copy) NSString *source;             //数据来源
@property (nonatomic ,copy) NSString *updateTime;         //更新时间
@property (nonatomic ,copy) NSString *newsId;             //新闻页面链接地址
@property (nonatomic ,copy) NSString *commentsUrl;        //评论链接
@property (nonatomic ,copy) NSString *commentsall;        //总评论数
@property (nonatomic      ) NSInteger hasSurvey;          //是否调查
@property (nonatomic ,copy) NSString *type;               //新闻类型（文本，图片）
@property (nonatomic ,strong) NSDictionary *slideStyle;   //在hasSlide下才有{type类型,images[三个图片地址]}
@property (nonatomic ,strong) NSArray *slideImages;       //图片地址集合
@property (nonatomic ,strong)NSString *hotLink;           //hot页面数据连接
@property (nonatomic ,strong)NSString *hotName;           //hotCell推荐频道recommendChannel
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end







