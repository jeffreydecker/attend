//
//  EventTableViewCell.m
//  attend
//
//  Created by Jeffrey Decker on 1/28/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "EventTableViewCell.h"

@interface EventTableViewCell()

@end

@implementation EventTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        [super setSelected:NO animated:animated];
    }
}

@end
