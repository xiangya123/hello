//
//  BaseViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize youkuMenuView;
- (void)showMeun:(id)sender
{
    UIButton *button = (UIButton *)sender;
    button.hidden = YES;
    [youkuMenuView  showOrHideMenu];
}
- (void)showMeunButton
{
    UIView *button = [self.view viewWithTag:111];
    button.hidden = NO;
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    [super touchesBegan:touches  withEvent:event];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[self.view viewWithTag:SEARCH_BAR] resignFirstResponder];

    
    if (![youkuMenuView  getisMenuHide]&&!scrollView.decelerating)
    {
        [youkuMenuView  showOrHideMenu];
                [self performSelector:@selector(showMeunButton) withObject:nil afterDelay:1];
    }
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    if (![youkuMenuView  getisMenuHide])
    {
        [youkuMenuView  showOrHideMenu];
        [self performSelector:@selector(showMeunButton) withObject:nil afterDelay:1];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    int b_height=460-18;
    UIImage *image = [UIImage imageNamed:@"hidemenu.png"];
    button.frame = CGRectMake(0.0,b_height, 320,17);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showMeun:) forControlEvents:UIControlEventTouchDown];
    button.tag = 111;
    button.hidden=TRUE;
    //    。[self.view adds
    //[m_serach setHidden:true];
    //    [self.view insertSubview:button atIndex:0];
    youkuMenuView = [[HHYoukuMenuView alloc]initWithFrame:[HHYoukuMenuView getFrame]];
    [self.view addSubview:button];
    [self.view addSubview:youkuMenuView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) openEditingTable
{
    
}
@end

