//
//  titlesModel.m
//  news_APP
//
//  Created by qingyun on 16/5/31.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "TitlesModel.h"

@implementation TitlesModel


+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}



@end
