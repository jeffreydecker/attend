//
//  GEUserData.m
//  attend
//
//  Created by Jeffrey Decker on 1/31/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "GEUserData.h"

@interface GEUserData()

@property (strong, nonatomic) id<FBGraphUser> userData;
@property (strong, nonatomic) NSMutableDictionary *events;
@property (strong, nonatomic) NSDateFormatter *eventsDateFormatter;

@end

@implementation GEUserData

+ (GEUserData*)getInstance {
    
    static GEUserData *_sharedInstance;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[GEUserData alloc] init];
    });
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initDateFormatter];
        self.events = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    return self;
}

- (void)initDateFormatter {
    self.eventsDateFormatter = [NSDateFormatter new];
    [self.eventsDateFormatter setLocale:[NSLocale currentLocale]];
    [self.eventsDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
}

- (Boolean)setFacebookUserData:(id<FBGraphUser>)newUserData {
    
    if ([self isNewUserData:newUserData]) {
        NSLog(@"user info: %@", newUserData);
        self.userData = newUserData;
        return true;
    }
    
    return false;
}

- (Boolean)isNewUserData:(id<FBGraphUser>)newUserData {
    return ![self.userData[@"id"] isEqualToString:newUserData[@"id"]];
}

- (NSArray *)sortEventsByDate:(NSMutableArray *)events {
    // Remove past events from the result
    events = [self removePastEvents:events];
    // Sort the events by date
    NSArray *sortedEvents;
    sortedEvents = [events sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSDate *first = a[@"start_time"];
        NSDate *second = b[@"start_time"];
        return [first compare:second];
    }];
    return sortedEvents;
}

- (NSMutableArray *)removePastEvents:(NSMutableArray *)events {
    NSDate *now = [NSDate date];
    NSDate *eventDate = nil;
    NSMutableArray *eventsToRemove = [NSMutableArray new];
    for (NSDictionary *event in events) {
        eventDate = [self.eventsDateFormatter dateFromString:event[@"start_time"]];
        if ([eventDate compare:now] == NSOrderedAscending) {
            [eventsToRemove addObject:event];
        }
    }
    [events removeObjectsInArray:eventsToRemove];
    return events;
}

- (NSArray *)getEventsAttending {
    return self.events[@"attending"];
}

- (NSArray *)getEventsInvitations {
    return self.events[@"invitations"];
}

- (NSArray *)getEventsHosting {
    return self.events[@"created"];
}

#pragma mark : GEEvnetsDelegate Methods

- (void)didFindEvents:(id)eventsObject type:(NSString *)eventType {
    NSLog(@"Events: %@", eventsObject);
    
    NSMutableArray *eventsList = [eventsObject[@"data"] mutableCopy];
    
    // TODO: Brodcast notifications for list updates so views can refresh
    if (eventsList) {
        if ([eventType isEqualToString:@"attending"] || [eventType isEqualToString:@"created"]) {
            self.events[eventType] = [self sortEventsByDate:eventsList];
        } else {
            NSMutableArray *invites = [[NSMutableArray alloc] initWithArray:eventsList];
            [invites addObjectsFromArray:self.events[@"invitations"]];
            self.events[@"invitations"] = [self sortEventsByDate:invites];
        }
    }
}

- (void)failedToFindEvnets:(NSError*)error {
    NSLog(@"Could not retrieve events: %@",error);
}

@end
