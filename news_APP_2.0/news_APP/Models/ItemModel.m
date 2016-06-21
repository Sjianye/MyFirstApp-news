//
//  ItemModel.m
//  news_APP
//
//  Created by qingyun on 16/5/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "ItemModel.h"
#import "Common.h"
#import "NSDate+SSDate.h"
@implementation ItemModel
//@property (nonatomic ,copy) NSString *newsThumbnail;      //缩略图
//@property (nonatomic      ) NSInteger online;             //是否在线
//@property (nonatomic ,copy) NSString *title;              //新闻标题
//@property (nonatomic ,copy) NSString *source;             //数据来源
//@property (nonatomic ,copy) NSString *updateTime;         //更新时间
//@property (nonatomic ,copy) NSString *newsId;             //链接地址
//@property (nonatomic ,copy) NSString *commentsUrl;        //评论链接
//@property (nonatomic ,copy) NSNumber *commentsall;        //总评论数
//@property (nonatomic      ) NSInteger hasSurvey;          //是否调查
//@property (nonatomic ,copy) NSString *type;               //新闻类型（文本，图片）
////@property (nonatomic      ) NSInteger hasSlide;           //是否有幻灯片 (type为slide的此属性都为真)
//@property (nonatomic ,strong) NSDictionary *slideStyle;   //在hasSlide下才有{type类型,images[三个图片地址]}
//@property (nonatomic ,strong) NSArray *slideImages;       //图片地址集合
+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    return [[self alloc]initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        _newsThumbnail = dict[SSthumbnail];
        _online = [dict[SSonline] integerValue];
        _title = dict[SStitle];
        _source = dict[SSsource];
        
        //转化时间
        NSString *timeString = dict[SSupdateTime];
        if (timeString) {
            NSDate *date = [NSDate dateWithSSString:timeString];
            _updateTime = [self dateStringFormDate:date];
        }
        _newsId = dict[SSNewsid];
        _commentsUrl = dict[SScommentsUrl];
        _commentsall = dict[SScommentsall];
        _hasSurvey  = [dict[SShasSurvey] integerValue];
        _type       =  dict[SStype];
        
        _slideStyle = dict[SSslideStyle];
        if (_slideStyle) {
            _slideImages = _slideStyle[SSslideImages];
        }
        _hotLink = dict[SSLink][@"url"];
        _hotName = dict[SSrecommendChannel][@"name"];
    }
    return self;
}
-(NSString *)dateStringFormDate:(NSDate *)date{
    NSTimeInterval interval = -[date timeIntervalSinceNow];
    if (interval < 60 * 30){//分级
        return [NSString stringWithFormat:@"%d分钟前",(int)(interval / 60)];
    }else if (interval < 60 * 60 * 24 ){//一天内
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        return [formatter stringFromDate:date];
    }else if (interval < 60 * 60 * 24 * 30 && interval >= 60 * 60 * 24 ){//天级
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        return [formatter stringFromDate:date];
    }
    return nil;
}

@end












