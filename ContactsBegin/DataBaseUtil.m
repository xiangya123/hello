//
//  DataBaseUtil.m
//  Contacts
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "DataBaseUtil.h"

@implementation DataBaseUtil
- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
														 NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}
-(void) connectToDB
{
     if (sqlite3_open([[self dataFilePath] UTF8String], &m_database)
		!= SQLITE_OK) {
        sqlite3_close(m_database);
        NSAssert(0, @"Failed to open database");
    }
}
-(sqlite3*) getDatabase
{
    return m_database;
}
-(BOOL) executeSql:(NSString*) strSql
{
    char *errorMsg;

    if (sqlite3_exec (m_database, [strSql UTF8String],
					  NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(m_database);
        NSAssert1(0, @"Error creating table: %s", errorMsg);
        NSLog(@"dd");
        return FALSE;
    }
    return TRUE;
}
-(void) disconnectToDB
{
    sqlite3_close(m_database);
}

@end
