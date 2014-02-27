//
//  BuzzViewController.m
//  MouthShut
//
//  Created by Administrator on 21/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "BuzzViewController.h"

@interface BuzzViewController ()

@end

@implementation BuzzViewController

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
    
       self.title = @"Buzz";
    
    cellTitleArray = [[NSMutableArray alloc]initWithObjects:@"yes its working fine for me. but my app have Tabbacontroller alos", @"yes its working fine for me. but my app have Tabbacontroller alos", @"yes its working fine for me. but my app have Tabbacontroller alos", @"yes its working fine for me. but my app have Tabbacontroller alos", @"yes its working fine for me. but my app have Tabbacontroller alos", nil];
    
    cellImagesArray = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"],[UIImage imageNamed:@"image2.png"], nil];
    
    detailLabelArray = [[NSMutableArray alloc]initWithObjects:@"0 hrs 30 mins ago", @"few moments ago", @"few moments ago", @"12 hrs 15 mins ago", @"few moments ago", nil];
    
    buzzTable.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:buzzTable];
    
    // Do any additional setup after loading the view from its nib.
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
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
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    if (cell == nil){
        
    }
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    
    UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    [cell.contentView addSubview:cellImage];
    cellImage.image = [cellImagesArray objectAtIndex:indexPath.row];
    
    UILabel *cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(75, 5, 230, 60)];
    cellLabel.text = [cellTitleArray objectAtIndex:indexPath.row];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.numberOfLines = 3;
    cellLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cellLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
    // cellLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [cellLabel sizeToFit];
    cellLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:14];
    [cell.contentView addSubview:cellLabel];
    
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(210, cellLabel.frame.origin.y + cellLabel.frame.size.height -5, 100, 20)];
    detailLabel.text = [detailLabelArray objectAtIndex:indexPath.row];
    detailLabel.backgroundColor = [UIColor clearColor];
    detailLabel.textColor = [UIColor colorWithRed:102/255.0f green:102/255.0f blue:102/255.0f alpha:1.0];
    // cellLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:16];
    [detailLabel sizeToFit];
    detailLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    [cell.contentView addSubview:detailLabel];

    
//    UIButton *accessoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    accessoryButton.frame = CGRectMake(290, 15, 15, 15);
//    [cell.contentView addSubview:accessoryButton];
//    [accessoryButton setImage:[UIImage imageNamed:@"Next.png"] forState:UIControlStateNormal];
    
    
    //    if( [indexPath row] % 2)
    //        [cell.contentView setBackgroundColor:[UIColor colorWithRed:247/255.0f green:246/255.0f blue:244/255.0f alpha:1.0]];
    //    else
    //        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    
    return cell;
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
