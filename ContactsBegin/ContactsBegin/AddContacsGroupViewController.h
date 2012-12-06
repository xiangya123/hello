//
//  AddContacsGroupViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@protocol AddContacsGroupViewControllerDelegate; // AddViewControllerDelegate protocol

@interface AddContacsGroupViewController : BaseViewController
{
    UITextField *company_nameTextFiled;
    UITextField *company_backupTextFiled;
    id <AddContacsGroupViewControllerDelegate> delegate;
}

@property (strong, nonatomic) IBOutlet UITextField *company_nameTextFiled;
@property (strong, nonatomic) IBOutlet UITextField *company_backupTextFiled;
@property (strong,nonatomic) id <AddContacsGroupViewControllerDelegate> delegate;
@end
@protocol AddContacsGroupViewControllerDelegate
- (void)addContacsGroupViewControllerDidFinishAdding:(AddContacsGroupViewController *)controller; // end protocol AddViewControllerDelegate
@end

