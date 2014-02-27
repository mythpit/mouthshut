//
//  WriteReviewViewController.m
//  MouthShut
//
//  Created by Administrator on 21/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "WriteReviewViewController.h"

@interface WriteReviewViewController ()

@end

@implementation WriteReviewViewController

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
    
   // self.navigationController.navigationBar.translucent = NO;
    topView.frame = CGRectMake(0, 60, 320, 150);
    [self.view addSubview:topView];

    
    cellTitleArray = [[NSMutableArray alloc]initWithObjects:@"Automotives", @"Health & Beauty", @"Mobile", @"Movies",@"Online Shopping", @"Travel & Restaurants", nil];
    // Do any additional setup after loading the view from its nib.
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    sliderPane.frame = CGRectMake(-205, 60, 205, self.view.frame.size.height+40);
    [self.view addSubview:sliderPane];

    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseOut |  UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         sliderPane.frame = CGRectMake(0, 60, 205, self.view.frame.size.height);

                     }
                     completion:^(BOOL finished){
                }];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [sliderPane removeFromSuperview];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

- (IBAction)showCategoriesView:(id)sender {
}

- (IBAction)removeSliderPane {
    
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut | UIViewAnimationCurveEaseIn
                     animations:^{
                         
                         sliderPane.frame = CGRectMake(-205, 60, 205, self.view.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         NSLog(@"Done!");
                     }];

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
    
    return [cellTitleArray count];
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    // view.backgroundColor = [UIColor clearColor];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    categoryField.text = [cellTitleArray objectAtIndex:indexPath.row];
    [self removeSliderPane];
    
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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [cellTitleArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
    
    return cell;
    
}


@end



