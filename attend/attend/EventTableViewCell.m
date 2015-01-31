//
//  EventTableViewCell.m
//  attend
//
//  Created by Jeffrey Decker on 1/28/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell()
@property (strong, nonatomic) IBOutlet UIImageView *eventImage;
@property (strong, nonatomic) IBOutlet UILabel *eventName;
@end

@implementation EventTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
