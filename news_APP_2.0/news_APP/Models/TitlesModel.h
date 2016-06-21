//
//  titlesModel.h
//  news_APP
//
//  Created by qingyun on 16/5/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitlesModel : NSObject

@property (nonatomic ,copy)NSString *species;//本地plist文件内部 头部视图数组
@property (nonatomic ,copy)NSString *url;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
