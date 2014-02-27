 //
//  ProductListingViewController.m
//  MouthShut
//
//  Created by Administrator on 25/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "ProductListingViewController.h"
#import "CustomOnlineCell.h"
#import "locationBasedNib.h"

@interface ProductListingViewController ()

@end

@implementation ProductListingViewController
@synthesize catName, isLocationBased;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    actionFlagString = @"Popular";

    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Frequency"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"Criteria"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    [self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
    [self performSelector:@selector(fetchProductResultFromServer) withObject:nil afterDelay:0.3];
    
    [tableVw registerNib:[UINib nibWithNibName:@"CustomOnlineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CustomCellReuseID"];
    
    [tableVw registerNib:[UINib nibWithNibName:@"locationBasedNib" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"LocationCellReuseID"];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden=YES;
    
    self.title = @"Product Listing";
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        tabbarView.frame = CGRectMake(0, self.view.frame.size.height + 40, self.view.frame.size.width, 44);
        [self.view addSubview:tabbarView];
    }else{
        tabbarView.frame = CGRectMake(0, self.view.frame.size.height - 45, self.view.frame.size.width, 44);
        [self.view addSubview:tabbarView];
    }
    
    if (!isLocationBased) {
    [popularBtn setTitle:@"Popular" forState:UIControlStateNormal] ;
    }else{
        [popularBtn setTitle:@"Proximity" forState:UIControlStateNormal] ;
    }
    popularBtn.backgroundColor = [UIColor blueColor];
    [popularBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(105.0f, 0.0f, 0.5f,buzzBgView.frame.size.width);
    TopBorder.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0].CGColor;
    [buzzBgView.layer addSublayer:TopBorder];
    
    CALayer *TopBorder1 = [CALayer layer];
    TopBorder1.frame = CGRectMake(105.0f, 0.0f, 0.5f,recentReviewBgView.frame.size.width);
    TopBorder1.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0].CGColor;
    [recentReviewBgView.layer addSublayer:TopBorder1];
    
    CALayer *TopBorder2 = [CALayer layer];
    TopBorder2.frame = CGRectMake(0.0f, 0.0f, tabbarView.frame.size.width, 0.5f);
    TopBorder2.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0].CGColor;
    [tabbarView.layer addSublayer:TopBorder2];
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
    [rightButton setImage:[UIImage imageNamed:@"More.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(MoreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    topSegmentedBar.layer.borderColor = [[UIColor blueColor] CGColor];
    topSegmentedBar.layer.borderWidth = 0.5;
    topSegmentedBar.layer.cornerRadius = 6.0;
    
    UIBezierPath *maskPath;
    maskPath = [UIBezierPath bezierPathWithRoundedRect:popularBtn.bounds byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) cornerRadii:CGSizeMake(6.0, 6.0)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    popularBtn.layer.mask = maskLayer;
    
    
    UIBezierPath *maskPath1;
    maskPath1 = [UIBezierPath bezierPathWithRoundedRect:recommendationsBtn.bounds byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) cornerRadii:CGSizeMake(6.0, 6.0)];
    
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.view.bounds;
    maskLayer1.path = maskPath1.CGPath;
    recommendationsBtn.layer.mask = maskLayer1;

    
    review_DateArray = [[NSMutableArray alloc]initWithCapacity:200];
    last_cat_idArray = [[NSMutableArray alloc]initWithCapacity:200];
    frequencyArray = [[NSMutableArray alloc]initWithCapacity:200];
    distanceArray = [[NSMutableArray alloc]initWithCapacity:200];
    cellTitleArray = [[NSMutableArray alloc]initWithCapacity:200];
    likesArray = [[NSMutableArray alloc]initWithCapacity:200];
    ratingsArray = [[NSMutableArray alloc]initWithCapacity:200];
    reviewsArray = [[NSMutableArray alloc]initWithCapacity:200];
    cellImagesArray = [[NSMutableArray alloc]initWithCapacity:200];
    cat_IdArray = [[NSMutableArray alloc]initWithCapacity:200];
    cellImagesExtensionsArray = [[NSMutableArray alloc]initWithCapacity:200];

    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    
    latitude_String = [[NSUserDefaults standardUserDefaults]objectForKey:@"Latitude"];
    longitude_String = [[NSUserDefaults standardUserDefaults]objectForKey:@"Longitude"];
    city_param = [[NSUserDefaults standardUserDefaults]objectForKey:@"CityName"];

    review_Date = @"";
    last_Product_Name = @"";
    level_String = @"";
    distance_Param = @"";

}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;
    
}

-(void)fetchProductResultFromServer{
    
    NSLog(@"cell array count = %@", [[NSUserDefaults standardUserDefaults]objectForKey:@"Frequency"]);
    
    NSString *urlString = [NSString stringWithFormat:@"http://mqauc.sevenpv.com//android/app.asmx/getPopularProds?apikey=Mouthshutapp2013&review_date=%@&prev_last_cat_id=%@&prev_frequency_rating=%@&level1=%@&lat=%@&lang=%@&lastnearestdist=%@&catname=%@&city=%@&othercriteria=%@", review_Date, last_Product_Name, [[NSUserDefaults standardUserDefaults]objectForKey:@"Frequency"], [self returnCatName:catName], latitude_String, longitude_String, distance_Param,last_Product_Name, city_param, [[NSUserDefaults standardUserDefaults]objectForKey:@"Criteria"]];
    
    urlString = [urlString stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    
    NSLog(@"search url string = %@", urlString);
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:webStringURL]];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    loginResponseData=[[NSMutableString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    json = [loginResponseData JSONValue];
    NSMutableArray *resultsArray = [[NSMutableArray alloc]initWithArray:[json valueForKey:@"results"]];

    if (json) {
        [hudView removeFromSuperview];
        
        if (!noMoreRecords) {
            
        for (int i = 0; i < [resultsArray count]; i++) {
            [cellTitleArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"prodname"]];
            [ratingsArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"rating"]];
            [reviewsArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"Reviewcnt"]];
            [likesArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"recommendation"]];
            [cellImagesExtensionsArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"image"]];
            [cat_IdArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"cat_id"]];
            
            [review_DateArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"review_date"]];
            [frequencyArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"frequency"]];
            [distanceArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"distance"]];

            
            if ([[[resultsArray objectAtIndex:i] valueForKey:@"image"] isEqualToString:@""]) {
                [cellImagesArray addObject:@"Null"];
            }else{
                NSString *urlString = [NSString stringWithFormat:@"http://image3.mouthshut.com/images/imagesp/m/%@s%@", [[resultsArray objectAtIndex:i] valueForKey:@"cat_id"], [[resultsArray objectAtIndex:i] valueForKey:@"image"]];
                [cellImagesArray addObject:urlString];
            }
            [tableVw reloadData];
            [indicator stopAnimating];
            }
            if ([resultsArray count] < 10) {
                noMoreRecords = YES;
            }else
                noMoreRecords = NO;
        }else
            [hudView removeFromSuperview];

    }else
        [hudView removeFromSuperview];


    
//    NSArray *copy = [companyArray copy];
//    NSInteger index = [copy count] - 1;
//    for (id object in [copy reverseObjectEnumerator]) {
//        if ([companyArray indexOfObject:object inRange:NSMakeRange(0, index)] != NSNotFound) {
//            [companyArray removeObjectAtIndex:index];
//        }
//        index--;
//    }

    NSLog(@"json response = %@", json);

}

-(NSString*)returnCatName:(NSString*)cat_name{
    
    NSString *cat_Id;
    
    if( [cat_name caseInsensitiveCompare:@"Restaurants"] == NSOrderedSame ) {
        cat_Id = @"169";
        
    }else if ([cat_name caseInsensitiveCompare:@"Hotels"] == NSOrderedSame){
        cat_Id = @"145";
        
    }else if ([cat_name caseInsensitiveCompare:@"car dealers"] == NSOrderedSame){
        cat_Id = @"925040057";
        
    }else if ([cat_name caseInsensitiveCompare:@"bike dealers"] == NSOrderedSame){
        cat_Id = @"925062123";
        
    }else if ([cat_name caseInsensitiveCompare:@"hospitals"] == NSOrderedSame){
        cat_Id = @"925757";
        
    }else if ([cat_name caseInsensitiveCompare:@"gyms"] == NSOrderedSame){
        cat_Id = @"925758";
        
    }else if ([cat_name caseInsensitiveCompare:@"theatres"] == NSOrderedSame){
        cat_Id = @"950026";
        
    }else if ([cat_name caseInsensitiveCompare:@"parlors"] == NSOrderedSame){
        cat_Id = @"925590675";
        
    }else if ([cat_name caseInsensitiveCompare:@"spas"] == NSOrderedSame){
        cat_Id = @"925602057";
        
    }else if ([cat_name caseInsensitiveCompare:@"cars & suvs"] == NSOrderedSame){
        cat_Id = @"101";
        
    }else if ([cat_name caseInsensitiveCompare:@"Bikes"] == NSOrderedSame){
        cat_Id = @"102";
        
    }else if ([cat_name caseInsensitiveCompare:@"HOLLYWOOD"] == NSOrderedSame){
        cat_Id = @"925236";
        
    }else if ([cat_name caseInsensitiveCompare:@"BOLLYWOOD"] == NSOrderedSame){
        cat_Id = @"925235";
        
    }else if ([cat_name caseInsensitiveCompare:@"tamil"] == NSOrderedSame){
        cat_Id = @"925039311";
        
    }else if ([cat_name caseInsensitiveCompare:@"telugu"] == NSOrderedSame){
        cat_Id = @"925039316";
        
    }else if ([cat_name caseInsensitiveCompare:@"mobiles"] == NSOrderedSame){
        cat_Id = @"925602729";
        
    }else if ([cat_name caseInsensitiveCompare:@"tablets"] == NSOrderedSame){
        cat_Id = @"925642274";
        
    }else if ([cat_name caseInsensitiveCompare:@"online shopping"] == NSOrderedSame){
        cat_Id = @"925153";
        
    }else if ([cat_name caseInsensitiveCompare:@"tourist attraction"] == NSOrderedSame){
        cat_Id = @"142";
        
    }
    
    return cat_Id;
}

- (UIActivityIndicatorView *)showActivityIndicatorOnView:(UIView*)aView
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
    captionLabel.text = [NSString stringWithFormat:@"Please wait..."];
    captionLabel.numberOfLines = 2;
    captionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    [hudView addSubview:captionLabel];
    
    [self.view addSubview:hudView];
    hudView.center = self.view.center;
    return activityIndicatorView;
}



-(void)MoreButtonClicked{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Sign In",
                            @"Privacy Policy",
                            @"Terms & Conditions",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    NSLog(@"case 1 clicked");
                    break;
                case 1:
                    break;
                case 2:
                    break;
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    for (UIView *subview in actionSheet.subviews) {
        if ([subview isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)subview;
            if ([button.titleLabel.text isEqualToString:@"Sign In"]) {
                [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            }
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [cellTitleArray count];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    // view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    if (!isLocationBased) {
       CellIdentifier  = @"CustomCellReuseID";
        CustomOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil){
            
            cell = [[CustomOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        cell.cellTitleLabel.text = [cellTitleArray objectAtIndex:indexPath.row];
        // cell.imageForCustomCell.image = [cellImagesArray objectAtIndex:indexPath.row];
        int temp = [[reviewsArray objectAtIndex:indexPath.row] intValue];
        if (temp > 1) {
            cell.reviewsLabel.text = [NSString stringWithFormat:@"%d Reviews", temp];
        }else
            cell.reviewsLabel.text = [NSString stringWithFormat:@"%d Review", temp];
        
        NSString *str = [likesArray objectAtIndex:indexPath.row];
        NSString *str1 = @"%";
        cell.likesLabel.text = [NSString stringWithFormat:@"%@%@",str, str1];
        
        EDStarRating *_starRatingImage = [[EDStarRating alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
        [cell.ratingsView addSubview:_starRatingImage];
        _starRatingImage.opaque = YES;
        
        _starRatingImage.starImage = [UIImage imageNamed:@"Unrated-Star.png"];
        _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"Star-Rating.png"];
        _starRatingImage.maxRating = 5.0;
        _starRatingImage.delegate = self;
        _starRatingImage.horizontalMargin = 0;
        _starRatingImage.editable=NO;
        _starRatingImage.rating= [[ratingsArray objectAtIndex:indexPath.row] floatValue];
        _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
        
        
        // UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 120, 100)];
        // cellImage.image = [self.celebrityArray objectAtIndex:indexPath.row];
        // [cell.contentView addSubview:cellImage];
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.center = cell.imageForCustomCell.center;// it will display in center of image view
        [cell.imageForCustomCell addSubview:indicator];
        [indicator startAnimating];
        
        
        if ([[cellImagesArray objectAtIndex:indexPath.row] isEqualToString:@"Null"]) {
            cell.imageForCustomCell.image = [self returnDefaultImage:[self returnCatName:catName]];
            NSLog(@"image for default cell = %@", [self returnDefaultImage:[self returnCatName:catName]]);
            [indicator removeFromSuperview];
        }else{
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[cellImagesArray objectAtIndex:indexPath.row]] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
                NSURLResponse *returnedResponse = nil;
                NSError *returnedError = nil;
                NSData *itemData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&returnedResponse error:&returnedError];
                
                // self.imageData = itemData;
                
                UIImage *img = [[UIImage alloc] initWithData:itemData];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    cell.imageForCustomCell.image = img;
                    [indicator removeFromSuperview];
                });
            });
        }
        return cell;

    }else{
        
        CellIdentifier = @"LocationCellReuseID";
        locationBasedNib *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil){
            
            cell = [[locationBasedNib alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        
        cell.distanceView.backgroundColor = [UIColor lightGrayColor];
        NSString *dist = [distanceArray objectAtIndex:indexPath.row];
        float distnce = [[distanceArray objectAtIndex:indexPath.row] floatValue];
        
        if ([dist isEqualToString:@"10000"]) {
            dist = @"NA";
            cell.distanceLabel.text = [NSString stringWithFormat:@"%@", dist];
        }else
            cell.distanceLabel.text =[NSString stringWithFormat:@"%@ Km", dist];
        
        if (distnce > 50) {
            cell.distanceLabel.text = [NSString stringWithFormat:@"50+ Km"];
        }
        
        cell.cellTitleLabel.text = [cellTitleArray objectAtIndex:indexPath.row];
        // cell.imageForCustomCell.image = [cellImagesArray objectAtIndex:indexPath.row];
        int temp = [[reviewsArray objectAtIndex:indexPath.row] intValue];
        if (temp > 1) {
            cell.reviewsLabel.text = [NSString stringWithFormat:@"%d Reviews", temp];
        }else
            cell.reviewsLabel.text = [NSString stringWithFormat:@"%d Review", temp];
        
        NSString *str = [likesArray objectAtIndex:indexPath.row];
        NSString *str1 = @"%";
        cell.likesLabel.text = [NSString stringWithFormat:@"%@%@",str, str1];
        
        EDStarRating *_starRatingImage = [[EDStarRating alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
        [cell.ratingsView addSubview:_starRatingImage];
        _starRatingImage.opaque = YES;
        
        _starRatingImage.starImage = [UIImage imageNamed:@"Unrated-Star.png"];
        _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"Star-Rating.png"];
        _starRatingImage.maxRating = 5.0;
        _starRatingImage.delegate = self;
        _starRatingImage.horizontalMargin = 0;
        _starRatingImage.editable=NO;
        _starRatingImage.rating= [[ratingsArray objectAtIndex:indexPath.row] floatValue];
        _starRatingImage.displayMode=EDStarRatingDisplayAccurate;
        
        
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.center = cell.imageForCustomCell.center;// it will display in center of image view
        [cell.imageForCustomCell addSubview:indicator];
        [indicator startAnimating];
        
        
        if ([[cellImagesArray objectAtIndex:indexPath.row] isEqualToString:@"Null"]) {
            cell.imageForCustomCell.image = [self returnDefaultImage:[self returnCatName:catName]];
            [indicator removeFromSuperview];
        }else{
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[cellImagesArray objectAtIndex:indexPath.row]]];
                NSURLResponse *returnedResponse = nil;
                NSError *returnedError = nil;
                NSData *itemData  = [NSURLConnection sendSynchronousRequest:request returningResponse:&returnedResponse error:&returnedError];
                
                // self.imageData = itemData;
                
                UIImage *img = [[UIImage alloc] initWithData:itemData];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    
                    cell.imageForCustomCell.image = img;
                    [indicator removeFromSuperview];
                });
            });
        }
        return cell;

    }
    
    
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [cellTitleArray count] - 1) //self.array is the array of items you are displaying
    {
        //If it is the last cell, Add items to your array here & update the table view
        
        review_Date = [review_DateArray lastObject];
        prev_frequency_String = [frequencyArray lastObject];
        distance_Param = [distanceArray lastObject];
        if ([review_Date isEqualToString:@"1900-01-01 00:00:00.000"] && [prev_frequency_String isEqualToString:@"0"] && !isLocationBased) {
            last_Product_Name = @"";
        }else
        last_Product_Name = [cellTitleArray lastObject];

        if ([actionFlagString isEqualToString:@"Popular"]) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[frequencyArray lastObject] forKey:@"Frequency"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        }else if ([actionFlagString isEqualToString:@"Review"]) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[reviewsArray lastObject] forKey:@"Frequency"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        }else if ([actionFlagString isEqualToString:@"Rating"]) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[ratingsArray lastObject] forKey:@"Frequency"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        }else if ([actionFlagString isEqualToString:@"Recommendation"]) {
            
            [[NSUserDefaults standardUserDefaults]setObject:[likesArray lastObject] forKey:@"Frequency"];
            [[NSUserDefaults standardUserDefaults]synchronize];

        }
        
        UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [spinner startAnimating];
        spinner.frame = CGRectMake(0, 0, 320, 44);
        tableView.tableFooterView = spinner;
        
        //[self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
        [self performSelector:@selector(fetchProductResultFromServer) withObject:nil afterDelay:0.1];
        
    }
}




-(UIImage*)returnDefaultImage:(NSString*)cat_Id{
    UIImage *img;
    
    if ([cat_Id isEqualToString:@"169"]) {
        img = [UIImage imageNamed:@"Restaurants-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"145"]){
        img = [UIImage imageNamed:@"Restaurants-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925040057"]){
        img = [UIImage imageNamed:@"Car-Dealers-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925062123"]){
        img = [UIImage imageNamed:@"Bike-Dealers-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925757"]){
        img = [UIImage imageNamed:@"Hospitals-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925758"]){
        img = [UIImage imageNamed:@"Gyms-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"950026"]){
        img = [UIImage imageNamed:@"Movie-Theaters-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925590675"]){
        img = [UIImage imageNamed:@"Parlours-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925602057"]){
        img = [UIImage imageNamed:@"Spa-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"101"]){
        img = [UIImage imageNamed:@"Cars-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"102"]){
        img = [UIImage imageNamed:@"Bikes-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925236"]){
        img = [UIImage imageNamed:@"Movies-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925235"]){
        img = [UIImage imageNamed:@"Movies-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925039311"]){
        img = [UIImage imageNamed:@"Movies-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925039316"]){
        img = [UIImage imageNamed:@"Movies-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925602729"]){
        img = [UIImage imageNamed:@"Mobiles-and-Tablets-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925642274"]){
        img = [UIImage imageNamed:@"Mobiles-and-Tablets-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"925153"]){
        img = [UIImage imageNamed:@"Online-Shopping-Default.png"];
        
    }else if ([cat_Id isEqualToString:@"142"]){
        img = [UIImage imageNamed:@""];
        
    }
    
    return img;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buzzAction:(id)sender {
    BuzzViewController *buzz = [[BuzzViewController alloc]initWithNibName:@"BuzzViewController" bundle:nil];
    [self.navigationController pushViewController:buzz animated:YES];
    
}

- (IBAction)recentReviewsAction:(id)sender {
    RecentViewController *travel = [[RecentViewController alloc]initWithNibName:@"RecentViewController" bundle:nil];
    [self.navigationController pushViewController:travel animated:YES];
    
}

- (IBAction)writeReviewAction:(id)sender {
    
}

- (IBAction)popularAction:(id)sender {
    
    popularBtn.backgroundColor = [UIColor blueColor];
    [popularBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    reviewBtn.backgroundColor = [UIColor whiteColor];
    [reviewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    ratingsBtn.backgroundColor = [UIColor whiteColor];
    [ratingsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    recommendationsBtn.backgroundColor = [UIColor whiteColor];
    [recommendationsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    NSString *str = @"";

    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Criteria"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    actionFlagString = @"Popular";
    
    review_Date = @"";
    last_Product_Name = @"";
    prev_frequency_String = @"";
    level_String = @"";
    distance_Param = @"";

    [review_DateArray removeAllObjects];
    [last_cat_idArray removeAllObjects];
    [frequencyArray removeAllObjects];
    [distanceArray removeAllObjects];
    [cellTitleArray removeAllObjects];
    [likesArray removeAllObjects];
    [ratingsArray removeAllObjects];
    [reviewsArray removeAllObjects];
    [cellImagesArray removeAllObjects];
    [cat_IdArray removeAllObjects];
    [cellImagesExtensionsArray removeAllObjects];

    [self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
    [self performSelector:@selector(fetchProductResultFromServer) withObject:nil afterDelay:0.2];
}

- (IBAction)reviewAction:(id)sender {
    
    reviewBtn.backgroundColor = [UIColor blueColor];
    [reviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    popularBtn.backgroundColor = [UIColor whiteColor];
    [popularBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    ratingsBtn.backgroundColor = [UIColor whiteColor];
    [ratingsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    recommendationsBtn.backgroundColor = [UIColor whiteColor];
    [recommendationsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    NSString *str = @"mds.ReviewCount";

    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Criteria"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    actionFlagString = @"Review";

    review_Date = @"";
    last_Product_Name = @"";
    prev_frequency_String = @"";
    level_String = @"";
    distance_Param = @"";

    [review_DateArray removeAllObjects];
    [last_cat_idArray removeAllObjects];
    [frequencyArray removeAllObjects];
    [distanceArray removeAllObjects];
    [cellTitleArray removeAllObjects];
    [likesArray removeAllObjects];
    [ratingsArray removeAllObjects];
    [reviewsArray removeAllObjects];
    [cellImagesArray removeAllObjects];
    [cat_IdArray removeAllObjects];
    [cellImagesExtensionsArray removeAllObjects];

    [self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
    [self performSelector:@selector(fetchProductResultFromServer) withObject:nil afterDelay:0.2];
}

- (IBAction)ratingsAction:(id)sender {
    
    ratingsBtn.backgroundColor = [UIColor blueColor];
    [ratingsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    reviewBtn.backgroundColor = [UIColor whiteColor];
    [reviewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    popularBtn.backgroundColor = [UIColor whiteColor];
    [popularBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    recommendationsBtn.backgroundColor = [UIColor whiteColor];
    [recommendationsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    NSString *str = @"mds.rating";

    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Criteria"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    actionFlagString = @"Rating";

    review_Date = @"";
    last_Product_Name = @"";
    prev_frequency_String = @"";
    level_String = @"";
    distance_Param = @"";

    [review_DateArray removeAllObjects];
    [last_cat_idArray removeAllObjects];
    [frequencyArray removeAllObjects];
    [distanceArray removeAllObjects];
    [cellTitleArray removeAllObjects];
    [likesArray removeAllObjects];
    [ratingsArray removeAllObjects];
    [reviewsArray removeAllObjects];
    [cellImagesArray removeAllObjects];
    [cat_IdArray removeAllObjects];
    [cellImagesExtensionsArray removeAllObjects];

    [self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
    [self performSelector:@selector(fetchProductResultFromServer) withObject:nil afterDelay:0.2];
}

- (IBAction)recommendationsAction:(id)sender {
    
    recommendationsBtn.backgroundColor = [UIColor blueColor];
    [recommendationsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    reviewBtn.backgroundColor = [UIColor whiteColor];
    [reviewBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    ratingsBtn.backgroundColor = [UIColor whiteColor];
    [ratingsBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    popularBtn.backgroundColor = [UIColor whiteColor];
    [popularBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    NSString *str = @"mds.recommendation";

    [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"Criteria"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    actionFlagString = @"Recommendation";

    review_Date = @"";
    last_Product_Name = @"";
    prev_frequency_String = @"";
    level_String = @"";
    distance_Param = @"";

    [review_DateArray removeAllObjects];
    [last_cat_idArray removeAllObjects];
    [frequencyArray removeAllObjects];
    [distanceArray removeAllObjects];
    [cellTitleArray removeAllObjects];
    [likesArray removeAllObjects];
    [ratingsArray removeAllObjects];
    [reviewsArray removeAllObjects];
    [cellImagesArray removeAllObjects];
    [cat_IdArray removeAllObjects];
    [cellImagesExtensionsArray removeAllObjects];

    [self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
    [self performSelector:@selector(fetchProductResultFromServer) withObject:nil afterDelay:0.2];
}


@end
