//
//  MainViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "MainViewController.h"
#import "ContactsVo.h"
#import "DaoUtil.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        array_person=[DaoUtil findAllContacts];
        youkuMenuView.delegate=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    array_person=[DaoUtil findAllContacts];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [array_person count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *FirstLevelCell= @"FirstLevelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             FirstLevelCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: FirstLevelCell];
    }
    // Configure the cell
    NSUInteger row = [indexPath row];
    //NSUInteger row = [indexPath row];
    ContactsVo *vo=[array_person objectAtIndex:row];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@%@" ,vo.C_F_NAME,vo.C_S_NAME ];
    //cell.imageView.image = controller.rowImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
}
-(void) openSearchBar:(HHYoukuMenuView *)youkuView
{
    isSelectedSearchItem=!isSelectedSearchItem;
    if(isSelectedSearchItem)
    {
        UISearchBar *testbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        testbar.tag=SEARCH_BAR;
        [self.view insertSubview:testbar aboveSubview:tableView];
        
    }
    else
    {
        [[self.view viewWithTag:SEARCH_BAR] removeFromSuperview];
        
    }
    [tableView reloadData];
    
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(isSelectedSearchItem)
        return  44;
    else
        return 0;
}
-(void) openEditingTable
{
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
	
    NSUInteger row = [indexPath row];
    
    ContactsVo *vo=[array_person objectAtIndex:row];
    [DaoUtil deleteContacs:vo.C_F_NAME groupName:nil];
    [array_person removeObject:vo];
    
    [self.tableView reloadData];
    
    
    
}


@end
