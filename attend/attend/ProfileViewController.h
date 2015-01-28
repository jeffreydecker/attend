//
//  ProfileViewController.h
//  attend
//
//  Created by Jeffrey Decker on 1/20/15.
//  Copyright (c) 2015 itsdecker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) id<FBGraphUser> userData;
@end
