//
//  DaoUtil.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-31.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "DaoUtil.h"
#import "ContactsVo.h"
#import "DataBaseUtil.h"
@implementation DaoUtil
+(BOOL) addContacts:(ContactsVo *) vo;
{
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util  connectToDB];


    char* insert_data=[[[NSString alloc]initWithFormat:@"INSERT OR REPLACE INTO %@  (C_F_NAME,C_PHONE,C_MAIL,C_S_NAME,C_ADRESS,C_COMPANY,G_NAME,C_CITY,IMAGE_INF) VALUES (?,?,?,?,?,?,?,?,?);",CONTACTS_TABLE_NAME] UTF8String];
    sqlite3_stmt *stmt;
    char *errorMsg=nil;
    if (sqlite3_prepare_v2([util getDatabase], insert_data, -1, &stmt, nil)
       == SQLITE_OK)
    {
        sqlite3_bind_text(stmt, 1, [vo.C_F_NAME UTF8String],-1,NULL);
        sqlite3_bind_text(stmt, 2, [vo.C_PHONE UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [vo.C_MAIL UTF8String], -1, NULL);
        sqlite3_bind_text(stmt,4, [vo.C_S_NAME UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 5, [vo.C_ADRESS UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 6, [vo.C_COMPANY UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 7, [vo.G_NAME UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 8, [vo.C_CITY UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 9, [vo.IMAGE_INF UTF8String], -1, NULL);
        // sqlite3_bind_text(stmt, 3, [@"15116384753" UTF8String],-1,NULL);
    }else
    {
        return false;
    }
    if (sqlite3_step(stmt) != SQLITE_DONE)
    {
        NSAssert1(0, @"Error updating table: %s", errorMsg);
        return false;
    }
    [util disconnectToDB];
    return true;
}
+(NSMutableArray *) findAllContacts
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util  connectToDB];
    
    char* query_SQL=[[[NSString alloc]initWithFormat:@"SELECT * FROM %@ ORDER BY C_F_NAME",CONTACTS_TABLE_NAME] UTF8String];
    sqlite3_stmt *stmt;
    char *errorMsg=nil;
    if (sqlite3_prepare_v2([util getDatabase], query_SQL,
						   -1, &stmt, nil) == SQLITE_OK){
        while(sqlite3_step(stmt)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            ContactsVo * vo=[[ContactsVo alloc]init];
            
            //    @"CREATE TABLE IF NOT EXISTS CONTACS_INF1 (C_ID INT PRIMARY KEY,C_F_NAME TEXT,C_PHONE TEXT,C_MAIL TEXT,C_S_NAME TEXT,C_ADRESS TEXT,C_COMPANY TEXT,G_NAME TEXT,IMAGE_INF TEXT,FOREIGN KEY(G_NAME) REFERENCES CONTACS_GROUP(G_NAME));";
            vo.C_F_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 0) encoding:NSUTF8StringEncoding ];
            vo.C_PHONE=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding ];
            vo.C_MAIL=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 2) encoding:NSUTF8StringEncoding ];
            vo.C_S_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 3) encoding:NSUTF8StringEncoding ];
            vo.C_ADRESS=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 4) encoding:NSUTF8StringEncoding ];
            vo.C_COMPANY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 5) encoding:NSUTF8StringEncoding ];
            vo.G_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 6) encoding:NSUTF8StringEncoding ];
            vo.C_CITY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 7) encoding:NSUTF8StringEncoding ];
            
            //vo.IMAGE_INF=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 8) encoding:NSUTF8StringEncoding ];
            [array addObject:vo];
            
        }
    }
    [util disconnectToDB];

    return array;
    
}
+(NSMutableArray *) findAllContactsByGroupName:(NSString*)g_name
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util  connectToDB];
    //NSString* ns_g_name=[[NSString alloc]ini];
    
    
    

    char* query_SQL=[[[NSString alloc]initWithFormat:@"SELECT * FROM %@ where G_NAME='%@' ORDER BY C_F_NAME",CONTACTS_TABLE_NAME,g_name] UTF8String];
    sqlite3_stmt *stmt;
    NSLog(@"%s",query_SQL);
    char *errorMsg=nil;
    if (sqlite3_prepare_v2([util getDatabase], query_SQL,
						   -1, &stmt, nil) == SQLITE_OK){
        while(sqlite3_step(stmt)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            ContactsVo * vo=[[ContactsVo alloc]init];
            
            //    @"CREATE TABLE IF NOT EXISTS CONTACS_INF1 (C_ID INT PRIMARY KEY,C_F_NAME TEXT,C_PHONE TEXT,C_MAIL TEXT,C_S_NAME TEXT,C_ADRESS TEXT,C_COMPANY TEXT,G_NAME TEXT,IMAGE_INF TEXT,FOREIGN KEY(G_NAME) REFERENCES CONTACS_GROUP(G_NAME));";
            vo.C_F_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 0) encoding:NSUTF8StringEncoding ];
            vo.C_PHONE=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding ];
            vo.C_MAIL=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 2) encoding:NSUTF8StringEncoding ];
            vo.C_S_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 3) encoding:NSUTF8StringEncoding ];
            vo.C_ADRESS=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 4) encoding:NSUTF8StringEncoding ];
            vo.C_COMPANY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 5) encoding:NSUTF8StringEncoding ];
            vo.G_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 6) encoding:NSUTF8StringEncoding ];
            vo.C_CITY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 7) encoding:NSUTF8StringEncoding ];
            
            //vo.IMAGE_INF=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 8) encoding:NSUTF8StringEncoding ];
            [array addObject:vo];
            
        }
    }
    [util disconnectToDB];

    return array;
    
}
+(NSMutableArray *) findContactsByNameAndGroupName:(NSString *)name groupName:(NSString*) g_name
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util  connectToDB];
    
    char* query_SQL=[[[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE C_F_NAME like '%@%@' and G_NAME='%@' ORDER BY C_F_NAME ",CONTACTS_TABLE_NAME,name,@"%",g_name] UTF8String];
    NSLog(@"%s",query_SQL);
    sqlite3_stmt *stmt;
    char *errorMsg=nil;
    if (sqlite3_prepare_v2([util getDatabase], query_SQL,
						   -1, &stmt, nil) == SQLITE_OK){
        while(sqlite3_step(stmt)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            ContactsVo * vo=[[ContactsVo alloc]init];
            
            //    @"CREATE TABLE IF NOT EXISTS CONTACS_INF1 (C_ID INT PRIMARY KEY,C_F_NAME TEXT,C_PHONE TEXT,C_MAIL TEXT,C_S_NAME TEXT,C_ADRESS TEXT,C_COMPANY TEXT,G_NAME TEXT,IMAGE_INF TEXT,FOREIGN KEY(G_NAME) REFERENCES CONTACS_GROUP(G_NAME));";
            vo.C_F_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 0) encoding:NSUTF8StringEncoding ];
            vo.C_PHONE=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding ];
            vo.C_MAIL=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 2) encoding:NSUTF8StringEncoding ];
            vo.C_S_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 3) encoding:NSUTF8StringEncoding ];
            vo.C_ADRESS=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 4) encoding:NSUTF8StringEncoding ];
            vo.C_COMPANY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 5) encoding:NSUTF8StringEncoding ];
            vo.G_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 6) encoding:NSUTF8StringEncoding ];
            vo.C_CITY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 7) encoding:NSUTF8StringEncoding ];
            
            //vo.IMAGE_INF=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 8) encoding:NSUTF8StringEncoding ];
            [array addObject:vo];
            
        }
    }
    return array;
    
}

+(NSMutableArray *) findContactsByName:(NSString *)name
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util  connectToDB];
    
    char* query_SQL=[[[NSString alloc]initWithFormat:@"SELECT * FROM %@ WHERE C_F_NAME like '%@%@' ORDER BY C_F_NAME ",CONTACTS_TABLE_NAME,name,@"%"] UTF8String];
    NSLog(@"%s",query_SQL);
    sqlite3_stmt *stmt;
    char *errorMsg=nil;
    if (sqlite3_prepare_v2([util getDatabase], query_SQL,
						   -1, &stmt, nil) == SQLITE_OK){
        while(sqlite3_step(stmt)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            ContactsVo * vo=[[ContactsVo alloc]init];
            
            //    @"CREATE TABLE IF NOT EXISTS CONTACS_INF1 (C_ID INT PRIMARY KEY,C_F_NAME TEXT,C_PHONE TEXT,C_MAIL TEXT,C_S_NAME TEXT,C_ADRESS TEXT,C_COMPANY TEXT,G_NAME TEXT,IMAGE_INF TEXT,FOREIGN KEY(G_NAME) REFERENCES CONTACS_GROUP(G_NAME));";
            vo.C_F_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 0) encoding:NSUTF8StringEncoding ];
            vo.C_PHONE=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 1) encoding:NSUTF8StringEncoding ];
            vo.C_MAIL=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 2) encoding:NSUTF8StringEncoding ];
            vo.C_S_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 3) encoding:NSUTF8StringEncoding ];
            vo.C_ADRESS=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 4) encoding:NSUTF8StringEncoding ];
            vo.C_COMPANY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 5) encoding:NSUTF8StringEncoding ];
            vo.G_NAME=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 6) encoding:NSUTF8StringEncoding ];
            vo.C_CITY=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 7) encoding:NSUTF8StringEncoding ];
            
            //vo.IMAGE_INF=[[NSString alloc]initWithCString:sqlite3_column_text(stmt, 8) encoding:NSUTF8StringEncoding ];
            [array addObject:vo];
            
        }
    }
    [util disconnectToDB];

    return array;
    
}

+(NSMutableArray*) findAllGroups
{
    NSMutableArray *array;
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util connectToDB];
    NSString *queryGroup=[[NSString alloc] initWithFormat:@"SELECT * FROM CONTACS_GROUP_2"];
    sqlite3_stmt *statement;
    array=[[NSMutableArray alloc]init];
    if (sqlite3_prepare_v2([util getDatabase], [queryGroup UTF8String],
						   -1, &statement, nil) == SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            char* g_name= sqlite3_column_text(statement, 0);
            char* g_backinf=sqlite3_column_text(statement, 1);
            
            //NSString *g_s_name=[[NSString alloc]initWithFormat:@"%s",g_name];
            NSString *g_s_name=[[NSString alloc] initWithCString:g_name encoding:NSUTF8StringEncoding];
            ///NSLog(@"%@  ssss",g_s_name);
            [array addObject: g_s_name];
            // [array setValue:<#(id)#> forKey:<#(NSString *)#>]
        }
    }
    [util disconnectToDB];

    return array;
}

+(NSMutableArray*) findAllGroupsByName:(NSString *)name
{
    NSMutableArray *array;
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util connectToDB];
    NSString *queryGroup=[[NSString alloc] initWithFormat:@"SELECT * FROM CONTACS_GROUP_2 WHERE G_NAME LIKE '%@%@'",name,@"%"];
    NSLog(@"%@",queryGroup);
    sqlite3_stmt *statement;
    array=[[NSMutableArray alloc]init];
    if (sqlite3_prepare_v2([util getDatabase], [queryGroup UTF8String],
						   -1, &statement, nil) == SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            char* g_name= sqlite3_column_text(statement, 0);
            char* g_backinf=sqlite3_column_text(statement, 1);
            
            //NSString *g_s_name=[[NSString alloc]initWithFormat:@"%s",g_name];
            NSString *g_s_name=[[NSString alloc] initWithCString:g_name encoding:NSUTF8StringEncoding];
            ///NSLog(@"%@  ssss",g_s_name);
            [array addObject: g_s_name];
            // [array setValue:<#(id)#> forKey:<#(NSString *)#>]
        }
    }
    [util disconnectToDB];

    return array;

}
+(BOOL) deleteGroup:(NSString *)g_name
{
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    NSString *delStringSql=[[NSString alloc]initWithFormat:@"DELETE FROM CONTACS_GROUP_2 WHERE G_NAME='%@' ",g_name];
    NSLog(@"%@",delStringSql);
    [util connectToDB];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([util getDatabase], [delStringSql UTF8String],
                          -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) != SQLITE_DONE)
        {
            
            
            
            [util disconnectToDB];
            
            return false;
            
        }else
        {
            [util disconnectToDB];
            [DaoUtil deleteContacs:nil groupName:g_name];
            return true;
        }
        
        
    }
    [util disconnectToDB];
    return false;
}
+(BOOL) deleteContacs:(NSString*)
    c_name groupName:(NSString*) g_name
{
    
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    NSString *delStringSql;
    if(g_name!=nil)
        delStringSql=[[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE G_NAME='%@' ",CONTACTS_TABLE_NAME,g_name];
    else
        delStringSql=[[NSString alloc]initWithFormat:@"DELETE FROM %@ WHERE  C_F_NAME='%@' ",CONTACTS_TABLE_NAME,c_name];
    NSLog(@"%@",delStringSql);
    [util connectToDB];
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2([util getDatabase], [delStringSql UTF8String],
                          -1, &statement, nil) == SQLITE_OK)
    {
        if (sqlite3_step(statement) != SQLITE_DONE)
        {
            [util disconnectToDB];
            return false;
            
        }else
        {
            [util disconnectToDB];
            
            return true;
        }
        
        
    }
    [util disconnectToDB];
    return false;

}

@end
