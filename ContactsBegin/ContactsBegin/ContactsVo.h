//
//  ContactsVo.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-30.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <Foundation/Foundation.h>
#define CONTACTS_TABLE_NAME @"CONTACS_INF3"
@interface ContactsVo : NSObject
{
//    C_ID INT PRIMARY KEY,C_F_NAME TEXT,C_PHONE TEXT,C_S_NAME TEXT,C_ADRESS TEXT,C_COMPANY TEXT,G_ID INT,IMAGE_INF TEXT,FOREIGN KEY(G_ID) REFERENCES CONTACS_GROUP(G_ID));"
    int16_t C_ID;
    NSString *C_F_NAME;
    NSString *C_PHONE;
    NSString *C_S_NAME;
    NSString *C_ADRESS;
    NSString *C_COMPANY;
    NSString *C_CITY;
    NSString *C_MAIL;
    NSString *G_NAME;
    NSString *IMAGE_INF;
}
//@property (nonatomic,retain) int16_t C_ID;
@property (nonatomic,retain) NSString *C_F_NAME;
@property (nonatomic,retain) NSString *C_PHONE;
@property (nonatomic,retain) NSString *C_S_NAME;
@property (nonatomic,retain) NSString *C_ADRESS;
@property (nonatomic,retain) NSString *C_COMPANY;
//@property (nonatomic,retain) int16_t G_ID;
@property (nonatomic,retain) NSString *G_NAME;
@property (nonatomic,retain) NSString *C_CITY;
@property (nonatomic,retain) NSString *IMAGE_INF;
@property (nonatomic,retain) NSString *C_MAIL;

-(int16_t) getG_ID;
-(void) setG_ID:(int16_t) g_id;


@end