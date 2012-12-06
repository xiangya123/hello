//
//  DaoUtil.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-31.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ContactsVo;
@interface DaoUtil : NSObject
+(BOOL) addContacts:(ContactsVo*) vo;
+(NSMutableArray*) findAllContacts;
+(NSMutableArray*) findContactsByName:(NSString*) name;
+(NSMutableArray*) findAllGroups;
+(NSMutableArray*) findAllGroupsByName:(NSString*) name;
+(NSMutableArray *) findAllContactsByGroupName:(NSString*)g_name;
+(NSMutableArray *) findContactsByNameAndGroupName:(NSString *)name groupName:(NSString*) g_name;

+(BOOL) deleteGroup:(NSString*) g_name;
+(BOOL) deleteContacs:(NSString*)
        c_name groupName:(NSString*) g_name;


@end
