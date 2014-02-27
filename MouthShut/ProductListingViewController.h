//
//  ProductListingViewController.h
//  MouthShut
//
//  Created by Administrator on 25/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDStarRating.h"
#import <QuartzCore/QuartzCore.h>
#import "BuzzViewController.h"
#import "RecentViewController.h"
#import "WriteReviewViewController.h"
#import "SBJson.h"

@interface ProductListingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EDStarRatingProtocol, UIActionSheetDelegate>{
    
    UIActivityIndicatorView *indicator;
    
    IBOutlet UITableView *tableVw;
    
    NSMutableArray *cellTitleArray;
    
    NSMutableArray *cellImagesArray;
    
    NSMutableArray *ratingsArray;
    
    NSMutableArray *reviewsArray;
    
    NSMutableArray *likesArray;
    
    NSMutableArray *cat_IdArray;
    
    NSMutableArray *cellImagesExtensionsArray;
    
    NSMutableArray *review_DateArray;
    
    NSMutableArray *last_cat_idArray;
    
    NSMutableArray *frequencyArray;

    NSMutableArray *distanceArray;

    IBOutlet UIView *tabbarView;
    
    IBOutlet UIButton *buzzBtn;
    
    IBOutlet UIButton *recentReviewsBtn;
    
    IBOutlet UIButton *writeReviewBtn;
    
    IBOutlet UIControl *buzzBgView;
    
    IBOutlet UIControl *recentReviewBgView;
    
    IBOutlet UIControl *writeReviewBgView;
    
    IBOutlet UIButton *popularBtn;
    
    IBOutlet UIButton *reviewBtn;
    
    IBOutlet UIButton *ratingsBtn;
    
    IBOutlet UIButton *recommendationsBtn;
    
    IBOutlet UIView *topSegmentedBar;
    
    NSMutableString *loginResponseData;
    
    NSMutableDictionary *json;
    
    NSString *review_Date;
    
    NSString *last_Product_Name;
    
    NSString *level_String;
    
    NSString *latitude_String;
    
    NSString *longitude_String;
    
    NSString *distance_Param;
    
    NSString *cat_Name;
    
    NSString *city_param;
    
    NSString *other_Criteria_String;
    
    NSString *prev_frequency_String;
    
    UIView *hudView;
    
    NSString *actionFlagString;
    
    BOOL noMoreRecords;

}

@property(nonatomic, retain)NSString *catName;

@property(nonatomic, assign)BOOL isLocationBased;

- (IBAction)buzzAction:(id)sender;

- (IBAction)recentReviewsAction:(id)sender;

- (IBAction)writeReviewAction:(id)sender;

- (IBAction)popularAction:(id)sender;

- (IBAction)reviewAction:(id)sender;

- (IBAction)ratingsAction:(id)sender;

- (IBAction)recommendationsAction:(id)sender;


@end
