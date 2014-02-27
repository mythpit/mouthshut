//
//  RootViewController.m
//  MouthShut
//
//  Created by administrator on 2/20/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "RootViewController.h"
#import "EDStarRating.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    imagesArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"image1.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image3.png"],[UIImage imageNamed:@"image4.png"], nil];

    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        
        [[NSBundle mainBundle] loadNibNamed:@"View4Root" owner:self options:nil];
        
        UIScrollView *scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 215)];
        scr.tag = 1;
        scr.autoresizingMask=UIViewAutoresizingNone;
        [self.view addSubview:scr];
        scr.backgroundColor = [UIColor grayColor];
        
        buttonsView.frame = CGRectMake(0, 285, self.view.frame.size.width, 230);
        [self.view addSubview:buttonsView];
        
        bottomPanelView.frame = CGRectMake(0, self.view.frame.size.height+15, self.view.frame.size.width, 50);
        [self.view addSubview:bottomPanelView];
        
        [self setupScrollView:scr];

        
    }else{
        
        [[NSBundle mainBundle] loadNibNamed:@"RootViewController" owner:self options:nil];
        
        UIScrollView *scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 230)];
        scr.tag = 1;
        scr.autoresizingMask=UIViewAutoresizingNone;
        [self.view addSubview:scr];
        
        buttonsView.frame = CGRectMake(0, imageScroll.frame.origin.y+240, self.view.frame.size.width, 197);
        [self.view addSubview:buttonsView];
        
        bottomPanelView.frame = CGRectMake(0, self.view.frame.size.height+15, self.view.frame.size.width, 50);
        [self.view addSubview:bottomPanelView];
        
        topBluLabel.frame = CGRectMake(0, -3, self.view.frame.size.width, 2);
        topBluLabel.backgroundColor = [UIColor colorWithRed:46/255.0 green:107/255.0 blue:210/255.0 alpha:1.0];
        [self.view addSubview:topBluLabel];
        
//        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                          forBarPosition:UIBarPositionAny
//                                              barMetrics:UIBarMetricsDefault];
//        UIImage *image = [[UIImage alloc] init];
//        image = [UIImage imageNamed:@"topBlueBar.png"];
//        [[UINavigationBar appearance] setShadowImage:image];
        
        [self setupScrollView:scr];

    }
    
    self.tabBarController.tabBar.hidden=YES;

    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
    [leftButton setImage:[UIImage imageNamed:@"Menu.png"] forState:UIControlStateNormal];
   // [leftButton addTarget:self action:@selector(buttonMoreClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftBarButton;

    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
    [rightButton setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    UIImage *image = [UIImage imageNamed:@"MS-Logo.png"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 180, 44)];
    titleImageView.image = image;
    self.navigationItem.titleView = titleImageView;
    
    
    buttonsArray = [[NSArray alloc]initWithObjects:automotiveBtn, healthNdBeautyBtn, mobileBtn,moviesBtn, onlineShoppingBtn, travelNdRestaurentsBtn, nil];
    for (UIButton* btn in buttonsArray) {
        btn.layer.cornerRadius = 3.0;
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0] CGColor];
        btn.backgroundColor = [UIColor whiteColor];
    }
    
    labelsArray = [[NSArray alloc]initWithObjects:automotiveLabel, HndBLabel, mobileLabel,moviesLabel, shoppingLabel, travelLabel, nil];
    for (UILabel* lbl in labelsArray) {
        lbl.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    }
    
    
    bottomPanelView.layer.borderWidth = 0.5;
    bottomPanelView.layer.borderColor = [[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0] CGColor];
    bottomPanelView.backgroundColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];

    bottomSeparatorLabel.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    productsLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    helpedLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    reviewLabel.textColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    topBluLabel.backgroundColor = [UIColor colorWithRed:46/255.0 green:107/255.0 blue:210/255.0 alpha:1.0];

    	// Do any additional setup after loading the view, typically from a nib.
}

-(void)searchedButtonClicked{
    
    UISearchBar *headerSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 320, 34)];
    headerSearchBar.barStyle = UISearchBarStyleDefault;
    headerSearchBar.searchBarStyle = UISearchBarStyleDefault;
    headerSearchBar.translucent = NO;
    headerSearchBar.delegate = self;
    headerSearchBar.placeholder = @"Start Your Search Here";
    //headerSearchBar.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0];
    self.navigationItem.titleView = headerSearchBar;
    self.navigationItem.rightBarButtonItem = nil;

}

-(void)updateUI:(UISearchBar*)searchBar{
    
    [searchBar resignFirstResponder];
    [searchBar removeFromSuperview];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
    [rightButton setImage:[UIImage imageNamed:@"Search.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(searchedButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;

    UIImage *image = [UIImage imageNamed:@"MS-Logo.png"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 0, 180, 44)];
    titleImageView.image = image;
    self.navigationItem.titleView = titleImageView;
    
    }

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self showActivityIndicatorOnView:self.view caption:@"Please Wait..."];
    [self performSelectorOnMainThread:@selector(updateUI:) withObject:searchBar waitUntilDone:NO];
    [self performSelector:@selector(jsonCall:) withObject:searchBar afterDelay:0.3];
}

- (UIActivityIndicatorView *)showActivityIndicatorOnView:(UIView*)aView caption:(NSString *)labelCaption
{
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        
    }
    
    hudView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
    hudView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    hudView.clipsToBounds = YES;
    hudView.layer.cornerRadius = 10.0;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(65, 40, activityIndicatorView.bounds.size.width, activityIndicatorView.bounds.size.height);
    [hudView addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    
    UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 130, 60)];
    captionLabel.backgroundColor = [UIColor clearColor];
    captionLabel.textColor = [UIColor whiteColor];
    captionLabel.adjustsFontSizeToFitWidth = YES;
    captionLabel.textAlignment = NSTextAlignmentCenter;
    captionLabel.text = [NSString stringWithFormat:@"%@", labelCaption];
    captionLabel.numberOfLines = 2;
    captionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [hudView addSubview:captionLabel];
    
    [self.view addSubview:hudView];
    hudView.center = self.view.center;
    return activityIndicatorView;
}


-(void)jsonCall:(UISearchBar*)searchBar{
    
    ProductSearchViewController *product = [[ProductSearchViewController alloc]initWithNibName:@"ProductSearchViewController" bundle:nil];
    product.searchString = searchBar.text;
    [hudView removeFromSuperview];
    [self.navigationController pushViewController:product animated:YES];

    
}

- (void)setupScrollView:(UIScrollView*)scrMain {

        for (int i = 1; i<[imagesArray count]+1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png",i]];
            
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                scrollingImage  = [[UIImageView alloc]initWithFrame:CGRectMake((i - 1)*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)];
            }else{
                scrollingImage  = [[UIImageView alloc]initWithFrame:CGRectMake((i - 1)*scrMain.frame.size.width, scrMain.frame.origin.y, scrMain.frame.size.width, 187)];
                
            }
            
        scrollingImage.contentMode = UIViewContentModeScaleToFill;
        [scrollingImage setImage:image];

            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                ratingsView = [[UIView alloc]initWithFrame:CGRectMake(0, 180, scrMain.frame.size.width, 31)];
            }else{
                ratingsView = [[UIView alloc]initWithFrame:CGRectMake(0, 135, scrMain.frame.size.width, 31)];

            }
            ratingsView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
            [scrollingImage addSubview:ratingsView];
            
            
            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
            titleLabel.text = @"Robocop";
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.textColor = [UIColor whiteColor];
            titleLabel.font = [UIFont fontWithName:@"System Bold" size:15];
            [ratingsView addSubview:titleLabel];
            

            EDStarRating *_starRatingImage = [[EDStarRating alloc] initWithFrame:CGRectMake(160, -2, 105, 31)];
            [ratingsView addSubview:_starRatingImage];
            _starRatingImage.opaque = YES;

            _starRatingImage.starImage = [UIImage imageNamed:@"Unrated-Star.png"];
            _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"Star-Rating.png"];
            _starRatingImage.maxRating = 5.0;
            _starRatingImage.delegate = self;
            _starRatingImage.horizontalMargin = 5;
            _starRatingImage.editable=YES;
            _starRatingImage.rating= 2.5;
            _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
            
            
            UILabel *likesLabel = [[UILabel alloc]initWithFrame:CGRectMake(265, 5, 50, 20)];
            likesLabel.text = @"100%";
            likesLabel.backgroundColor = [UIColor clearColor];
            likesLabel.textColor = [UIColor whiteColor];
            likesLabel.font = [UIFont fontWithName:@"System Bold" size:15];
            [ratingsView addSubview:likesLabel];

        [scrMain addSubview:scrollingImage];
            
//        UITapGestureRecognizer* tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self
//                                                                               action:@selector(tap1)];
//        [imgv addGestureRecognizer:tap1];
        [imageScroll setUserInteractionEnabled:YES];
        [scrollingImage setUserInteractionEnabled:YES];
        
        }
    
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*[imagesArray count], scrMain.frame.size.height)];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter=100.0;
    locationManager.delegate = self;
    
    [locationManager startMonitoringSignificantLocationChanges];
    
   

}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    //[locationManager startUpdatingLocation];
    float latitude = newLocation.coordinate.latitude;
    float longitude = newLocation.coordinate.longitude;
    
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=true",latitude,longitude];
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:webStringURL]];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
   NSMutableString *loginResponseData=[[NSMutableString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
   NSMutableDictionary *json = [loginResponseData JSONValue];
    
    NSArray *currentLocationString = [[json valueForKey:@"results"] valueForKey:@"formatted_address"];
    
    NSMutableDictionary *localityDict;
    
    if ([[[[json valueForKey:@"results"] objectAtIndex:0] valueForKey:@"address_components"] count] > 4) {
        
        localityDict = [[[[json valueForKey:@"results"] objectAtIndex:0] valueForKey:@"address_components"] objectAtIndex:4];
        
    }else
    {
        
        localityDict = [[[[json valueForKey:@"results"] objectAtIndex:0] valueForKey:@"address_components"] objectAtIndex:3];
        
    }
    
    NSString *localityString = [localityDict valueForKey:@"long_name"];
    
    NSLog(@"description string %@ %@", currentLocationString, localityString);
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f", latitude] forKey:@"Latitude"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f", longitude] forKey:@"Longitude"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@", localityString] forKey:@"CityName"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
}

- (void)scrollingTimer {
    
    UIScrollView *scrMain = (UIScrollView*)[self.view viewWithTag:1];
    
    // UIPageControl *pgCtr = (UIPageControl*) [self.view viewWithTag:12];
    CGFloat contentOffset = scrMain.contentOffset.x;
    
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    //NSLog(@"next page %d", nextPage);
    
    if( nextPage!=[imagesArray count] )  {
        
        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, scrMain.frame.origin.y-113, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];

        // pgCtr.currentPage=nextPage;
        
    } else {
        
        [scrMain scrollRectToVisible:CGRectMake(0, scrMain.frame.origin.y-113, scrMain.frame.size.width, scrMain.frame.size.height) animated:NO];
        //pgCtr.currentPage=0;
        
    }
    
    
//    brandNameLabel.text = [brandNameArray objectAtIndex:k];
//    priceLabel.text = [priceArray objectAtIndex:k];
//    
//    k = k+1;
//    if (k == [brandNameArray count]-1) {
//        k = 0;
//    }else{
//        k++;
//    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)automotiveAction:(id)sender {
    
    AutomotiveViewController *automotive = [[AutomotiveViewController alloc]init];
    [self.navigationController pushViewController:automotive animated:YES];
    
}

- (IBAction)moviesAction:(id)sender {

    MoviesViewController *automotive = [[MoviesViewController alloc]init];
    [self.navigationController pushViewController:automotive animated:YES];

}

- (IBAction)healthNDBeautyAction:(id)sender {
    
    Health_BeautyViewController *health = [[Health_BeautyViewController alloc]initWithNibName:@"Health&BeautyViewController" bundle:nil];
    [self.navigationController pushViewController:health animated:YES];
}

- (IBAction)onlineShoppingAction:(id)sender {
    
    ProductListingViewController *shopping = [[ProductListingViewController alloc]initWithNibName:@"ProductListingViewController" bundle:nil];
    [self.navigationController pushViewController:shopping animated:YES];
}

- (IBAction)mobileAction:(id)sender {
    
    MobileViewController *mobile = [[MobileViewController alloc]init];
    [self.navigationController pushViewController:mobile animated:YES];
}

- (IBAction)travelNDRestaurentsAction:(id)sender {
    
    Travel_RestaurentsViewController *travel = [[Travel_RestaurentsViewController alloc]initWithNibName:@"Travel&RestaurentsViewController" bundle:nil];
    [self.navigationController pushViewController:travel animated:YES];
}



@end











