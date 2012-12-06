//
//  AddContacsGroupViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "AddContacsGroupViewController.h"
#import "DataBaseUtil.h"
#import <sqlite3.h>
#import "ViewController.h"
#import "MainViewController.h"
@interface AddContacsGroupViewController ()

@end

@implementation AddContacsGroupViewController
@synthesize company_backupTextFiled;
@synthesize company_nameTextFiled;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //delegate=nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) changeView
{
    
    MainViewController *views=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    UIViewController *rootController;
        
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
        [rootController removeFromParentViewController];
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        
        window.rootViewController=views;
//    [rootController.view addSubview:views.view];
//    [rootController presentModalViewController:views animated:TRUE];
    
}

- (IBAction)menuItemDown:(id)sender {
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util connectToDB];
    char *errorMsg;
    sqlite3 *database=[util getDatabase];
    NSString *company_name=company_nameTextFiled.text;
    NSLog(@"%@",company_name);
    NSString *comapny_backup=company_backupTextFiled.text;
    char* insert_data="INSERT OR REPLACE INTO CONTACS_GROUP_2 (G_NAME,G_BACKTEXT) VALUES (?,?);";
    sqlite3_stmt *stmt;
    
    
    if (sqlite3_prepare_v2(database, insert_data, -1, &stmt, nil)
        == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [company_name UTF8String],-1,NULL);
        sqlite3_bind_text(stmt, 2, [comapny_backup UTF8String], -1, NULL);
       // sqlite3_bind_text(stmt, 3, [@"15116384753" UTF8String],-1,NULL);
    }
    if (sqlite3_step(stmt) != SQLITE_DONE)
    {
        NSAssert1(0, @"Error updating table: %s", errorMsg);
        
    }
    [util disconnectToDB];
    
    if(delegate!=nil)
        [delegate addContacsGroupViewControllerDidFinishAdding:self];
    else
        [self changeView];
    

}
-(void) openEditingTable
{
    
}

@end
