//
//  ProductSearchViewController.m
//  MouthShut
//
//  Created by Administrator on 25/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "ProductSearchViewController.h"

@interface ProductSearchViewController ()

@end

@implementation ProductSearchViewController
@synthesize searchString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
        [rightButton setImage:[UIImage imageNamed:@"More.png"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(MoreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Product Search";
    
    [self performSelectorOnMainThread:@selector(showActivityIndicatorOnView:) withObject:self.view waitUntilDone:NO];
    [self performSelector:@selector(loadImagesFromServer) withObject:nil afterDelay:0.3];
    
    [productSearchTable registerNib:[UINib nibWithNibName:@"CustomOnlineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CustomCellReuseID"];
    
    
    productSearchTable.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:productSearchTable];
    // Do any additional setup after loading the view from its nib.
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


-(void)loadImagesFromServer{
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.mouthshut.com//android/app.asmx/getsrchprods?apikey=Mouthshutapp2013&srchword=%@&travel=&prev_last_cat_id=&subcat=", searchString];
    NSLog(@"search url string = %@", urlString);
    NSString* webStringURL = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:webStringURL]];
    NSError *error;
    NSURLResponse *response;
    NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    loginResponseData=[[NSMutableString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
    json = [loginResponseData JSONValue];
    if (json) {
        [hudView removeFromSuperview];
        
    NSLog(@"json response = %@", json);

    NSMutableArray *resultsArray = [[NSMutableArray alloc]initWithArray:[json valueForKey:@"results"]];
    cellTitleArray = [[NSMutableArray alloc]init];
    likesArray = [[NSMutableArray alloc]init];
    ratingsArray = [[NSMutableArray alloc]init];
    reviewsArray = [[NSMutableArray alloc]init];
    cellImagesArray = [[NSMutableArray alloc]init];
    cellImagesExtensionsArray = [[NSMutableArray alloc]init];
    cat_IdArray = [[NSMutableArray alloc]init];

    for (int i = 0; i < [resultsArray count]; i++) {
        [cellTitleArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"prodname"]];
        [ratingsArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"rating"]];
        [reviewsArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"reviewrating"]];
        [likesArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"recommendation"]];
        [cellImagesExtensionsArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"image"]];
        [cat_IdArray addObject:[[resultsArray objectAtIndex:i] valueForKey:@"cat_id"]];

        
        if ([[[resultsArray objectAtIndex:i] valueForKey:@"image"] isEqualToString:@""]) {
            [cellImagesArray addObject:@"Null"];
        }else{
            NSString *urlString = [NSString stringWithFormat:@"http://image3.mouthshut.com/images/imagesp/m/%@s%@", [[resultsArray objectAtIndex:i] valueForKey:@"cat_id"], [[resultsArray objectAtIndex:i] valueForKey:@"image"]];
            [cellImagesArray addObject:urlString];
            }

        }
   
        [productSearchTable reloadData];
    }
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
    static NSString *CellIdentifier = @"CustomCellReuseID";
    
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
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = cell.imageForCustomCell.center;// it will display in center of image view
    [cell.imageForCustomCell addSubview:indicator];
    [indicator startAnimating];
    
    
    if ([[cellImagesArray objectAtIndex:indexPath.row] isEqualToString:@"Null"]) {
        cell.imageForCustomCell.image = [self returnDefaultImage:[cat_IdArray objectAtIndex:indexPath.row]];
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
    
}

-(UIImage*)returnDefaultImage:(NSString*)cat_Id{
    UIImage *img;
    
    if ([cat_Id isEqualToString:@"169"]) {
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"145"]){
        img = [UIImage imageNamed:@""];

    }else if ([cat_Id isEqualToString:@"925040057"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925062123"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925757"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925758"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"950026"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925590675"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925602057"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"101"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"102"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925236"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925235"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925039311"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925039316"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925602729"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925642274"]){
        img = [UIImage imageNamed:@""];
        
    }else if ([cat_Id isEqualToString:@"925153"]){
        img = [UIImage imageNamed:@""];
        
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

@end
