//
//  HHYoukuMenuView.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHYoukuMenuViewDelegate;
#define  kButtonNum  11
@interface HHYoukuMenuView : UIView 
{
    UIImageView *rotationView;
    UIImageView *bgView;
    CGRect rect[kButtonNum];
    NSMutableArray *arrayButtonIcon;
    BOOL rotationViewIsNomal;//NO 为不显示状态 
    BOOL isMenuHide;
    id <HHYoukuMenuViewDelegate> delegate;
   
   // AddContacsGroupViewController *view2;
}
@property (nonatomic, retain)  UIImageView *rotationView;
@property (nonatomic, retain)  UIImageView *bgView;
@property (nonatomic, retain)  NSMutableArray *arrayButtonIcon;
@property (strong,nonatomic)      id <HHYoukuMenuViewDelegate> delegate;
+ (CGRect)getFrame;
- (BOOL)getisMenuHide;
- (void)showOrHideMenu;
- (void)meunButtonDown:(id)sender;
@end
@protocol HHYoukuMenuViewDelegate
-(void) openSearchBar:(HHYoukuMenuView* ) youkuView;
@optional
-(void) openEditingTable;
@end


