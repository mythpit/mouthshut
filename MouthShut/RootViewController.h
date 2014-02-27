//
//  RootViewController.h
//  MouthShut
//
//  Created by administrator on 2/20/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "EDStarRating.h"
#import "AutomotiveViewController.h"
#import "MoviesViewController.h"
#import "Health&BeautyViewController.h"
#import "OnlineShoppingViewController.h"
#import "MobileViewController.h"
#import "Travel&RestaurentsViewController.h"
#import "ProductSearchViewController.h"
#import <MapKit/MapKit.h>

@interface RootViewController : UIViewController<EDStarRatingProtocol, UIScrollViewDelegate, UISearchBarDelegate, CLLocationManagerDelegate>
{
    
    CLLocationManager *locationManager;

    UIView *hudView;

    IBOutlet UIButton *automotiveBtn;
    
    IBOutlet UIButton *healthNdBeautyBtn;
    
    IBOutlet UIButton *mobileBtn;
    
    IBOutlet UIButton *moviesBtn;
    
    IBOutlet UIButton *onlineShoppingBtn;
    
    IBOutlet UIButton *travelNdRestaurentsBtn;
    
    IBOutlet UIView *bottomPanelView;
    
    IBOutlet UIView *buttonsView;
    
    IBOutlet UIScrollView *imageScroll;
    
    IBOutlet UIImageView *scrollingImage;
    
    IBOutlet UILabel *bottomSeparatorLabel;
    
    NSArray *buttonsArray;
    
    NSArray *labelsArray;
    
    NSMutableArray *imagesArray;

    IBOutlet UILabel *automotiveLabel;
    
    IBOutlet UILabel *moviesLabel;
    
    IBOutlet UILabel *HndBLabel;
    
    IBOutlet UILabel *shoppingLabel;
    
    IBOutlet UILabel *mobileLabel;
    
    IBOutlet UILabel *travelLabel;
    
    IBOutlet UILabel *productsLabel;
    
    IBOutlet UILabel *helpedLabel;
    
    IBOutlet UILabel *topBluLabel;
    
    IBOutlet UILabel *reviewLabel;
    
    IBOutlet UIView *ratingsView;
}

- (IBAction)automotiveAction:(id)sender;

- (IBAction)moviesAction:(id)sender;

- (IBAction)healthNDBeautyAction:(id)sender;

- (IBAction)onlineShoppingAction:(id)sender;

- (IBAction)mobileAction:(id)sender;

- (IBAction)travelNDRestaurentsAction:(id)sender;









@end
