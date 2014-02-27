//
//  WriteReviewViewController.h
//  MouthShut
//
//  Created by Administrator on 21/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WriteReviewViewController : UIViewController<UITextFieldDelegate, UITableViewDataSource , UITableViewDelegate>
{
    
    IBOutlet UITextField *categoryField;
    
    IBOutlet UITextField *productField;
    
    IBOutlet UIView *sliderPane;
    
    IBOutlet UITableView *listTable;
    
    NSMutableArray *cellTitleArray;
    
    IBOutlet UIControl *topView;
    
    IBOutlet UIView *reviewScreen;
    
    IBOutlet UIScrollView *scrollVw;
}

- (IBAction)showCategoriesView:(id)sender;

- (IBAction)removeSliderPane;

@end
