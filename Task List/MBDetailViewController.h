//
//  MBDetailViewController.h
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBTask.h"
#import "MBEditTaskViewController.h"

@protocol MBDetailTaskViewControllerDelegate <NSObject>

-(void)updateTask;

@end

@interface MBDetailViewController : UIViewController <MBEditTaskViewControllerDelegate>
- (IBAction)editBarButtonPressed:(UIBarButtonItem *)sender;

@property (weak,nonatomic) id <MBDetailTaskViewControllerDelegate> delegate;

@property (strong, nonatomic)MBTask *task;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;


@end
