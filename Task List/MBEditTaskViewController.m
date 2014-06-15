//
//  MBEditTaskViewController.m
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import "MBEditTaskViewController.h"

@interface MBEditTaskViewController ()

@end

@implementation MBEditTaskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.taskTextField.text = self.task.title;
    self.textView.text = self.task.description;
    self.datePicker.date = self.task.date;
    
    self.textView.delegate = self;
    self.taskTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper

-(void)updateTask
{
    self.task.title = self.taskTextField.text;
    self.task.description = self.textView.text;
    self.task.date = self.datePicker.date;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)saveBarButtonPressed:(UIBarButtonItem *)sender {

    [self updateTask];
    [self.delegate didUpdateTask];

}
#pragma mark - UiTextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTextField resignFirstResponder];
    return YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
    {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}
@end
