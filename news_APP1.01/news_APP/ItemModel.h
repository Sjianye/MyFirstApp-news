//
//  ItemModel.h
//  news_APP
//
//  Created by qingyun on 16/5/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject
@property (nonatomic ,copy) NSString *newsThumbnail;      //缩略图
@property (nonatomic      ) NSInteger online;             //是否在线
@property (nonatomic ,copy) NSString *title;              //新闻标题
@property (nonatomic ,copy) NSString *source;             //数据来源
@property (nonatomic ,copy) NSString *updateTime;         //更新时间
@property (nonatomic ,copy) NSString *newsId;             //链接地址
@property (nonatomic ,copy) NSString *commentsUrl;        //评论链接
@property (nonatomic ,copy) NSNumber *commentsall;        //总评论数
@property (nonatomic      ) NSInteger hasSurvey;          //是否调查
@property (nonatomic ,copy) NSString *type;               //新闻类型（文本，图片）
//@property (nonatomic      ) NSInteger hasSlide;           //是否有幻灯片 (type为slide的此属性都为真)
@property (nonatomic ,strong) NSDictionary *slideStyle;   //在hasSlide下才有{type类型,images[三个图片地址]}
@property (nonatomic ,strong) NSArray *slideImages;       //图片地址集合
+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end







