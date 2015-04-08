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
@property (strong, nonatomic) UITabBarItem *selectedTabBarItem;

@end

@implementation GEEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
                                                          action:@selector(settingsButtonClicked)];
    
    [self.eventsTableView setDataSource:self];
    [self.eventsTableView setDelegate:self];
    self.eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.eventsTableView.backgroundColor = [UIColor colorWithRed:5.0/255.0 green:35.0/255.0 blue:69.0/255.0 alpha:1.0];
    
    self.events = [[GEUserData getInstance] getEventsAttending];
    [self.eventsTabBar setSelectedItem:[self.eventsTabBar.items objectAtIndex:0]];
    [self.eventsTabBar setDelegate:self];

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:5.0/255.0 green:35.0/255.0 blue:69.0/255.0 alpha:1.0]];
    [self.eventsTabBar setBarTintColor:[UIColor colorWithRed:5.0/255.0 green:35.0/255.0 blue:69.0/255.0 alpha:1.0]];
    //optional, i don't want my bar to be translucent
//    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// TODO: Add pull to refresh feature

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    // TODO: Handle profile/settings view and detail view segues
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    // Animate cells to slide in from the right
    cell.transform = CGAffineTransformMakeTranslation(cell.bounds.size.width * 1, 0);
    [UIView animateWithDuration:0.25 animations:^{
        cell.transform = CGAffineTransformIdentity;
    }];
    
    // TODO: Add slide out animations
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
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"eventCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.backgroundColor = [UIColor blueColor];
    
    cell.eventName.text = self.events[indexPath.row][@"name"];
    cell.eventName.textColor = [UIColor whiteColor];
    cell.eventName.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    
    NSURL *imageURL = [NSURL URLWithString:self.events[indexPath.row][@"cover"][@"source"]];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [cell.eventImage setImage:[UIImage imageWithData:imageData]];
    cell.eventImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.eventImage.clipsToBounds = YES;
    
    cell.colorOverlay.backgroundColor = [self getCellColorFromIndexPath:indexPath];
    cell.colorOverlay.alpha = 0.8;
    return cell;
    
}

- (UIColor*)getCellColorFromIndexPath:(NSIndexPath *)indexPath {
    UIColor* cellColor;
    switch (indexPath.row%3) {
        case 0:
            cellColor = [UIColor colorWithRed:49.0/255.0 green:57.0/255.0 blue:117.0/255.0 alpha:1.0];
            break;
        case 1:
            cellColor = [UIColor colorWithRed:79.0/255.0 green:44.0/255.0 blue:115.0/255.0 alpha:1.0];
            break;
        case 2:
            cellColor = [UIColor colorWithRed:34.0/255.0 green:102.0/255.0 blue:102.0/255.0 alpha:1.0];
            break;
        default:
            break;
    }
    return cellColor;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Cell selected: %@", indexPath);
//    [self performSegueWithIdentifier:@"show_event_details" sender:self];
}

#pragma mark - UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if ([item isEqual:self.selectedTabBarItem]) {
        return;
    }
    
    int index = [[tabBar items] indexOfObject:item];
    NSString* title = @"Events";
    
    switch (index)
    {
        case 0:
            self.events = [[GEUserData getInstance] getEventsAttending];
            title = @"Going";
            break;
        case 1:
            self.events = [[GEUserData getInstance] getEventsInvitations];
            title = @"Invites";
            break;
        case 2:
            self.events = [[GEUserData getInstance] getEventsHosting];
            title = @"Hosting";
            break;
        default:
            NSLog (@"Error");
            break;
    }
    self.selectedTabBarItem = item;
    self.navigationItem.title = title;
    [self.eventsTableView reloadData];
}

#pragma mark - Settings Button Handlers

- (void)settingsButtonClicked {
    
}

@end
