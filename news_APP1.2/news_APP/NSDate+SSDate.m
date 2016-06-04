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
    
    //"2016/06/01 18:51:00"
    //创建格式化对象
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    formatter.locale = [NSLocale localeWithLocaleIdentifier:@"ss_CN"];
    return [formatter dateFromString:dateString];
}

@end
