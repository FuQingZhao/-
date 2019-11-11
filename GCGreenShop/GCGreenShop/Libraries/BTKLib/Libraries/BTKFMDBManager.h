//
//  BTKFMDBManager.h
//  TTReader
//
//  Created by Min Lin on 2018/1/16.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

/**
 FMDB第三方库管理
 */
@interface BTKFMDBManager : NSObject

/**
 数据库操作队列
 */
@property (nonatomic, strong, readonly) FMDatabaseQueue *queue;

/**
 FMDB单例
 */
+ (instancetype)manager;

/**
 执行一个更新语句
 
 @param sql         更新语句的sql
 @param arguments   参数列表
 @return 更新语句的执行结果
 */
+ (BOOL)executeUpdate:(NSString *)sql withArguments:(NSArray *)arguments;
+ (BOOL)executeUpdate:(NSString *)sql;

/**
 执行一个查询语句
 
 @param sql              查询语句sql
 @param queryResBlock    查询语句的执行结果
 */
+ (void)executeQuery:(NSString *)sql queryResBlock:(void(^)(FMResultSet *rs))queryResBlock;

/**
 查询出指定表的列
 
 @param table table
 @return 查询出指定表的列的执行结果
 */
+ (NSArray *)executeQueryColumnsInTable:(NSString *)table;

/**
 表记录数计算
 
 @param table 表
 @return 记录数
 */
+ (NSUInteger)countTable:(NSString *)table;

/**
 根据条件查询记录数
 
 @param table 表
 @param where 条件
 @return 记录数
 */
+ (NSUInteger)countTable:(NSString *)table where:(NSString *)where;

/**
 清空表（但不清除表结构）
 
 @param table  表名
 @param where  条件
 @return 操作结果
 */
+ (BOOL)truncateTable:(NSString *)table where:(NSString *)where;
+ (BOOL)truncateTable:(NSString *)table;

@end
