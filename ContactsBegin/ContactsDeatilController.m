//
//  ContactsDeatilController.m
//  ContactsBegin
//
//  Created by lzxer on 12-11-3.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "ContactsDeatilController.h"
#import "ContactsCache.h"
#import "ContactsVo.h"
#import "AddContactsViewController.h"
@interface ContactsDeatilController ()

@end

@implementation ContactsDeatilController
@synthesize  phoneNumberButton;
@synthesize  nameLabel;
@synthesize m_groupTextView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    ContactsCache *cahe=[ContactsCache sharedInstance];
    NSArray *array=[[NSArray alloc] initWithObjects:[cahe getObjectByName:@"detail_name"],nil];
   
    ContactsVo *person=[cahe getObjectByName:@"detail_name"];
    m_textPhone=person.C_PHONE;
    phoneNumberButton.titleLabel.text=m_textPhone;
    nameLabel.text=[[NSString alloc]initWithFormat:@"%@%@",person.C_F_NAME,person.C_S_NAME];
   
    m_groupTextView.text=@"组：";
    m_groupTextView.text=[m_groupTextView.text stringByAppendingString:person.G_NAME];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editButtonPressed:(id)sender {
    ContactsCache *cahe=[ContactsCache sharedInstance];
    NSArray *fileds=[cahe getObjectByName:@"fileds"];
    ContactsVo *person=[cahe getObjectByName:@"detail_name"];
    NSMutableDictionary *nsmd_data=[[NSMutableDictionary alloc]init];
    [nsmd_data setObject:person.C_F_NAME forKey:[fileds objectAtIndex:0]];
    [nsmd_data setObject:person.C_S_NAME forKey:[fileds objectAtIndex:1]];
    [nsmd_data setObject:person.C_MAIL forKey:[fileds objectAtIndex:2]];
    [nsmd_data setObject:person.C_PHONE forKey:[fileds objectAtIndex:3]];
    [nsmd_data setObject:person.C_ADRESS forKey:[fileds objectAtIndex:4]];
    [nsmd_data setObject:person.C_CITY forKey:[fileds objectAtIndex:5]];
    [nsmd_data setObject:person.C_COMPANY forKey:[fileds objectAtIndex:6]];
    [nsmd_data setObject:person.G_NAME forKey:@"G_NAME"];
    [cahe storgeObjectByName:@"nsmd_data" Object:nsmd_data];
    NSString *show=@"HAVE_DATA";
    [cahe storgeObjectByName:@"IS_NULL_DATA" Object:show];
    
    AddContactsViewController *views=[[AddContactsViewController alloc]initWithNibName:@"AddContactsViewController" bundle:nil];
    
   // [self presentViewController:views animated:TRUE completion:];
    [self presentViewController:views animated:TRUE completion:nil];
    

}

- (IBAction)allContactsButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
    
    
}
- (IBAction)pressedPhoneNumberButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"tel://%@",phoneNumberButton.titleLabel.text]]];
   // phoneNumberButton.titleLabel.text=m_textPhone;
    phoneNumberButton.titleLabel.text=m_textPhone;
}
- (IBAction)pressedSendMessageButton:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc]initWithFormat:@"sms://%@",phoneNumberButton.titleLabel.text]]];
//    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"sms://23232"]];
}
@end
