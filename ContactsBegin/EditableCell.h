// EditableCell.h
//  ContactsBegin
//
//  Created by lzxer on 12-10-29.
//  Copyright (c) 2012年 lzxer. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol EditableCellDelegate; 

@interface EditableCell : UITableViewCell <UITextFieldDelegate>
{
   id <EditableCellDelegate> delegate;
   UITextField *textField; 
   UILabel *label;
}
@property (nonatomic, retain) UITextField *textField;

@property (readonly, retain) UILabel *label;

@property (nonatomic, retain) id <EditableCellDelegate> delegate;

- (void)setLabelText:(NSString *)text;
- (void)clearText; @end 

@protocol EditableCellDelegate 
- (void)editableCellDidBeginEditing:(EditableCell *)cell;

- (void)editableCellDidEndEditing:(EditableCell *)cell;

- (void)editableCellDidEndOnExit:(EditableCell *)cell;
@end 
