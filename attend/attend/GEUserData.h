//
//  GEUserData.h
//  attend
//
//  Created by Jeffrey Decker on 1/31/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "GERequestManager.h"

@interface GEUserData : NSObject <GEEventsDelegate>

+ (GEUserData*)getInstance;
- (Boolean)setFacebookUserData:(id<FBGraphUser>)newUserData;
- (NSArray *)getEventsAttending;
- (NSArray *)getEventsInvitations;
- (NSArray *)getEventsHosting;

@end
