//
//  ViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class ContactsVo;
@interface ViewController : BaseViewController <HHYoukuMenuViewDelegate,UISearchBarDelegate>
{
    UITableView * tableView;
    NSMutableArray * array_person;
    BOOL isSelectedSearchItem;
    BOOL isSearching;
}
@property (nonatomic,retain)  NSMutableArray * array_person;

@property (nonatomic,retain ) IBOutlet UITableView *tableView;


@end
