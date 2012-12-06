//
//  ViewAllContactsByGroupViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-11-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "ViewAllContactsByGroupViewController.h"
#import "DaoUtil.h"
#import "ContactsVo.h"
#import "ContactsDeatilController.h"
#import "ContactsCache.h"
@interface ViewAllContactsByGroupViewController ()

@end

@implementation ViewAllContactsByGroupViewController
@synthesize tableView;
@synthesize array_person;

- (id)initWithNibName:(NSString *)nibNameOrNil g_name:(NSString*)name bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        m_g_name=name;
        array_person=[DaoUtil findAllContactsByGroupName:name];
                
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //array_person=[DaoUtil findAllContacts];
    //youkuMenuView.delegate=self;
    youkuMenuView.delegate=self;

    isSelectedSearchItem=FALSE;
    [tableView setTag:TABLE_NAME_TAG];
    NSArray *fields = [[NSArray alloc] initWithObjects:@"姓", @"名字",@"邮箱",
                       @"电话号码",@"地址", @"所在城市", @"公司", nil];
    ContactsCache *cahe=[ContactsCache sharedInstance];
    [cahe storgeObjectByName:@"fileds" Object:fields];
    
    UITextView *textView=[[UITextView alloc] initWithFrame:CGRectMake(0,0,320,44)];
    textView.text=@"组：";
    //[textView.text stringByAppendingString:m_g_name];
    textView.text=[textView.text stringByAppendingString:m_g_name];
    NSLog(@"%@    %@",m_g_name,textView.text);
    UIFont *font=[UIFont systemFontOfSize:20];
    
    
    [textView setFont:font];
    [textView setEditable:false];
    [self.view insertSubview:textView aboveSubview:tableView];
    
    
    
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
        UISearchBar *serachBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,44,320,44)];
        
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
        return  44+44;
    else
        return 44;
}
-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    isSearching=TRUE;
    [tableView reloadData];
}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@\n",searchText);
    if([searchText length]!=0)
        array_person=[DaoUtil findContactsByNameAndGroupName:searchText groupName:m_g_name];
    else
        array_person=[DaoUtil findAllContactsByGroupName:m_g_name];
    [tableView reloadData];
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar.text length]!=0)
        array_person=[DaoUtil findContactsByNameAndGroupName:searchBar.text groupName:m_g_name];
    else
        array_person=[DaoUtil findAllContactsByGroupName:m_g_name];
    [tableView reloadData];
    [searchBar resignFirstResponder];
    
}
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(void) openEditingTable
{
    
}

@end
