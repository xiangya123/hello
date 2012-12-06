//
//  ViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-11-28.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactsCompanyViewController : BaseViewController<HHYoukuMenuViewDelegate,UISearchBarDelegate>
{
    NSMutableArray *array;   //this is use for ContactsCompany Objects
    IBOutlet UITableView *m_tableView;
    bool isSelectedSearchItem;
}
@property (retain,nonatomic) NSMutableArray *array; 
@property (nonatomic,retain ) IBOutlet UITableView *m_tableView;
-(IBAction)pressBackButton:(id)sender;
@end
