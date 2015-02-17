//
//  GEEventsViewController.m
//  attend
//
//  Created by Jeffrey Decker on 2/8/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "GEEventsViewController.h"
#import "EventTableViewCell.h"
#import "GEUserData.h"

@interface GEEventsViewController ()

@property (strong, nonatomic) NSArray *events;

@end

@implementation GEEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                                    style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonClicked)];
    self.navigationItem.rightBarButtonItem = self.settingsButton;
    
    [self.eventsTableView setDataSource:self];
    self.eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.events = [[GEUserData getInstance] getEventsAttending];
    [self.eventsTabBar setSelectedItem:[self.eventsTabBar.items objectAtIndex:0]];
    [self.eventsTabBar setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// TODO: Add pull to refresh feature
// TODO: Add slide in/out animations

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // TODO: Handle profile/settings view and detail view segues
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.events count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eventCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor blueColor];
    
    cell.eventName.text = self.events[indexPath.row][@"name"];
    NSURL *imageURL = [NSURL URLWithString:self.events[indexPath.row][@"cover"][@"source"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    cell.imageView.image = [UIImage imageWithData:imageData];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell selected: %@", indexPath);
    [self performSegueWithIdentifier:@"show_event_details" sender:self];
}

#pragma mark - TabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    int index = [[tabBar items] indexOfObject:item];
    
    switch (index)
    {
        case 0:
            self.events = [[GEUserData getInstance] getEventsAttending];
            break;
        case 1:
            self.events = [[GEUserData getInstance] getEventsInvitations];
            break;
        case 2:
            self.events = [[GEUserData getInstance] getEventsHosting];
            break;
        default:
            NSLog (@"Error");
            break;
    }
    [self.eventsTableView reloadData];
}

#pragma mark - Settings Button Handlers

- (void)settingsButtonClicked {
    
}

@end
