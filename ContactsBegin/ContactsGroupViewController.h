//
//  ContactsGroupViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-11-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactsGroupViewController : BaseViewController<HHYoukuMenuViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *array;   //this is use for ContactsCompany Objects
    IBOutlet UITableView *m_tableView;
    bool isSelectedSearchItem;
}
- (IBAction)pressBackItem:(id)sender;
@property (retain,nonatomic) NSMutableArray *array;
@property (nonatomic,retain ) IBOutlet UITableView *m_tableView;
-(IBAction)clickEdingItem:(id)sender;
@end
