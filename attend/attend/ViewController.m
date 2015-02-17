//
//  ViewController.m
//  attend
//
//  Created by Jeffrey Decker on 1/18/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "ViewController.h"
#import "ProfileViewController.h"
#import "GERequestManager.h"
#import "GEUserData.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet FBLoginView *fbLoginView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Facebook login button
    self.fbLoginView = [[FBLoginView alloc] init];
    [self.fbLoginView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    // TODO: get rid of the login view and init again
}

- (void)requestEvents {
    [[GERequestManager getInstance] requestEvents:[GEUserData getInstance]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"show_events"]) {
        [self requestEvents];
    }
}

#pragma mark - FBLoginViewDelegate Methods

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    if ([[GEUserData getInstance] setFacebookUserData:user]) {
        [self performSegueWithIdentifier:@"show_events" sender:self];
    }
}

@end
