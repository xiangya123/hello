//
//  AppDelegate.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "AppDelegate.h"
#import "DataBaseUtil.h"
#import "ContactsVo.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util connectToDB];
    
        NSString *createSQL = @"CREATE TABLE IF NOT EXISTS CONTACS_GROUP_2 (G_NAME TEXT PRIMARY KEY,G_BACKTEXT TEXT);";
    if(![util executeSql:createSQL])
        NSAssert(0, @"Failed to excute SQL");

    NSString *createContacsSQL=[[NSString alloc]initWithFormat:@"CREATE TABLE IF NOT EXISTS %@  (C_F_NAME TEXT PRIMARY KEY,C_PHONE TEXT,C_MAIL TEXT,C_S_NAME TEXT,C_ADRESS TEXT,C_COMPANY TEXT,G_NAME TEXT,C_CITY TEXT,IMAGE_INF TEXT);",CONTACTS_TABLE_NAME];
    if(![util executeSql:createContacsSQL])
        NSAssert(0, @"Failed to excute SQL");
    [util disconnectToDB];
    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

@end
