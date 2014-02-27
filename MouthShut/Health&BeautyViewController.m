//
//  Health&BeautyViewController.m
//  MouthShut
//
//  Created by Administrator on 24/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "Health&BeautyViewController.h"

@interface Health_BeautyViewController ()

@end

@implementation Health_BeautyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *image = [[UIImage alloc] init];
        image = [UIImage imageNamed:@""];
        [[UINavigationBar appearance] setShadowImage:image];

        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden=YES;

    self.title = @"Health & Beauty";
    
    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, 40)];
    searchBar.placeholder = @"Search Health & Beauty Products";
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    
    
    imagesArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"image1.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image3.png"],[UIImage imageNamed:@"image4.png"], nil];
    
    categaoryLabelArray = [[NSArray alloc]initWithObjects:@"Hospitals", @"Gyms", @"Spas", @"Parlors", nil];
    
    cellImagesArray = [[NSArray alloc]initWithObjects:[UIImage imageNamed:@"Hospital.png"],[UIImage imageNamed:@"Gym.png"],[UIImage imageNamed:@"Spas.png"],[UIImage imageNamed:@"Parlour.png"], nil];
    

    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(280, 10, 20, 20)];
    [rightButton setImage:[UIImage imageNamed:@"More.png"] forState:UIControlStateNormal];
     [rightButton addTarget:self action:@selector(MoreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    UIScrollView *scr;
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        scr =[[UIScrollView alloc] initWithFrame:CGRectMake(0, 105, self.view.frame.size.width, 215)];
        
    }else{
        scr=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 105, self.view.frame.size.width, 140)];
        
    }
    
    
    scr.backgroundColor = [UIColor grayColor];
    scr.tag = 1;
    scr.autoresizingMask=UIViewAutoresizingNone;
    [self.view addSubview:scr];
    [self setupScrollView:scr];
    
    UITableView *tableCategory;
    UILabel *titleLabel;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, scr.frame.origin.y + scr.frame.size.height+5, 200, 30)];
        tableCategory = [[UITableView alloc]initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + titleLabel.frame.size.height+5, 320, [categaoryLabelArray count]*40) style:UITableViewStylePlain];
        
    }else{
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, scr.frame.origin.y + scr.frame.size.height, 200, 30)];
        tableCategory = [[UITableView alloc]initWithFrame:CGRectMake(0, titleLabel.frame.origin.y + titleLabel.frame.size.height-4, 320, [categaoryLabelArray count]*40) style:UITableViewStylePlain];
        
    }
    
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"Choose Category";
    titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    titleLabel.textColor = [UIColor colorWithRed:118/255.0 green:164/255.0 blue:78/255.0 alpha:1.0];
    [self.view addSubview:titleLabel];
    
    
    
    tableCategory.delegate = self;
    tableCategory.dataSource = self;
    [self.view addSubview:tableCategory];
    tableCategory.layer.borderWidth = 0.5;
    tableCategory.layer.borderColor = [[UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0] CGColor];
    
    tabbarView.frame = CGRectMake(0, self.view.frame.size.height-45, self.view.frame.size.width, 45);
    [self.view addSubview:tabbarView];
    
    CALayer *TopBorder = [CALayer layer];
    TopBorder.frame = CGRectMake(105.0f, 0.0f, 0.5f,buzzBgView.frame.size.width);
    TopBorder.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0].CGColor;
    [buzzBgView.layer addSublayer:TopBorder];
    
    CALayer *TopBorder1 = [CALayer layer];
    TopBorder1.frame = CGRectMake(105.0f, 0.0f, 0.5f,recentReviewBgView.frame.size.width);
    TopBorder1.backgroundColor = [UIColor colorWithRed:178/255.0 green:178/255.0 blue:178/255.0 alpha:1.0].CGColor;
    [recentReviewBgView.layer addSublayer:TopBorder1];
    
    [buzzBtn setImage:[UIImage imageNamed:@"Buzz-Blue.png"] forState:UIControlStateSelected];
    [recentReviewsBtn setImage:[UIImage imageNamed:@"Recent-Visits-Blue.png"] forState:UIControlStateSelected];
    [writeReviewBtn setImage:[UIImage imageNamed:@"Write-Review-Blue.png"] forState:UIControlStateSelected];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchbar{
    
    [searchbar resignFirstResponder];
    ProductSearchViewController *product = [[ProductSearchViewController alloc]initWithNibName:@"ProductSearchViewController" bundle:nil];
    product.searchString = searchBar.text;
    [self.navigationController pushViewController:product animated:YES];
    
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

- (void)setupScrollView:(UIScrollView*)scrMain {
    
    for (int i = 1; i<[imagesArray count]+1; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"image%d.png",i]];
        UIImageView *scrollingImage;
        
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            scrollingImage = [[UIImageView alloc]initWithFrame:CGRectMake((i - 1)*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)];
            
        }else{
            scrollingImage  = [[UIImageView alloc]initWithFrame:CGRectMake((i - 1)*scrMain.frame.size.width, 0, scrMain.frame.size.width, scrMain.frame.size.height)];
            
        }
        
        scrollingImage.contentMode = UIViewContentModeScaleToFill;
        [scrollingImage setImage:image];
        
        UIView *ratingsView = [[UIView alloc]initWithFrame:CGRectMake(0, scrMain.frame.size.height-31, scrMain.frame.size.width, 31)];
        // ratingsView.backgroundColor = [UIColor blackColor];
        ratingsView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        [scrollingImage addSubview:ratingsView];
        
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
        titleLabel.text = @"Robocop";
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont fontWithName:@"System Bold" size:15];
        [ratingsView addSubview:titleLabel];
        
        
        EDStarRating *_starRatingImage = [[EDStarRating alloc] initWithFrame:CGRectMake(160, -2, 105, 31)];
        //_starRatingImage.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        // _starRatingImage.alpha = 1.0;
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
        [scrMain setUserInteractionEnabled:YES];
        [scrollingImage setUserInteractionEnabled:YES];
        
    }
    
    [scrMain setContentSize:CGSizeMake(scrMain.frame.size.width*[imagesArray count], scrMain.frame.size.height)];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(scrollingTimer) userInfo:nil repeats:YES];
}


- (void)scrollingTimer {
    
    UIScrollView *scrMain = (UIScrollView*)[self.view viewWithTag:1];
    
    CGFloat contentOffset = scrMain.contentOffset.x;
    
    int nextPage = (int)(contentOffset/scrMain.frame.size.width) + 1 ;
    
    if( nextPage!=[imagesArray count] )  {
        
        [scrMain scrollRectToVisible:CGRectMake(nextPage*scrMain.frame.size.width, scrMain.frame.origin.y-113, scrMain.frame.size.width, scrMain.frame.size.height) animated:YES];
        
    } else {
        
        [scrMain scrollRectToVisible:CGRectMake(0, scrMain.frame.origin.y-113, scrMain.frame.size.width, scrMain.frame.size.height) animated:NO];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [categaoryLabelArray count];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    // view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductListingViewController *product = [[ProductListingViewController alloc]init];
    product.catName = [categaoryLabelArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:product animated:YES];
    
    [tableView deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil){
        
    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 25, 25)];
    [cell.contentView addSubview:cellImage];
    cellImage.image = [cellImagesArray objectAtIndex:indexPath.row];
    
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200, 20)];
    cellLabel.text = [categaoryLabelArray objectAtIndex:indexPath.row];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
    // cellLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    cellLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    [cell.contentView addSubview:cellLabel];
    
    
    UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    accessoryButton.frame = CGRectMake(290, 15, 15, 15);
    [cell.contentView addSubview:accessoryButton];
    [accessoryButton setImage:[UIImage imageNamed:@"Next.png"] forState:UIControlStateNormal];
    
    
    //    if( [indexPath row] % 2)
    //        [cell.contentView setBackgroundColor:[UIColor colorWithRed:247/255.0f green:246/255.0f blue:244/255.0f alpha:1.0]];
    //    else
    //        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    return cell;
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
