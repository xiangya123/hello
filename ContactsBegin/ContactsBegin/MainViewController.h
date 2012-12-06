//
//  MainViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"
@interface MainViewController : BaseViewController<HHYoukuMenuViewDelegate>
{
    UITableView * tableView;
    NSMutableArray * array_person;
    BOOL isSelectedSearchItem;
}

@property (nonatomic,retain ) IBOutlet UITableView *tableView;

@end
