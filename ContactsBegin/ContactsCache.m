//
//  ContactsCache.m
//  ContactsBegin
//
//  Created by lzxer on 12-11-3.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "ContactsCache.h"

@implementation ContactsCache
{
    
    
}

static ContactsCache *sharedInstance = nil;
- (id)init {
    self = [super init];
    if (self) {
        nsd_data=[[NSMutableDictionary alloc]init];
    }
    return self;
}

+ (ContactsCache *)sharedInstance
{
    
    if (sharedInstance == nil) {
        sharedInstance = [[super alloc] init];
    }
    return sharedInstance;
}

-(void) storgeObjectByName:(NSString* )name Object:(id) object
{
    [nsd_data setObject:object forKey:name];
    
}
-(id) getObjectByName:(NSString *)name
{
    return [nsd_data objectForKey:name];
}

@end
