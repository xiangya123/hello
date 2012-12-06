//
//  AddContactsViewController.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//

#import "BaseViewController.h"
#import "EditableCell.h"
#import "AddContacsGroupViewController.h"
static const int KEYBOARD_HEIGHT = 200;
#define SELECTED_DONE_BUTTON 112
#define SELECTED_ADD_BUTTON  114
#define PICKVIEWER 113
@protocol AddContactsViewController
@end
@interface AddContactsViewController : BaseViewController <UITableViewDataSource,
EditableCellDelegate,UIPickerViewDelegate,AddContacsGroupViewControllerDelegate>
{
    id <AddContactsViewController> delegate; // this class's delegate
    IBOutlet UITableView *table; // table that displays editable fields
    NSArray *fields; // an array containing the field names
    NSMutableDictionary *data; // dictionary containing contact data
    BOOL keyboardShown; // is the keyboard visible?
    EditableCell *currentCell; // the cell the user is currently editing
    NSString *str_Group;
    NSMutableDictionary *g_data;
    NSMutableArray *array;
    
}
- (IBAction)pressedCancleButton:(id)sender;

@property (nonatomic, assign) id <AddContactsViewController> delegate;
@property (nonatomic, retain) IBOutlet UITableView *table;
@property (readonly, copy, getter=values) NSDictionary *data;
- (IBAction)doneAdding:sender; // return to RootView
- (NSDictionary *)values; // return values NSDictionary
- (void)clearFields; // clear table cells
-(IBAction)pickViwerSelectedDoneButton:(id)sender;
@end // end interface AddViewController

// notifies RootViewcontroller that Done Button was touched
@protocol AddViewControllerDelegate
- (void)addViewControllerDidFinishAdding:(AddContactsViewController *)controller;
@end // end protocol AddViewControllerDelegate

