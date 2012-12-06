//
//  BaseViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHYoukuMenuView.h"
static const TABLE_NAME_TAG=115;
static const SEARCH_BAR=116;
@interface BaseViewController : UIViewController
{
    HHYoukuMenuView *youkuMenuView;
}
@property (nonatomic, retain) HHYoukuMenuView *youkuMenuView;
-(void) showMeun:(id)sender;
- (void) showMeunButton;
@end
