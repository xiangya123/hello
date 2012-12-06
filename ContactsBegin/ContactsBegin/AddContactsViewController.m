//
//  AddContactsViewController.m
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "AddContactsViewController.h"
#import "DataBaseUtil.h"
#import "ContactsVo.h"
#import "DaoUtil.h"
#import "MainViewController.h"
#import "ViewController.h"
#import "ContactsCache.h"
@interface AddContactsViewController ()

@end

@implementation AddContactsViewController
//@synthesize delegate;
@synthesize table;
@synthesize data;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        fields = [[NSArray alloc] initWithObjects:@"姓", @"名字",@"邮箱",
                  @"电话号码",@"地址", @"所在城市", @"公司", nil];
        
        str_Group=nil;
        // initialize the data NSMutableDictionary
        data = [[NSMutableDictionary alloc] initWithCapacity:fields.count+1];
        ContactsCache *cahe=[ContactsCache sharedInstance];
               NSMutableDictionary *nsmd_data=[cahe getObjectByName:@"nsmd_data"];
        keyboardShown = NO; // hide the keyboard
        currentCell = nil; // there is no cell currently selected
        g_data=nil;
        NSString *editData=[cahe getObjectByName:@"IS_NULL_DATA"];
        if(editData==@"HAVE_DATA")
        {
            data=nsmd_data;
            str_Group=[nsmd_data objectForKey:@"G_NAME"];
        }
        array=nil;
        [cahe storgeObjectByName:@"IS_NULLDATA" Object:@"NO_DATA"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAdding:sender
{
    DataBaseUtil *util=[[DataBaseUtil alloc]init];
    [util connectToDB];
    ContactsVo *vo=[[ContactsVo alloc]init];
    vo.C_S_NAME=[data objectForKey:[fields objectAtIndex:1]];
    vo.C_F_NAME=[data objectForKey:[fields objectAtIndex:0]];
    vo.C_MAIL=[data objectForKey:[fields objectAtIndex:2]];
    vo.C_PHONE=[data objectForKey:[fields objectAtIndex:3]];
    vo.C_ADRESS=[data objectForKey:[fields objectAtIndex:4]];
    vo.G_NAME=str_Group;
    vo.C_CITY=[data objectForKey:[fields objectAtIndex:5]];
    vo.C_COMPANY=[data objectForKey:[fields objectAtIndex:6]];
    
//    DaoUtil *d_util=[[DaoUtil alloc]init];
    if(!str_Group)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                              @"必须选择联系人分组"
                                                        message:@"联系人组不能为空"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }else{
    if(![DaoUtil addContacts:vo])
    {
        NSAssert(0, @"add contacts wrong");
        return ;
        
    }
    
    UIViewController *rootController;
//    MainViewController *views=[[MainViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
        ViewController *views=[[ViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
//    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
//    [rootController.view addSubview:views.view];
//    
//    [rootController presentModalViewController:views animated:TRUE];
    [rootController removeFromParentViewController];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    
    window.rootViewController=views;

    } // end method doneAdding:
}
- (void)editableCellDidBeginEditing:(EditableCell *)cell
{
    // if the keyboard is hidden
    if (!keyboardShown)
    {
        // animate resizing the table to fit the keyboard
        [UIView beginAnimations:nil context:NULL]; // begin animation block
        [UIView setAnimationDuration:0.25]; // set the animation duration
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        CGRect frame = table.frame; // get the frame of the table
        frame.size.height -= KEYBOARD_HEIGHT; // subtract from the height
        [table setFrame:frame]; // apply the new frame
        [UIView commitAnimations]; // end animation block
    } // end if
    
    keyboardShown = YES; // the keyboard appears on the screen
    currentCell = cell; // update the currently selected cell
    
    // get the index path for the selected cell
    NSIndexPath *path = [table indexPathForCell:cell];
    
    // scroll the table so that the selected cell is at the top
    [table scrollToRowAtIndexPath:path atScrollPosition:
     UITableViewScrollPositionTop animated:YES];
} // end method cellBeganEditing:

// called when the user stops editing a cell or selects another cell
- (void)editableCellDidEndEditing:(EditableCell *)cell
{
    // add the new entered data
    [data setValue:cell.textField.text forKey:cell.label.text];
} // end method editableCellDidEndEditing:

// called when the user touches the Done button on the keyboard
- (void)editableCellDidEndOnExit:(EditableCell *)cell
{
    
    // resize the table to fit the keyboard
    CGRect frame = table.frame; // get the frame of the table
    frame.size.height += KEYBOARD_HEIGHT; // subtract from the height
    [table setFrame:frame]; // apply the new frame
    
    keyboardShown = NO; // hide the keyboard
    currentCell = nil; // there is no cell currently selected
} // end method editableCellDidEndOnExit:
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        static int i = 0;
        static NSString *CellIdentif = @"friends-cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 CellIdentif];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: CellIdentif];
        }
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews];
        
        for (UIView *subview in subviews) {
            [subview removeFromSuperview];
        }

        return nil;
    }
    else if(indexPath.section!=3&&indexPath!=0){
        static NSString *identifier = @"EditableCell";
    
    
        // get a reusable cell
        EditableCell *cell = (EditableCell *)[table
                                          dequeueReusableCellWithIdentifier:identifier];
    
    
    
        
        if (cell == nil)
        {
                        cell = [[EditableCell alloc] initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        } 
        NSString *key =
        [fields objectAtIndex:indexPath.row + (indexPath.section-1)* 4];
        [cell setLabelText:key];
        cell.textField.text = [data valueForKey:key];
    
        if (indexPath.section == 1 && indexPath.row == 1)
        {
           
            cell.textField.keyboardType = UIKeyboardTypeEmailAddress;
        } 
        else if (indexPath.section == 1 && indexPath.row == 2)
        {
            
            cell.textField.keyboardType = UIKeyboardTypePhonePad;
        } 
        cell.editing = NO;
        cell.delegate = self; 
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell; 
    }
    else if(indexPath.section==3)
    {
        static NSString *FirstLevelCell= @"FirstLevelCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 FirstLevelCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier: FirstLevelCell];
        }
        
        NSUInteger row = [indexPath row];
        if(str_Group==nil)
            if(row==0)
                cell.textLabel.text = @"选择分组";
            else
                cell.textLabel.text=@"";
        else
            cell.textLabel.text=str_Group;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
        
    }
    
} 
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:
(NSInteger)section
{
       if(section==0)
        return nil;
    else if (section == 2)         return @"地址";
    else if(section==3)
        return @"组";
    else
        return nil;
} 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:
(NSInteger)section
{
    
    if(section==0)
        return 0;
    else if (section == 1)
        return 4;
    else if(section==2)
        return fields.count - 4; 
    else if(section==3)
        return 2;
    
} 
- (NSDictionary *)values
{
        if ([data valueForKey:@"Name"] == nil)
        return nil; 
    
        return [NSDictionary dictionaryWithDictionary:data];
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

            char* g_name= sqlite3_column_text(statement, 0);
            char* g_backinf=sqlite3_column_text(statement, 1);
            
           
            NSString *g_s_name=[[NSString alloc] initWithCString:g_name encoding:NSUTF8StringEncoding];
            
            [array addObject: g_s_name];
           // [array setValue:<#(id)#> forKey:<#(NSString *)#>]
        }
    }
}
-(IBAction)pickViwerSelectedDoneButton:(id)sender
{
    [table reloadData];
    UIPickerView *view=[self.view viewWithTag:PICKVIEWER];
    UIButton *view_a=[self.view viewWithTag:SELECTED_ADD_BUTTON];
    [view removeFromSuperview];
    [sender removeFromSuperview];
    [view_a removeFromSuperview];
    
}
-(IBAction)pickViewSelectedAddButton:(id)sender
{
    AddContacsGroupViewController *views=[[AddContacsGroupViewController alloc]initWithNibName:@"AddContacsGroupViewController" bundle:nil];
    views.delegate=self;
    //[self presentModalViewController:views animated:TRUE];
    [self presentViewController:views animated:TRUE completion:nil];
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIPickerView *p_viewer;
    if(indexPath.section==3)
    {
        [self queryGroupFromData];
        p_viewer=[[UIPickerView alloc]initWithFrame:CGRectMake(0, 320, 320, 300)];
        p_viewer.delegate=self;
        p_viewer.showsSelectionIndicator=YES;
        p_viewer.tag=PICKVIEWER;
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame=CGRectMake(265,320+5,50,30);
        button.titleLabel.text=@"Done";
        [button setTitle:@"Done" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(pickViwerSelectedDoneButton:) forControlEvents:UIControlEventTouchUpInside];
        button.tag=SELECTED_DONE_BUTTON;
        
        UIButton *add_button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        add_button.frame=CGRectMake(5,320+5,50,30);
        add_button.titleLabel.text=@"Add";
        [add_button setTitle:@"Add" forState:UIControlStateNormal];
        [add_button addTarget:self action:@selector(pickViewSelectedAddButton:) forControlEvents:UIControlEventTouchUpInside];
        add_button.tag=SELECTED_ADD_BUTTON;
        [self.view addSubview:p_viewer];
        [self.view insertSubview:add_button aboveSubview:p_viewer];
        [self.view insertSubview:button aboveSubview:p_viewer];
        
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [array count];
}

#pragma mark Picker Delegate Methods
- (NSString *)pickerView:(UIPickerView *)pickerView
			 titleForRow:(NSInteger)row
			forComponent:(NSInteger)component {
    return [array objectAtIndex:row];
}
-(void )pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    str_Group=[array objectAtIndex:row];
    
    //NSInteger row;
}
- (void)addContacsGroupViewControllerDidFinishAdding:(AddContacsGroupViewController *)controller
{
//    UIViewController *rootController;
//    
//    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
//    UITableView *table=[rootController.view  viewWithTag:TABLE_NAME_TAG];
//    [table reloadData];
    [controller dismissModalViewControllerAnimated:YES];
    UIViewController *rootController;
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    //UIPickerView *view=[rootController.view viewWithTag:PICKVIEWER];
    [self queryGroupFromData];
    UIPickerView *view=[self.view viewWithTag:PICKVIEWER];
    [view reloadAllComponents];
    
}


- (IBAction)pressedCancleButton:(id)sender {
    
    ViewController *views=[[ViewController alloc]initWithNibName:@"MainViewController" bundle:nil];
    UIViewController *rootController;
    
    
    rootController=[UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController removeFromParentViewController];
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    window.rootViewController=views;
    
}
-(void) openEditingTable
{
    
}
@end
