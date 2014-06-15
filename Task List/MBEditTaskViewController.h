//
//  MBEditTaskViewController.h
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBTask.h"

@protocol MBEditTaskViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end

@interface MBEditTaskViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property (weak,nonatomic)id <MBEditTaskViewControllerDelegate> delegate;

@property (strong, nonatomic) MBTask *task;

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextView *textView;

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender;

@end
