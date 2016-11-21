//
//  QIAODBMangerEx.m
//  9-19DataBase
//
//  Created by SouHanaQiao on 14-9-19.
//  Copyright (c) 2014年 mac. All rights 葬花桥.
//

#import "QIAODBMangerEx.h"
#import <objc/runtime.h>

@interface QIAODBMangerEx () {
    FMDatabase *_dataBase;
}

@property (nonatomic, PX_STRONG) NSString            *dataBaseName; // 数据库名

@property (nonatomic, PX_STRONG) NSString            *tableName; // 当前表名

@property (nonatomic, PX_STRONG) NSMutableArray      *fieldArray; // 字段数组

@property (nonatomic, PX_STRONG) NSMutableDictionary *varTypeDict; // 变量与其类型

@property (nonatomic, assign   ) Class               modelClass; // 数据模型类

@end

@implementation QIAODBMangerEx

- (id)initWithDataBase:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass
{
    if (self = [self initWithFirst:dataBase tableName:table modelClass:modelClass autoincrement:YES]) {
    
    }
    return self;
}

- (id)initWithFirst:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass autoincrement:(BOOL)autoincrement
{
    if (self = [super init]) {
        self.dataBaseName = dataBase;
        self.tableName    = table;
        self.modelClass   = modelClass;
        _fieldArray       = [[NSMutableArray alloc] init];
        _varTypeDict      = [[NSMutableDictionary alloc] init];
        
        [self getIvar:modelClass];
        // 打开数据库
        [self getDataBase];
        // 创建表
        [self createTable:autoincrement];
    }
    return self;
}

+ (id)managerWithDataBase:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass
{
    return PX_AUTORELEASE([[self alloc] initWithFirst:dataBase tableName:table modelClass:modelClass autoincrement:NO]);
}

+ (id)managerWithFirst:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass autoincrement:(BOOL)autoincrement
{
    return PX_AUTORELEASE([[self alloc] initWithFirst:dataBase tableName:table modelClass:modelClass autoincrement:autoincrement]);
}

- (void)getIvar:(Class)class
{
    NSUInteger outCount = 0;
    Ivar *vars = class_copyIvarList(class, &outCount);
    for (NSInteger i = 0; i < outCount; i++) {
        NSString *var  = [NSString stringWithUTF8String:ivar_getName(vars[i])];
        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(vars[i])];
        [_varTypeDict setObject:type forKey:var];
        [_fieldArray addObject:var];
    }
    free(vars);
}

// 插入数据
- (void)insertDataWithModel:(id)model
{
    // 打开数据库
    if ([_dataBase open]) {
        // 执行插入语句
        // ? 代表占位符 可以不用管后面数据的类型
        //NSString *insertSql = @"insert into user(name, age, image) values(?,?,?)";
        NSMutableString *insertSql1 = [NSMutableString stringWithFormat:@"insert into %@(", _tableName];
        NSMutableString *insertSql2 = [NSMutableString stringWithFormat:@"values("];
        NSMutableString *insertSql = nil;
        NSMutableArray *argumentArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        for (NSInteger index = 0; index < _fieldArray.count; index++) {
            [insertSql1 appendFormat:@"%@", _fieldArray[index]];
            [insertSql2 appendFormat:@"?"];
            id value = [model valueForKey:_fieldArray[index]];
            if (value) {
                [argumentArray addObject:value];
            } else {
                [argumentArray addObject:[NSNull null]];
            }
            
            if (index == _fieldArray.count - 1) {
                [insertSql1 appendFormat:@")"];
                [insertSql2 appendFormat:@")"];
                insertSql = [NSMutableString stringWithFormat:@"%@ %@", insertSql1, insertSql2];
                break;
            }
            [insertSql1 appendFormat:@", "];
            [insertSql2 appendFormat:@", "];
        }
    
        if (![_dataBase executeUpdate:insertSql withArgumentsInArray:argumentArray]) {
            WPXLogv(@"插入失败!!");
        }
        [_dataBase close];
        return;
    }
    
    WPXLogv(@"数据库打开失败!!");
}

// 删除数据
- (void)deleteDataWithPrimaryKey:(id)primaryKey
{
    if ([_dataBase open]) {
        
        //NSString *deleteSql = @"delete from user where id = ?";
        NSString *deleteSql = [NSString stringWithFormat:@"delete from %@ where %@ = ?", _tableName, _fieldArray[0]];
        // 基本类型一定要转换为NSObject的子类
        
        if ([_dataBase executeUpdate:deleteSql, primaryKey]) {
            WPXLog(@"删除%@成功", primaryKey);
        }
        [_dataBase close];
        return;
    }
    
    WPXLogv(@"数据库打开失败!!");
}

//清空表数据
- (void)truacateMyTable
{
    if ([_dataBase open]) {
        
        //NSString *deleteSql = @"delete from user where id = ?";
        NSString *deleteSql = [NSString stringWithFormat:@"delete from %@", _tableName];
        // 基本类型一定要转换为NSObject的子类
        
        if ([_dataBase executeUpdate:deleteSql]) {
        }
        [_dataBase close];
        return;
    }
    
    WPXLogv(@"数据库打开失败!!");
}

// 修改数据 根据
- (void)updateDataWithModel:(id)model
{
    if ([_dataBase open]) {
        //
        // NSString *updateSql = @"update user set name = ?, age = ?, image = ? where id = ?";
        NSMutableString *updateSql = [NSMutableString stringWithFormat:@"update %@ set ", _tableName];
        NSMutableArray *argumentArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        for (NSInteger index = 1; index < _fieldArray.count; index++) {
            [updateSql appendFormat:@"%@ = ?", _fieldArray[index]];
            id value = [model valueForKey:_fieldArray[index]];
            if (value) {
                [argumentArray addObject:value];
            } else {
                [argumentArray addObject:[NSNull null]];
            }
            
            if (index == _fieldArray.count - 1) {
                break;
            }
            [updateSql appendFormat:@", "];
        }
        [updateSql appendFormat:@" where %@ = %@", _fieldArray[0], [model valueForKey:_fieldArray[0]]];
        
        if ([_dataBase executeUpdate:updateSql withArgumentsInArray:argumentArray]) {
            WPXLog(@"修改id%@成功", [model valueForKey:_fieldArray[0]]);
        } else {
            WPXLogv(@"修改失败");
        }
        [_dataBase close];
        return;
    }
    
    WPXLogv(@"数据库打开失败!!");
}

//根据主表id修改数据
- (void)updateDataWithModelWhereColName:(id)model colName:(id)colName colValue:(id)colValue whereValue:(id)whereValue
{
    if ([_dataBase open]) {
        //
        // NSString *updateSql = @"update user set name = ?, age = ?, image = ? where id = ?";
        NSMutableString *updateSql    = [NSMutableString stringWithFormat:@"update %@ set %@ = %@ where %@ = %@", _tableName,colName,colValue,model,whereValue];
        NSMutableArray *argumentArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        if ([_dataBase executeUpdate:updateSql withArgumentsInArray:argumentArray]) {
            WPXLog(@"修改id%@成功", [model valueForKey:_fieldArray[0]]);
        } else {
            WPXLogv(@"修改失败");
        }
        [_dataBase close];
        return;
    }
    
    WPXLogv(@"数据库打开失败!!");
}

//根据主表id修改数据
- (void)updateDataWithWhereColName:(id)coloName coloName1:(id)coloName1 coloName2:(id)coloName2 coloName3:(id)coloName3 coloName4:(id)coloName4 coloName5:(id)coloName5 coloName6:(id)coloName6 coloName7:(id)coloName7 coloName8:(id)coloName8 value:(id)value value1:(id)value1 value2:(id)value2 value3:(id)value3 value4:(id)value4 value5:(id)value5 value6:(id)value6 value7:(id)value7 value8:(id)value8 whereId:(id)whereId whereValue:(id)whereValue
{
    if ([_dataBase open]) {
        //
        // NSString *updateSql = @"update user set name = ?, age = ?, image = ? where id = ?";
        NSMutableString *updateSql = [NSMutableString stringWithFormat:@"update %@ set %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@', %@ = '%@',%@ = '%@', %@ = '%@', %@ = '%@' where %@ = '%@'", _tableName,coloName,value,coloName1,value1,coloName2,value2,coloName3,value3,coloName4,value4,coloName5,value5,coloName6,value6,coloName7,value7,coloName8,value8,whereId,whereValue];
        NSMutableArray *argumentArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        if ([_dataBase executeUpdate:updateSql withArgumentsInArray:argumentArray]) {
            WPXLog(@"修改id%@成功", [model valueForKey:_fieldArray[0]]);
        } else {
            WPXLogv(@"修改失败");
        }
        [_dataBase close];
        return;
    }
    
    WPXLogv(@"数据库打开失败!!");
}

// 查询
- (id)selectDataWithPrimaryKey:(id)primaryKey
{
    if ([_dataBase open]) {
        // 查询语句
        //NSString *selectSql  = @"select * from user where id = ?";
        NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where %@ = ?", _tableName, _fieldArray[0]];
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql, primaryKey];
        // 从返回的第一条数据遍历到最后一条
        id model = PX_AUTORELEASE([[_modelClass alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
        }
        [_dataBase close];
        return model;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 子表数据查询字符串
- (id)selectDataWithColName:(id)primaryKey :(NSString *)colName
{
    if ([_dataBase open]) {
        // 查询语句
        //NSString *selectSql  = @"select * from user where id = ?";
        NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", _tableName, colName,primaryKey];
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql];
        // 从返回的第一条数据遍历到最后一条
        id model = PX_AUTORELEASE([[_modelClass alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
        }
        [_dataBase close];
        return model;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 子表数据查询整形
- (id)selectIntDataWithColName:(id)primaryKey :(id)colName
{
    if ([_dataBase open]) {
        // 查询语句
        //NSString *selectSql  = @"select * from user where id = ?";
        NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where %@ = %@", _tableName, colName,primaryKey];
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql];
        // 从返回的第一条数据遍历到最后一条
        id model = PX_AUTORELEASE([[_modelClass alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
        }
        [_dataBase close];
        return model;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 查询所有匹配的数据
- (NSArray *)selectWhereAllFromTable:(id)primaryKey :(NSString *)colName
{
    if ([_dataBase open]) {
        // 查询语句
        NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", _tableName, colName,primaryKey];
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql];
        // 从返回的第一条数据遍历到最后一条
        NSMutableArray *modelArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            id model = [[_modelClass alloc] init];
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
            [modelArray addObject:model];
            PX_RELEASE(model);
        }
        [_dataBase close];
        return modelArray;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 查询模糊数据
- (NSArray *)selectWhereLikeAllFromTable:(NSString *)value :(NSString *)oneColName :(NSString *)twoColName :(NSString *)threeColName
{
    if ([_dataBase open]) {
        
        // 查询语句
        NSMutableString *selectSql = [NSMutableString stringWithFormat:@"select * from %@ where %@ like '%%",_tableName,oneColName];
        [selectSql appendFormat:@"%@",value];
        [selectSql appendFormat:@"%%' or %@ like '%%",twoColName];
        [selectSql appendFormat:@"%@",value];
        [selectSql appendFormat:@"%%' or %@ like '%%",threeColName];
        [selectSql appendFormat:@"%@",value];
        [selectSql appendFormat:@"%%'"];
        
        
        // 查询语句
//        NSString *selectSql = [NSString stringWithFormat:@"select * from %@ where %@ LIKE '%%?%%' or %@ LIKE '%%?%%' or %@ like '%%?%%'", _tableName, oneColName, twoColName, threeColName];
//        NSLog(@"%@",selectSql);
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql,value,value,value];
        // 从返回的第一条数据遍历到最后一条
        NSMutableArray *modelArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            id model = [[_modelClass alloc] init];
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
            [modelArray addObject:model];
            PX_RELEASE(model);
        }
        [_dataBase close];
        return modelArray;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 查询所有
- (NSArray *)selectAllFromTable
{
    if ([_dataBase open]) {
        // 查询语句
        NSString *selectSql = [NSString stringWithFormat:@"select * from %@", _tableName];
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql];
        // 从返回的第一条数据遍历到最后一条
        NSMutableArray *modelArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            id model = [[_modelClass alloc] init];
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
            [modelArray addObject:model];
            PX_RELEASE(model);
        }
        [_dataBase close];
        return modelArray;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 查询第一条数据
- (NSArray *)selectTopFromTable
{
    if ([_dataBase open]) {
        // 查询语句
        NSString *selectSql = [NSString stringWithFormat:@"select * from %@ limit 0,1", _tableName];
        // 返回一个结果集
        FMResultSet *result = [_dataBase executeQuery:selectSql];
        // 从返回的第一条数据遍历到最后一条
        NSMutableArray *modelArray = PX_AUTORELEASE([[NSMutableArray alloc] init]);
        while ([result next]) {
            // 返回一个1*n矩阵 n代表字段总数
            id model = [[_modelClass alloc] init];
            for (NSInteger index = 0; index < _fieldArray.count; index++) {
                id varType    = [_varTypeDict objectForKey:_fieldArray[index]];
                NSString *key = _fieldArray[index];
                if([varType isEqualToString:NSDataType]) {
                    [model setValue:[result dataForColumnIndex:(int)index] forKey:key];
                } else {
                    [model setValue:[result stringForColumnIndex:(int)index] forKeyPath:key];
                }
            }
            [modelArray addObject:model];
            PX_RELEASE(model);
        }
        [_dataBase close];
        return modelArray;
    }
    
    WPXLogv(@"数据库打开失败!!");
    return nil;
}

// 创建表
- (void)createTable:(BOOL)autoincrement
{
    if([_dataBase open])
    {
        WPXLogv(@"数据库打开成功");
        // 创建一张表
        // executeUpdate 可以执行 增 删 改 创建表 (除了查询)
        // blob 是二进制数据
        //NSString *createSql = @"create table if not exists user(id integer primary key autoincrement, name varchar(255), age integer, image blob);";
        NSMutableString *createSql = nil;
        if (autoincrement) {
           createSql = [NSMutableString stringWithFormat:@"create table if not exists %@(%@ integer primary key autoincrement", _tableName, _fieldArray[0]];
        } else {
           createSql = [NSMutableString stringWithFormat:@"create table if not exists %@(%@ integer primary key autoincrement", _tableName, _fieldArray[0]];
        }
        
        for (NSInteger index = 1; index < _fieldArray.count; index++) {
            [createSql appendFormat:@", %@", _fieldArray[index]];
        }
        [createSql appendFormat:@"%@", @")"];
        BOOL isCreated = [_dataBase executeUpdate:createSql];
        if (!isCreated) {
            WPXLogv(@"创建表失败");
            WPXLog(@"error %@", _dataBase.lastErrorMessage);
        }
        [_dataBase close];
    }
}

- (void)getDataBase
{
    NSString *filePath = [NSString stringWithFormat:@"/Documents/%@", _dataBaseName];
    NSString *path = [NSHomeDirectory() stringByAppendingString:filePath];
    _dataBase = [[FMDatabase alloc] initWithPath:path];
}

// 删除数据库
- (void)deleteDatabse
{
    BOOL success;
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
        // delete the old db.
    NSString *filePath = [NSString stringWithFormat:@"/Documents/%@", _dataBaseName];
    NSString *path     = [NSHomeDirectory() stringByAppendingString:filePath];
    NSLog(@"%@", path);
    if ([fileManager fileExistsAtPath:path])
    {
        success = [fileManager removeItemAtPath:path error:&error];
        if (!success) {
            NSAssert1(0, @"删除数据库失败 '%@'.", [error localizedDescription]);
        }
    }
}

// 删除表

- (BOOL) deleteTable
{
    [_dataBase open];
    NSString *sqlstr = [NSString stringWithFormat:@"DROP TABLE %@", _tableName];
    if (![_dataBase executeUpdate:sqlstr])
    {
        WPXLogv(@"删除表失败!");
        return NO;
    }
    [_dataBase close];
    return YES;
}

- (void)dealloc
{
#if ! WPX_AUTORC
    [_dataBaseName release];
    [_tableName    release];
    [_dataBase     release];
    [_fieldArray   release];
    [_varTypeDict  release];
    [super dealloc];
#endif
}

@end
