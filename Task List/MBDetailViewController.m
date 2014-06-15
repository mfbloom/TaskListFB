//
//  MBDetailViewController.m
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import "MBDetailViewController.h"

@interface MBDetailViewController ()

@end

@implementation MBDetailViewController

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

    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc]init];
    
    [formatDate setDateFormat:@"MM-dd-YYYY"];
    NSString *strongFromDate = [formatDate stringFromDate:self.task.date];
    
    self.dateLabel.text = strongFromDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.destinationViewController isKindOfClass:[MBEditTaskViewController class]])
    {
        MBEditTaskViewController *editTaskVC = segue.destinationViewController;
        
        editTaskVC.task = self.task;
        editTaskVC.delegate = self;
    }
}

-(void)didUpdateTask
{
    self.titleLabel.text = self.task.title;
    self.detailLabel.text = self.task.description;
    
    NSDateFormatter *formatDate = [[NSDateFormatter alloc]init];
    [formatDate setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [formatDate stringFromDate:self.task.date];
    self.dateLabel.text = stringFromDate;
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate updateTask];
}

- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender {

    [self performSegueWithIdentifier:@"toEditViewController" sender:nil];
}
@end
