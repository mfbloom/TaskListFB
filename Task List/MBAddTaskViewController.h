//
//  MBAddTaskViewController.h
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBTask.h"

@protocol MBAddTaskViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(MBTask *)task;

@end

@interface MBAddTaskViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) id <MBAddTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)cancelButtonPressed:(UIButton *)sender;
- (IBAction)addButtonPressed:(UIButton *)sender;

@end
