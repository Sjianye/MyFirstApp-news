//
//  DataBaseFile.h
//  01-数据持久化作业
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 QingYun. All rights reserved.
//

#ifndef DataBaseFile_h
#define DataBaseFile_h
#define BaseFileName @"stduent.db"
//创建表
#define createTabel @"create table if not exists student(stu_id text,name text,age text);"
//插入数据
#define Inserinto @"insert into student values(:stu_id,:name,:age)"

//查询本地数据
#define selectAll @"select * from student"
#define selectChar(a) [NSString stringWithFormat:@"select *from student where name like'%%%@%%'",a]
//删除操作
#define DeleteAll @"delete from student"
#define DeleteStu_Id @"delete from student where stu_id=:stu_id"
//更新数据
#define UpdateSql @"update student set name=:name,age=:age where stu_id=:stu_id"


#endif /* DataBaseFile_h */
