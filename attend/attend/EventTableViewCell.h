//
//  EventTableViewCell.h
//  attend
//
//  Created by Jeffrey Decker on 1/28/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@property (strong, nonatomic) IBOutlet UIView *colorOverlay;
@end
