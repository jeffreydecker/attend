//
//  GEEventsViewController.h
//  attend
//
//  Created by Jeffrey Decker on 2/8/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GERequestManager.h"

@interface GEEventsViewController : UIViewController <UITabBarDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITabBar *eventsTabBar;
@property (strong, nonatomic) IBOutlet UITableView *eventsTableView;
@property (strong, nonatomic) IBOutlet UINavigationItem *eventsNavigationItem;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *settingsButton;

@end
