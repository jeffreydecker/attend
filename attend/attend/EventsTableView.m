//
//  EventsTableView.m
//  attend
//
//  Created by Jeffrey Decker on 1/28/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "EventsTableView.h"
#import "EventTableViewCell.h"

@implementation EventsTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (NSInteger)numberOfSections {
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EventTableViewCell *cell = [self dequeueReusableCellWithIdentifier:@"eventCell"];
    
    if (cell == nil) {
        cell = [[EventTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"eventCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //cell.textLabel.text = self.justCourseNamesArray[indexPath.row];
    
    return cell;
}

@end
