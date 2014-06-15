//
//  MBViewController.h
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBAddTaskViewController.h"
#import "MBDetailViewController.h"
#import "MBTask.h"

@protocol MBViewControllerDelegate <NSObject>

@end

@interface MBViewController : UIViewController <MBViewControllerDelegate, MBAddTaskViewControllerDelegate, UITableViewDelegate, UITableViewDataSource, MBDetailTaskViewControllerDelegate >
@property (weak,nonatomic) id <MBViewControllerDelegate> delegate;

@property (strong,nonatomic) NSMutableArray *taskObjects;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)addBarButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)priorityBarButtonPressed:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UITableViewCell *tableViewCell;

@end
