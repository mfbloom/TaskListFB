//
//  MBAddTaskViewController.m
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import "MBAddTaskViewController.h"

@interface MBAddTaskViewController ()

@end

@implementation MBAddTaskViewController

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

    self.textView.delegate = self;
    self.taskTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


#pragma mark - Helper Methods 

-(MBTask *)returnNewTaskObject
{
    MBTask *taskObject = [[MBTask alloc]init];
    taskObject.title = self.taskTextField.text;
    taskObject.description = self.textView.text;
    taskObject.date = self.datePicker.date;
    taskObject.isCompleted = NO;
    
    return taskObject;
}

- (IBAction)cancelButtonPressed:(UIButton *)sender {
    
    [self.delegate didCancel];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addButtonPressed:(UIButton *)sender {
    
    [self.delegate didAddTask:[self returnNewTaskObject]];
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
