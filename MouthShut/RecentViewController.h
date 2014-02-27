//
//  RecentViewController.h
//  MouthShut
//
//  Created by Administrator on 21/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomOnlineCell.h"
#import "EDStarRating.h"

@interface RecentViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, EDStarRatingProtocol>{
    
    IBOutlet UITableView *reviewsTable;
    
    NSMutableArray *cellTitleArray;
    
    NSMutableArray *cellImagesArray;

}

@end
