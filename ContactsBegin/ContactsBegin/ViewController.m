//
//  ViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "ViewController.h"
#import "DaoUtil.h"
#import "ContactsVo.h"
#import "ContactsDeatilController.h"
#import "ContactsCache.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize tableView;
@synthesize array_person;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    array_person=[DaoUtil findAllContacts];
    youkuMenuView.delegate=self;
    isSelectedSearchItem=FALSE;
    [tableView setTag:TABLE_NAME_TAG];
    NSArray *fields = [[NSArray alloc] initWithObjects:@"姓", @"名字",@"邮箱",
              @"电话号码",@"地址", @"所在城市", @"公司", nil];
    ContactsCache *cahe=[ContactsCache sharedInstance];
    [cahe storgeObjectByName:@"fileds" Object:fields];
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
    ContactsDeatilController *views=[[ContactsDeatilController alloc]initWithNibName:@"ContactsDeatilController" bundle:nil];
    
    ContactsCache *cache=[ContactsCache sharedInstance];
    [cache storgeObjectByName:@"detail_name" Object:[array_person objectAtIndex:row ]];
    [self presentViewController:views animated:TRUE completion:nil];
    
}
-(void) openSearchBar:(HHYoukuMenuView *)youkuView
{
    isSelectedSearchItem=!isSelectedSearchItem;
    if(isSelectedSearchItem)
    {
        UISearchBar *serachBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        
        serachBar.tag=SEARCH_BAR;
        serachBar.delegate=self;
        [self.view insertSubview:serachBar aboveSubview:tableView];
        
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
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //array_person=[DaoUtil findContactsByName:searchBar.text];
    isSearching=TRUE;
    [tableView reloadData];
}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@\n",searchText);
    if([searchText length]!=0)
        array_person=[DaoUtil findContactsByName:searchText];
    else
        array_person=[DaoUtil findAllContacts];
    [tableView reloadData];
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar.text length]!=0)
        array_person=[DaoUtil findContactsByName:searchBar.text];
    else
        array_person=[DaoUtil findAllContacts];
    [tableView reloadData];
    [searchBar resignFirstResponder];
    
}
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
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
