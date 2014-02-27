//
//  RootAppDelegate.h
//  MouthShut
//
//  Created by administrator on 2/20/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RootViewController.h"

#import "BuzzViewController.h"

#import "RecentViewController.h"

#import "WriteReviewViewController.h"

#import "MoviesViewController.h"

@interface RootAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate>
{
    
    UITabBarController *tabBarController;
    
    UINavigationController *navigationController;
    UINavigationController *navigationController1;
    UINavigationController *navigationController2;
    UINavigationController *navigationController3;
    
    RootViewController *rootView;
    
    MoviesViewController *moviesView;

    BuzzViewController *buzzView;

    RecentViewController *recentView;

    WriteReviewViewController *writeReviewView;

    
}
@property (strong, nonatomic) UIWindow *window;

@end
