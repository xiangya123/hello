//
//  ContactsCache.h
//  ContactsBegin
//
//  Created by lzxer on 12-11-3.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContactsCache : NSObject
{
    NSMutableDictionary *nsd_data;
}
+ (ContactsCache *)sharedInstance;
-(void) storgeObjectByName:(NSString* )name Object:(id) object;
-(id)   getObjectByName:(NSString *) name;
@end
