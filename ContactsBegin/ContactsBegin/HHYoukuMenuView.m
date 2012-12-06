//
//  HHYoukuMenuView.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "HHYoukuMenuView.h"
#import <QuartzCore/QuartzCore.h>
#import "AddContacsGroupViewController.h"
#import "AddContactsViewController.h"
#import "ViewController.h"
#import "ContactsCompanyViewController.h"
#import "ContactsGroupViewController.h"
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)


@implementation HHYoukuMenuView
@synthesize rotationView,arrayButtonIcon,bgView;
@synthesize delegate;

- (void)dealloc
{
}

+ (CGRect)getFrame
{
    return CGRectMake((320.0 - 296.0)/2.0,460.0 - 148.0 + 14,296.0,148.0);
}

+ (CGRect)getHideFrame
{
    return CGRectMake((320.0 - 296.0)/2.0,460.0,296.0,148.0);
}

- (void)setButtonsFrame
{
    rect[0] =  CGRectMake(251,93,25,25);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m1.png",@"nomal",
                         @"m1h.png",@"high",nil];

    [arrayButtonIcon addObject:dic];
    
    rect[1] =  CGRectMake(186,22,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m2.png",@"nomal",
           @"m3h.png",@"high",nil];
    [arrayButtonIcon addObject:dic];

    rect[2] =  CGRectMake(85,22,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m3.png",@"nomal",
           @"m3h.png",@"high",nil];
    [arrayButtonIcon addObject:dic];

    
    rect[3] =  CGRectMake(18,93,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m4.png",@"nomal",
           @"m4h.png",@"high",nil];

    [arrayButtonIcon addObject:dic];
    
    //////////////////////////////////////////////////////////////////////////////
    
    rect[4] =  CGRectMake(207,103,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m5.png",@"nomal",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[5] =  CGRectMake(136,54,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m6.png",@"nomal",nil];
    [arrayButtonIcon addObject:dic];
    
    rect[6] =  CGRectMake(63,103,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m7.png",@"nomal",nil];
    [arrayButtonIcon addObject:dic];
    
    ///////////////////////////////////////////////////////////////////////////////
    rect[7] =  CGRectMake(134,103,25,25);
    dic = [NSDictionary dictionaryWithObjectsAndKeys:@"m8.png",@"nomal",
           @"m8l.png",@"high",nil];
    [arrayButtonIcon addObject:dic];
}

- (void)initView
{
    bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu1.png"]];
    bgView.frame = CGRectMake(53.0,49.0,191.0, 86.0);
    [self addSubview:bgView];
      
    rotationView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"menu2.png"]];
    rotationView.frame = CGRectMake(0.0, 0.0+ 148.0/2.0,296, 148);
    rotationView.userInteractionEnabled = YES;
    rotationView.layer.anchorPoint = CGPointMake(0.5,1.0);
    if (rotationViewIsNomal)
    {
        rotationView.layer.transform = CATransform3DIdentity;
      
    }
    else
    {
        rotationView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(180),0.0, 0.0, 1.0);;
    }
    [self addSubview:rotationView];
   
    
    for (int i = 0;i<4;i++)
    {
        NSDictionary *dic = [arrayButtonIcon objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect[i];
        if ([dic objectForKey:@"nomal"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"nomal"]] forState:UIControlStateNormal];
        }
        if ([dic objectForKey:@"high"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"high"]] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(meunButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.showsTouchWhenHighlighted = YES;
        [rotationView  addSubview:button];
    }
    
    for (int i = 4;i < 8 ;i++ )
    {
        NSDictionary *dic = [arrayButtonIcon objectAtIndex:i];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = rect[i];
        if ([dic objectForKey:@"nomal"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"nomal"]] forState:UIControlStateNormal];
        }
        if ([dic objectForKey:@"high"])
        {
            [button setImage:[UIImage imageNamed:[dic objectForKey:@"high"]] forState:UIControlStateHighlighted];
        }
        [button addTarget:self action:@selector(meunButtonDown:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        button.showsTouchWhenHighlighted = YES;
        [self  addSubview:button];
    }
}
-(void) changeView:(UIView* )view
{
    AddContacsGroupViewController *views=[[AddContacsGroupViewController alloc]initWithNibName:@"AddContacsGroupViewController" bundle:nil];
        
//    UIViewController *rootController;
//    
//    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
//    views.delegate=self;
//    
//    [rootController presentModalViewController:views animated:TRUE];

    UIViewController *rootController;
    
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;

    [rootController removeFromParentViewController];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=views;
   // [rootController presentViewController:views animated:YES completion:nil];
}
-(void) changeViewAddContacts
{
    AddContactsViewController *views=[[AddContactsViewController alloc]initWithNibName:@"AddContactsViewController" bundle:nil];
    UIViewController *rootController;
    
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController removeFromParentViewController];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=views;
}
-(void) changeViewGroupDetail
{
    ContactsGroupViewController *views=[[ContactsGroupViewController alloc]initWithNibName:@"ContactsGroupViewController" bundle:nil];
    UIViewController *rootController;
    
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController removeFromParentViewController];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=views;

    
}
-(void) changeMainView
{
    ViewController *views=[[ViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    UIViewController *rootController;
    
    
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController removeFromParentViewController];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=views;

}
-(void) showButton
{
    BaseViewController *rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController showMeunButton];

}
-(void) hideView
{
    
    [self showOrHideMenu];
    [self performSelector:@selector(showButton) withObject:nil afterDelay:1];
        
}
-(void) openSerchBar
{
    [delegate openSearchBar:self];
    
    
}

- (void)meunButtonDown:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //NSLog("",button.tag)
    //cout<<button.tag<<endl;

    switch (button.tag) {
        case 7:
            [self changeMainView];
            break;
        case 6:
            [self openSerchBar];
            break;
        case 5:
            button.userInteractionEnabled = NO;
            [UIView beginAnimations:@"present-countdown" context:nil];
            [UIView setAnimationDuration:1];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDidStopSelector:@selector(rotationAnimationStop)];
            CGFloat angle = rotationViewIsNomal ? 180.0:0.0;
            rotationView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(angle),0.0, 0.0, 1.0);
            [UIView commitAnimations];
    
            break;
        case 4:
            
            [delegate openEditingTable];
            break;
        case 3:
            [self changeView:self];
            
            break;
        case 2:
            [self changeViewAddContacts];
            
            break;
        case 1:
            [self changeViewGroupDetail];
            break;
        case 0:
            break;
            
        default:
            break;
    }
    
    
}

- (void)rotationAnimationStop
{
    UIButton *menuButton =  (UIButton *)[self viewWithTag:5];
    menuButton.userInteractionEnabled = YES;
    rotationViewIsNomal = !rotationViewIsNomal;
}

- (void)hideMenuAnimationStop
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        rotationViewIsNomal = NO;
        isMenuHide = NO;
        arrayButtonIcon = [[NSMutableArray alloc]init];
        [self setButtonsFrame];
        [self initView];
    }
    return self;
}

- (void)showOrHideMenu
{
    //kIsAdShow;
    [UIView beginAnimations:@"present-countdown" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(hideMenuAnimationStop)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    if (!isMenuHide) 
    {
        self.frame = [HHYoukuMenuView getHideFrame];
    }
    else
    {
        self.frame = [HHYoukuMenuView getFrame];
    }
    isMenuHide = !isMenuHide;
    [UIView commitAnimations];
}

- (BOOL)getisMenuHide
{
    return isMenuHide;
}


@end
