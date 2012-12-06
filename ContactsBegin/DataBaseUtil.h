//
//  DataBaseUtil.h
//  Contacts
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>
#define kFilename @"data.sqlite3"
@interface DataBaseUtil : NSObject
{
    sqlite3 *m_database;
}
-(void) connectToDB;
-(void) disconnectToDB;
-(NSString*) dataFilePath;
-(sqlite3*) getDatabase;
-(BOOL) executeSql:(NSString*) StrSql;
@end
