//
//  Travel&RestaurentsViewController.h
//  MouthShut
//
//  Created by Administrator on 24/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
#import <QuartzCore/QuartzCore.h>
#import "BuzzViewController.h"
#import "RecentViewController.h"
#import "WriteReviewViewController.h"
#import "ProductSearchViewController.h"
#import "ProductListingViewController.h"

@interface Travel_RestaurentsViewController : UIViewController<EDStarRatingProtocol, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UITabBarControllerDelegate, UINavigationControllerDelegate, UITabBarDelegate, UIActionSheetDelegate>
{
    
    UISearchBar *searchBar;
    
    NSMutableArray *imagesArray;
    
    NSArray *categaoryLabelArray;
    
    NSArray *cellImagesArray;
    
    IBOutlet UIView *tabbarView;
    
    IBOutlet UIButton *buzzBtn;
    
    IBOutlet UIButton *recentReviewsBtn;
    
    IBOutlet UIButton *writeReviewBtn;
    
    IBOutlet UIControl *buzzBgView;
    
    IBOutlet UIControl *recentReviewBgView;
    
    IBOutlet UIControl *writeReviewBgView;
}

- (IBAction)buzzAction:(id)sender;

- (IBAction)recentReviewsAction:(id)sender;

- (IBAction)writeReviewAction:(id)sender;


@end
