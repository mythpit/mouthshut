//
//  RecentViewController.m
//  MouthShut
//
//  Created by Administrator on 21/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "RecentViewController.h"

@interface RecentViewController ()

@end

@implementation RecentViewController

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
    
    self.title = @"Recent Reviews";
    
    [reviewsTable registerNib:[UINib nibWithNibName:@"CustomOnlineCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"CustomCellReuseID"];
    
    
    cellTitleArray = [[NSMutableArray alloc]initWithObjects:@"Label1", @"Label2", @"Label3", @"Label4", @"Label5", nil];
    
    cellImagesArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"], nil];

    reviewsTable.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:reviewsTable];

    // Do any additional setup after loading the view from its nib.
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

@end
