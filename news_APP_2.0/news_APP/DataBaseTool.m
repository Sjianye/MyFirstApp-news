//
//  QYDataBaseTool.m
//  01-数据持久化作业
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#import "DataBaseTool.h"
#import "FMDB.h"
//静态变量
static FMDatabaseQueue *queue;
@implementation DataBaseTool
+(NSString *)getFilePath{
    //docmuents 目录
    NSString *docmuentsPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [docmuentsPath stringByAppendingPathComponent:BaseFileName];
    
}
//获取数据库对象
+(FMDatabaseQueue *)getFMDataBase{
    //创建数据库对象
    if (!queue) {
        
        queue=[FMDatabaseQueue databaseQueueWithPath:[DataBaseTool getFilePath]];
        //创建表
        [DataBaseTool createTable];
    }
    //    });
    
    return queue;
}
+(void)createTable{
    [[DataBaseTool getFMDataBase]inDatabase:^(FMDatabase *db) {
        //创建表 执行多条sql语句
        if ([db executeStatements:createTabel]) {
            NSLog(@"====create ok")
            ;        } ;
    }];
}
+(void)updateStatementsSql:(NSString *)sql withParsmeters:(NSDictionary *)pars block:(callFiniseh)block{
    [[DataBaseTool getFMDataBase]inDatabase:^(FMDatabase *db) {
        if (pars) {
            //执行带参数
            block([db executeUpdate:sql withParameterDictionary:pars],[db lastErrorMessage]);
        }else{
            block([db executeUpdate:sql],[db lastErrorMessage]);
        }
    }];
}
+(void)selectStatementsSql:(NSString *)sql withParsmeters:(NSDictionary *)pars forMode:(NSString *)modeName block:(callResult)block{
    [[DataBaseTool getFMDataBase]inDatabase:^(FMDatabase *db) {
        //1.声明FMResultSet
        FMResultSet *set;
        if(pars){
            set=[db executeQuery:sql withParameterDictionary:pars];
        }else{
            set=[db executeQuery:sql];
        }
        //2.取结果
        NSMutableArray *dataArr=[NSMutableArray array];
        while ([set next]) {
            
            if (modeName) {
                //字典转mode
                NSObject *objc=[NSClassFromString(modeName) new];
                //kvc
                [objc setValuesForKeysWithDictionary:[set resultDictionary]];
                
                [dataArr addObject:objc];
            }else{
                //结果存放成字典
                [dataArr addObject:[set resultDictionary]];
            }
        }
        //回调
        block(dataArr,[db lastErrorMessage]);
    }];
}


@end
