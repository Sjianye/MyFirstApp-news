//
//  NSDate+SSDate.m
//  news_APP
//
//  Created by qingyun on 16/5/27.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "NSDate+SSDate.h"

@implementation NSDate (SSDate)
+(instancetype)dateWithSSString:(NSString *)dateString{
    
//    //如:"2016\/05\/13 18:29:12"
    NSString *dateFormatter = @"yyyy-MMM-dd HH:mm:ss ";
    //创建格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = dateFormatter;
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"SSS"];
    
    return [formatter dateFromString:dateString];
}

@end
