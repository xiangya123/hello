//
//  ViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-11-28.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "ContactsCompanyViewController.h"
#import "DataBaseUtil.h"
#import "ContactsVo.h"
#import "DaoUtil.h"
@interface ContactsCompanyViewController ()

@end

@implementation ContactsCompanyViewController
@synthesize array;
@synthesize m_tableView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self queryGroupFromData];
        
        youkuMenuView.delegate=self;
        isSelectedSearchItem=FALSE;

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    youkuMenuView.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) queryGroupFromData
{
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util connectToDB];
    NSString *queryGroup=[[NSString alloc] initWithFormat:@"SELECT * FROM CONTACS_GROUP_2"];
    sqlite3_stmt *statement;
    array=[[NSMutableArray alloc]init];
    if (sqlite3_prepare_v2([util getDatabase], [queryGroup UTF8String],
						   -1, &statement, nil) == SQLITE_OK){
        while(sqlite3_step(statement)==SQLITE_ROW)
        {
            //            int row = sqlite3_column_int(statement,0);
            char* g_name= sqlite3_column_text(statement, 0);
            char* g_backinf=sqlite3_column_text(statement, 1);
            
            //NSString *g_s_name=[[NSString alloc]initWithFormat:@"%s",g_name];
            NSString *g_s_name=[[NSString alloc] initWithCString:g_name encoding:NSUTF8StringEncoding];
            ///NSLog(@"%@  ssss",g_s_name);
            [array addObject: g_s_name];
            // [array setValue:<#(id)#> forKey:<#(NSString *)#>]
        }
    }
}
#pragma mark -
#pragma mark Table View Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(isSelectedSearchItem)
        return  44;
    else
        return 0;
}
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    
    return [array count];
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *FirstLevelCell= @"ContactsGroup";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             FirstLevelCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier: FirstLevelCell];
    }
    // Configure the cell
    NSUInteger row = [indexPath row];
    NSString *g_name=[array objectAtIndex:row];
    cell.textLabel.text = [[NSString alloc] initWithFormat:@"%@",g_name ];
    //cell.imageView.image = controller.rowImage;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void) openSearchBar:(HHYoukuMenuView *)youkuView
{
    isSelectedSearchItem=!isSelectedSearchItem;
    if(isSelectedSearchItem)
    {
        UISearchBar *serachBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0,320,44)];
        
        serachBar.tag=SEARCH_BAR+1;
        serachBar.delegate=self;
        [self.view insertSubview:serachBar aboveSubview:m_tableView];
        
    }

    else
    {
        [[self.view viewWithTag:SEARCH_BAR+1] removeFromSuperview];
        
    }
    [m_tableView reloadData];
    
    
    
}


-(void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //array_person=[DaoUtil findContactsByName:searchBar.text];
    //isSearching=TRUE;
    [m_tableView reloadData];
}
-(void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@\n",searchText);
    if([searchText length]!=0)
        array=[DaoUtil findAllGroupsByName:searchText];
    else
        array=[DaoUtil findAllGroups];
    [m_tableView reloadData];
}
-(void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if([searchBar.text length]!=0)
        array=[DaoUtil findAllGroupsByName:searchBar.text];
    else
        array=[DaoUtil findAllGroups];
    [m_tableView reloadData];
    [searchBar resignFirstResponder];
    
}
-(void) searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}
-(IBAction)pressCancleItem:(id)sender
{
    
}
-(void) openEditingTable
{
    
}
@end
