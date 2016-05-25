//
//  TextModel.h
//  news_APP
//
//  Created by qingyun on 16/5/22.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject
@property (weak, nonatomic) NSString  *thumbnail;
@property (weak, nonatomic) NSString  *title;
@property (weak, nonatomic) NSString  *updateTime;
@property (weak, nonatomic) NSString  *comments;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
