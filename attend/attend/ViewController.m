//
//  ViewController.m
//  attend
//
//  Created by Jeffrey Decker on 1/18/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "ViewController.h"
#import "ProfileViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (strong, nonatomic) id<FBGraphUser> userData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.fbLoginView = [[FBLoginView alloc] init];
    [self.fbLoginView setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    ProfileViewController *profileView = ( ProfileViewController *) [segue destinationViewController];
//    profileView.userData = self.userData;
}

#pragma mark - FBLoginViewDelegate Methods

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user {
    NSLog(@"user info: %@", user);
    self.userData = user;
    [self performSegueWithIdentifier:@"show_events" sender:self];
}

@end
