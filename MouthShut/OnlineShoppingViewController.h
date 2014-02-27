//
//  OnlineShoppingViewController.h
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

@interface OnlineShoppingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EDStarRatingProtocol, UIActionSheetDelegate>{
    
    IBOutlet UITableView *tableVw;
    
    NSMutableArray *cellTitleArray;
    
    NSMutableArray *cellImagesArray;

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
    
    
}

- (IBAction)buzzAction:(id)sender;

- (IBAction)recentReviewsAction:(id)sender;

- (IBAction)writeReviewAction:(id)sender;

- (IBAction)popularAction:(id)sender;

- (IBAction)reviewAction:(id)sender;

- (IBAction)ratingsAction:(id)sender;

- (IBAction)recommendationsAction:(id)sender;

@end
