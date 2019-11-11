//
//  BTKFMDBManager.m
//  TTReader
//
//  Created by Min Lin on 2018/1/16.
//  Copyright © 2018年 jsbc. All rights reserved.
//

#import "BTKFMDBManager.h"
#import "NSFileManager+BTKLib.h"

@interface BTKFMDBManager ()
@property (nonatomic, strong, readwrite) FMDatabaseQueue *queue;
@end

@implementation BTKFMDBManager

+ (instancetype)manager {
    static dispatch_once_t onceToken;
    static BTKFMDBManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[BTKFMDBManager alloc] init];
    });
    return instance;
}

+ (void)initialize {
    
    BTKFMDBManager *manager = [BTKFMDBManager manager];
    NSString *bundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleNameKey];
    NSString *dbName = [NSString stringWithFormat:@"%@%@", bundleName, @".sqlite"];
    NSString *dbPath = [[NSFileManager libCachePath] stringByAppendingPathComponent:dbName];
    NSLog(@"⚠️DB Path :%@", dbPath);
    
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    if (queue == nil) {
        NSLog(@"code=1：创建数据库失败，请检查");
    }
    manager.queue = queue;
}

+ (BOOL)executeUpdate:(NSString *)sql withArguments:(NSArray *)arguments {
    __block BOOL updateRes = NO;
    BTKFMDBManager *manager = [BTKFMDBManager manager];
    [manager.queue inDatabase:^(FMDatabase *db) {
        updateRes = [db executeUpdate:sql withArgumentsInArray:arguments];
    }];
    return updateRes;
}

+ (BOOL)executeUpdate:(NSString *)sql {
    __block BOOL updateRes = NO;
    BTKFMDBManager *manager = [BTKFMDBManager manager];
    [manager.queue inDatabase:^(FMDatabase *db) {
        updateRes = [db executeUpdate:sql];
    }];
    return updateRes;
}

+ (void)executeQuery:(NSString *)sql queryResBlock:(void(^)(FMResultSet *rs))queryResBlock {
    BTKFMDBManager *manager = [BTKFMDBManager manager];
    [manager.queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        if (queryResBlock != nil) {
            queryResBlock(rs);
        }
    }];
    [manager.queue close];
}

+ (NSArray *)executeQueryColumnsInTable:(NSString *)table {
    
    NSMutableArray *columnsM = [NSMutableArray array];
    NSString *sql = [NSString stringWithFormat:@"PRAGMA table_info (%@);",table];
    [self executeQuery:sql queryResBlock:^(FMResultSet *rs) {
        while ([rs next]) {
            NSString *column = [rs stringForColumn:@"name"];
            [columnsM addObject:column];
        }
        
        if (columnsM.count == 0)
            NSLog(@"code=2：您指定的表：%@,没有字段信息，可能是表尚未创建！", table);
    }];
    
    return [columnsM copy];
}

+ (NSUInteger)countTable:(NSString *)table {
    
    NSString *alias = @"count";
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) AS %@ FROM %@;", alias, table];
    
    __block NSUInteger count = 0;
    [self executeQuery:sql queryResBlock:^(FMResultSet *set) {
        while ([set next]) {
            count = [[set stringForColumn:alias] integerValue];
        }
    }];
    
    return count;
}

+ (NSUInteger)countTable:(NSString *)table where:(NSString *)where {
    
    NSString *alias = @"count";
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) AS %@ FROM %@ WHERE %@;", alias, table, where];
    __block NSUInteger count = 0;
    [self executeQuery:sql queryResBlock:^(FMResultSet *set) {
        while ([set next]) {
            count = [[set stringForColumn:alias] integerValue];
        }
    }];
    return count;
}

+ (BOOL)truncateTable:(NSString *)table where:(NSString *)where {
    BOOL res = [self executeUpdate:[NSString stringWithFormat:@"DELETE FROM '%@' WHERE %@;", table, where]];
    return res;
}

+ (BOOL)truncateTable:(NSString *)table {
    BOOL res = [self executeUpdate:[NSString stringWithFormat:@"DELETE FROM '%@';", table]];
    return res;
}

@end
