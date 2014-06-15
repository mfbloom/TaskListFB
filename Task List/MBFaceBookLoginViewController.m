//
//  MBFaceBookLoginViewController.m
//  Task List
//
//  Created by Michael Bloom on 6/14/14.
//  Copyright (c) 2014 Michael Bloom. All rights reserved.
//

#import "MBFaceBookLoginViewController.h"

@interface MBFaceBookLoginViewController ()

@end

@implementation MBFaceBookLoginViewController

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
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
    FBLoginView *loginView =[[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email"]];
    
    // Align the button in the center horizontally
    loginView.frame = CGRectOffset(loginView.frame, (self.view.center.x - (loginView.frame.size.width / 2)), 30);
    [self.view addSubview:loginView];
    
    loginView.delegate = self;
    
    if(FBSession.activeSession.isOpen)
    {
        [self performSegueWithIdentifier:@"toNavigationViewControllerFromFB" sender:self];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [FBLoginView class];
        return YES;
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    if([segue.destinationViewController isKindOfClass:[MBViewController class]])
    {
        MBViewController *nextVC = segue.destinationViewController;
        
        nextVC.delegate = self;
    }
}

#pragma mark - FBLoginViewDelegate

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id)user {
    self.nameLabel.text = ;
    self.profilePic.profileID = user.id;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePic.profileID = nil;
    self.usernameLabel.text = nil;
}
@end
