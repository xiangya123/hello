//
//  ContactsDeatilController.h
//  ContactsBegin
//
//  Created by lzxer on 12-11-3.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"

@interface ContactsDeatilController : BaseViewController
{
    IBOutlet UIButton *phoneNumberButton;
    UILabel *nameLabel;
    IBOutlet UILabel *m_groupTextView;
    NSString *m_textPhone;
    
}


- (IBAction)editButtonPressed:(id)sender;
- (IBAction)allContactsButtonPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *phoneNumberButton;
- (IBAction)pressedPhoneNumberButton:(id)sender;
//@property (strong, nonatomic) IBOutlet UIButton *sendMessageButton;
- (IBAction)pressedSendMessageButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *pictureView;
@property (retain, nonatomic) IBOutlet UILabel *m_groupTextView;

@end
