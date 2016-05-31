//
//  TextModel.h
//  news_APP
//
//  Created by qingyun on 16/5/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject
@property (copy, nonatomic) NSString  *thumbnail;
@property (copy, nonatomic) NSString  *title;
@property (copy, nonatomic) NSString  *updateTime;
@property (copy, nonatomic) NSString  *comments;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
