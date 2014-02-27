//
//  BuzzViewController.h
//  MouthShut
//
//  Created by Administrator on 21/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuzzViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    
    IBOutlet UITableView *buzzTable;
    
    NSMutableArray *cellTitleArray;
    
    NSMutableArray *detailLabelArray;
    
    NSMutableArray *cellImagesArray;
}

@end
