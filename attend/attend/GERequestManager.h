//
//  GERequestManager.h
//  attend
//
//  Created by Jeffrey Decker on 1/31/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GERequestManager : NSObject

+ (GERequestManager*)getInstance;
- (void)requestEvents:(id)eventsDelegate;

@end

@protocol GEEventsDelegate <NSObject>

- (void)didFindEvents:(NSDictionary*)eventsObject type:(NSString *)eventType;
- (void)failedToFindEvnets:(NSError*)error;

@end
