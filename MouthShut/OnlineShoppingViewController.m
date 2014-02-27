//
//  OnlineShoppingViewController.m
//  MouthShut
//
//  Created by Administrator on 24/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "OnlineShoppingViewController.h"
#import "CustomOnlineCell.h"

@interface OnlineShoppingViewController ()

@end

@implementation OnlineShoppingViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [tableVw registerNib:[UINib nibWithNibName:@"CustomOnlineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CustomCellReuseID"];

    self.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden=YES;
    
    self.title = @"Online Shopping";
    
    
    cellTitleArray = [[NSMutableArray alloc]initWithObjects:@"Label1", @"Label2", @"Label3", @"Label4", @"Label5", nil];
    
    cellImagesArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"], nil];

    if ([[UIScreen mainScreen] bounds].size.height == 568) {
    tabbarView.frame = CGRectMake(0, self.view.frame.size.height + 40, self.view.frame.size.width, 44);
    [self.view addSubview:tabbarView];
    }else{
        tabbarView.frame = CGRectMake(0, self.view.frame.size.height - 45, self.view.frame.size.width, 44);
        [self.view addSubview:tabbarView];
        
//        [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
//                                          forBarPosition:UIBarPositionAny
//                                              barMetrics:UIBarMetricsDefault];
//        UIImage *image = [[UIImage alloc] init];
//        image = [UIImage imageNamed:@"whiteTopLine.png"];
//        [[UINavigationBar appearance] setShadowImage:image];

    }
    
    
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
    
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.translucent = YES;

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
    static NSString *CellIdentifier = @"CustomCellReuseID";
    
    CustomOnlineCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        
        cell = [[CustomOnlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.cellTitleLabel.text = [cellTitleArray objectAtIndex:indexPath.row];
    cell.imageForCustomCell.image = [cellImagesArray objectAtIndex:indexPath.row];
    
    EDStarRating *_starRatingImage = [[EDStarRating alloc] initWithFrame:CGRectMake(0, 0, 105, 20)];
    [cell.ratingsView addSubview:_starRatingImage];
    _starRatingImage.opaque = YES;
    
    _starRatingImage.starImage = [UIImage imageNamed:@"Unrated-Star.png"];
    _starRatingImage.starHighlightedImage = [UIImage imageNamed:@"Star-Rating.png"];
    _starRatingImage.maxRating = 5.0;
    _starRatingImage.delegate = self;
    _starRatingImage.horizontalMargin = 0;
    _starRatingImage.editable=NO;
    _starRatingImage.rating= 2.5;
    _starRatingImage.displayMode=EDStarRatingDisplayAccurate;

    
    return cell;
    
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
    
}

- (IBAction)reviewAction:(id)sender {
    
}

- (IBAction)ratingsAction:(id)sender {
    
}

- (IBAction)recommendationsAction:(id)sender {
    
}


@end


