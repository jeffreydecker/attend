//
//  GERequestManager.m
//  attend
//
//  Created by Jeffrey Decker on 1/31/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import "GERequestManager.h"
#import <FacebookSDK/FacebookSDK.h>

@interface GERequestManager()
@property (strong, nonatomic) id<GEEventsDelegate> eventsDelegate;
@end

@implementation GERequestManager

+ (GERequestManager*)getInstance {
    
    static GERequestManager *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[GERequestManager alloc] init];
    });
    
    return _sharedInstance;
}


/*
 This function asks for the user's (upcoming) events, and for those events retrieves the name, the start_time and the cover picture.
 It first checks for the existence of the public_profile and user_events permissions
 If the permissions are not present, it requests them
 If/once the permissions are present, it makes the user events request with field expansion for name, start_time and cover picture.
 */

- (void)requestEvents:(id)eventsDelegate {
    self.eventsDelegate = eventsDelegate;
    
    // We will request the user's events
    // These are the permissions we need:
    NSArray *permissionsNeeded = @[@"user_events"];
    
    // Request the permissions the user currently has
    [FBRequestConnection startWithGraphPath:@"/me/permissions"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error){
                                  // Parse the list of existing permissions and extract them for easier use
                                  NSMutableArray *currentPermissions = [[NSMutableArray alloc] init];
                                  NSArray *returnedPermissions = (NSArray *)[result data];
                                  for (NSDictionary *perm in returnedPermissions) {
                                      if ([[perm objectForKey:@"status"] isEqualToString:@"granted"]) {
                                          [currentPermissions addObject:[perm objectForKey:@"permission"]];
                                      }
                                  }
                                  
                                  // Build the list of requested permissions by starting with the permissions
                                  // needed and then removing any current permissions
                                  NSLog(@"Needed: %@", permissionsNeeded);
                                  NSLog(@"Current: %@", currentPermissions);
                                  
                                  NSMutableArray *requestPermissions = [[NSMutableArray alloc] initWithArray:permissionsNeeded copyItems:YES];
                                  [requestPermissions removeObjectsInArray:currentPermissions];
                                  
                                  NSLog(@"Asking: %@", requestPermissions);
                                  
                                  // If we have permissions to request
                                  if ([requestPermissions count] > 0){
                                      // Ask for the missing permissions
                                      [FBSession.activeSession requestNewReadPermissions:requestPermissions
                                                                       completionHandler:^(FBSession *session, NSError *error) {
                                                                           if (!error) {
                                                                               // Permission granted
                                                                               NSLog(@"new permissions %@", [FBSession.activeSession permissions]);
                                                                               // We can request the user information
                                                                               [self requestAllEvents];
                                                                           } else {
                                                                               // An error occurred, we need to handle the error
                                                                               // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                                                               NSLog(@"error %@", error.description);
                                                                           }
                                                                       }];
                                  } else {
                                      // Permissions are present
                                      // We can request the user information
                                      [self requestAllEvents];
                                  }
                                  
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  NSLog(@"error %@", error.description);
                              }
                          }];
}

- (void)requestAllEvents {
    // Attending/Going
    [self makeRequestForAttendingEvents];
    // Invites
    [self makeRequestForDeclinedEvents];
    [self makeRequestForMaybeEvents];
    [self makeRequestForNotRepliedEvents];
    // Hosting
    [self makeRequestForCreatedEvents];
}

- (void)makeRequestForAttendingEvents {
    [FBRequestConnection startWithGraphPath:@"me/events/attending?fields=cover,location,name,rsvp_status,owner"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Success! Include your code to handle the results here
                                  [self.eventsDelegate didFindEvents:result type:@"attending"];
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  [self.eventsDelegate failedToFindEvnets:error];
                              }
                          }];
}

- (void)makeRequestForDeclinedEvents {
    [FBRequestConnection startWithGraphPath:@"me/events/declined?fields=cover,location,name,rsvp_status,owner"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Success! Include your code to handle the results here
                                  [self.eventsDelegate didFindEvents:result type:@"declined"];
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  [self.eventsDelegate failedToFindEvnets:error];
                              }
                          }];

}

- (void)makeRequestForMaybeEvents {
    [FBRequestConnection startWithGraphPath:@"me/events/maybe?fields=cover,location,name,rsvp_status,owner"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Success! Include your code to handle the results here
                                  [self.eventsDelegate didFindEvents:result type:@"maybe"];
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  [self.eventsDelegate failedToFindEvnets:error];
                              }
                          }];

}

- (void)makeRequestForNotRepliedEvents {
    [FBRequestConnection startWithGraphPath:@"me/events/not_replied?fields=cover,location,name,rsvp_status,owner"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Success! Include your code to handle the results here
                                  [self.eventsDelegate didFindEvents:result type:@"not_replied"];
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  [self.eventsDelegate failedToFindEvnets:error];
                              }
                          }];
}

- (void)makeRequestForCreatedEvents {
    [FBRequestConnection startWithGraphPath:@"me/events/created?fields=cover,location,name,rsvp_status,owner"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              if (!error) {
                                  // Success! Include your code to handle the results here
                                  [self.eventsDelegate didFindEvents:result type:@"created"];
                              } else {
                                  // An error occurred, we need to handle the error
                                  // Check out our error handling guide: https://developers.facebook.com/docs/ios/errors/
                                  [self.eventsDelegate failedToFindEvnets:error];
                              }
                          }];

}

@end
