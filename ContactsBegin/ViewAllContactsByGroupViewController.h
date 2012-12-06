//
//  ViewAllContactsByGroupViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-11-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"

@class ContactsVo;
@interface ViewAllContactsByGroupViewController : BaseViewController <HHYoukuMenuViewDelegate,UISearchBarDelegate>
{
    UITableView * tableView;
    NSMutableArray * array_person;
    NSString *m_g_name;
    BOOL isSelectedSearchItem;
    BOOL isSearching;
}
@property (nonatomic,retain)  NSMutableArray * array_person;

@property (nonatomic,retain ) IBOutlet UITableView *tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil g_name:(NSString*)name bundle:(NSBundle *)nibBundleOrNil;
@end
