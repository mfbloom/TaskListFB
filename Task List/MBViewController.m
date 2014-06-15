//
//  MBViewController.m
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import "MBViewController.h"

@interface MBViewController ()

@end

@implementation MBViewController

-(NSMutableArray *)taskObjects
{
    if(!_taskObjects)
    {
        _taskObjects = [[NSMutableArray alloc]init];
    }
    return _taskObjects;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    NSArray *taskAsPropertyList = [[NSUserDefaults standardUserDefaults]arrayForKey:TASK_ID];
    
    for(NSDictionary *dictionary in taskAsPropertyList)
    {
        MBTask *taskObject = [self taskObjectForDictionary:dictionary];
        [self.taskObjects addObject:taskObject];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.destinationViewController isKindOfClass:[MBAddTaskViewController class]])
    {
        MBAddTaskViewController *addTaskViewController = segue.destinationViewController;
        addTaskViewController.delegate = self;
    }
    
    else if([segue.destinationViewController isKindOfClass:[MBDetailViewController class]])
    {
        MBDetailViewController *detailTaskVC = segue.destinationViewController;
        NSIndexPath *path = sender;
        
        MBTask *taskObject = self.taskObjects[path.row];
        
        detailTaskVC.task = taskObject;
        detailTaskVC.delegate = self;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBarButtonPressed:(UIBarButtonItem *)sender {
    
    [self performSegueWithIdentifier:@"toAddTaskViewController" sender:nil];

}

- (IBAction)priorityBarButtonPressed:(UIBarButtonItem *)sender {
    
    if(self.tableView.editing == YES)
    {
        [self.tableView setEditing:NO animated:YES];
        
    }
    else [self.tableView setEditing:YES animated:YES];
}

#pragma mark - MBAddTaskViewControllerDelegate

-(void)didAddTask:(MBTask *)task
{
    [self.taskObjects addObject:task];
    
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_ID]mutableCopy];
    
    if(!taskObjectsAsPropertyLists) taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
 
    [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:task]];
    [[NSUserDefaults standardUserDefaults]setObject:taskObjectsAsPropertyLists forKey:TASK_ID];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    //NSLog(@"%@", task.description);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

-(void)updateTask
{
   //this will save the data when editted
    [self saveTasks];
    [self.tableView reloadData];
}

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helper Methods

-(NSDictionary *)taskObjectAsPropertyList:(MBTask *)taskObject
{
    NSDictionary *dictionary = @{TITLE:taskObject.title, DESCRIPTION:taskObject.description, DATE:taskObject.date, COMPLETION:@(taskObject.isCompleted)};
    
    return dictionary;
}

-(BOOL)isDateGreaterThanDate:(NSDate *)date and:(NSDate *)toDate
{
    NSTimeInterval dateInterval = [date timeIntervalSince1970];
    NSTimeInterval toDateInterval = [toDate timeIntervalSince1970];
    
    if(dateInterval > toDateInterval) return YES;

    else return NO;
}

-(void)updateCompletionOfTask:(MBTask *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults]arrayForKey:TASK_ID]mutableCopy];
    
    if(!taskObjectsAsPropertyLists)taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if(task.isCompleted ==YES)task.isCompleted = NO;
    else task.isCompleted = YES;
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults]setObject:taskObjectsAsPropertyLists forKey:TASK_ID];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [self.tableView reloadData];
}

-(MBTask *)taskObjectForDictionary:(NSDictionary *)dictionary
{
    MBTask *taskObject = [[MBTask alloc]initWithData:dictionary];
    
    return taskObject;
}

-(void)saveTasks
{
    NSMutableArray *taskObjectsAsPropertyLists = [[NSMutableArray alloc]init];
    
    for(int x=0; x < [self.taskObjects count]; x++)
    {
        [taskObjectsAsPropertyLists addObject:[self taskObjectAsPropertyList:self.taskObjects[x]]];
        
    }
    
    [self updateNSUserDefaults:taskObjectsAsPropertyLists];
}

//-(NSMutableArray *)createTaskObjectsAsPropertyLists
//{
//     NSMutableArray *taskObjectsAsProperty= [[NSMutableArray alloc]init];
//    
//    return taskObjectsAsProperty;
//}
//

-(void)updateNSUserDefaults:(NSMutableArray *)taskObjectArray
{
    
    [[NSUserDefaults standardUserDefaults]setObject: taskObjectArray forKey:TASK_ID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

#pragma mark - UiTableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.taskObjects count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier =@"taskCell";
    UITableViewCell *taskCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    MBTask *task = self.taskObjects[indexPath.row];
    taskCell.textLabel.text = task.title;
    
    NSDateFormatter *format = [[NSDateFormatter alloc]init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString *stringFromDate = [format stringFromDate:task.date];
    taskCell.detailTextLabel.text = stringFromDate;
    
    BOOL isOverDue = [self isDateGreaterThanDate:[NSDate date] and:task.date];
    
    if(task.isCompleted ==YES)taskCell.backgroundColor =[UIColor greenColor];
    else if (isOverDue == YES) taskCell.backgroundColor = [UIColor redColor];
    else taskCell.backgroundColor = [UIColor clearColor];
    
    
    return taskCell;
}

#pragma mark - UiTableViewDelegateMethods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MBTask *task = self.taskObjects[indexPath.row];
    
    [self updateCompletionOfTask:task forIndexPath:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //remove object that is selected
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.taskObjects removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc]init];
        
        for (MBTask *task in self.taskObjects)
        {
            [newTaskObjectsData addObject:[self taskObjectAsPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults]setObject:newTaskObjectsData forKey:TASK_ID];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toDetailViewController" sender:indexPath];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //item that was dragged
    MBTask *taskObject = [self.taskObjects objectAtIndex:sourceIndexPath.row];
    [self.taskObjects removeObjectAtIndex:sourceIndexPath.row];
    
    //move dragged object to dropped location
    [self.taskObjects insertObject:taskObject atIndex:destinationIndexPath.row];
    
    [self saveTasks];
}

@end
