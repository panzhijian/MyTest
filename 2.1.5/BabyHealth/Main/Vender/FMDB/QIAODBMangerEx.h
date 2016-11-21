//
//  QIAODBMangerEx.h
//  9-19DataBase
//
//  Created by SouHanaQiao on 14-9-19.
//  Copyright (c) 2014年 mac. All rights 葬花桥.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "QiaoMacro.h"

#define NSIntegerType i
#define CGFloatType   f
#define doubleType    d
#define NSStringType  @"@\"NSString\""
#define NSNumberType  @"@\"NSNumber\""
#define NSDataType    @"@\"NSData\""

@interface QIAODBMangerEx : NSObject

- (id)initWithDataBase:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass;

+ (id)managerWithDataBase:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass;

- (id)initWithFirst:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass autoincrement:(BOOL)autoincrement;

- (void)updateDataWithWhereColName:(id)coloName coloName1:(id)coloName1 coloName2:(id)coloName2 coloName3:(id)coloName3 coloName4:(id)coloName4 coloName5:(id)coloName5 coloName6:(id)coloName6 coloName7:(id)coloName7 coloName8:(id)coloName8 value:(id)value value1:(id)value1 value2:(id)value2 value3:(id)value3 value4:(id)value4 value5:(id)value5 value6:(id)value6 value7:(id)value7 value8:(id)value8 whereId:(id)whereId whereValue:(id)whereValue;

+ (id)managerWithFirst:(NSString *)dataBase tableName:(NSString *)table modelClass:(Class)modelClass autoincrement:(BOOL)autoincrement;

- (void)insertDataWithModel:(id)model;

- (void)deleteDataWithPrimaryKey:(id)primaryKey;

- (void)updateDataWithModel:(id)model;

- (id)selectDataWithPrimaryKey:(id)primaryKey;

- (NSArray *)selectWhereAllFromTable:(id)primaryKey :(NSString *)colName;

// 子表数据查询
- (id)selectDataWithColName:(id)primaryKey :(NSString *)colName;

// 查询模糊数据
- (NSArray *)selectWhereLikeAllFromTable:(NSString *)value :(NSString *)oneColName :(NSString *)twoColName :(NSString *)threeColName;

//根据主表id修改数据
- (void)updateDataWithModelWhereColName:(NSString *)model colName:(NSString *)colName colValue:(NSString *)colValue whereValue:(NSString *)whereValue;

// 子表数据查询整形
- (id)selectIntDataWithColName:(id)primaryKey :(id)colName;

// 查询第一条数据
- (NSArray *)selectTopFromTable;

- (NSArray *)selectAllFromTable;

- (void)deleteDatabse;

- (BOOL)deleteTable;

- (void)truacateMyTable;

@end
