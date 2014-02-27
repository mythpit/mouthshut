//
//  ProductSearchViewController.h
//  MouthShut
//
//  Created by Administrator on 25/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomOnlineCell.h"
#import "EDStarRating.h"
#import "SBJson.h"

@interface ProductSearchViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, EDStarRatingProtocol, UIActionSheetDelegate>{
    
    IBOutlet UITableView *productSearchTable;
    
    NSMutableArray *cellTitleArray;
    
    NSMutableArray *cellImagesExtensionsArray;
    
    NSMutableArray *cellImagesArray;

    NSMutableArray *ratingsArray;
    
    NSMutableArray *reviewsArray;
    
    NSMutableArray *likesArray;
    
    NSMutableArray *cat_IdArray;

    UIView *hudView;

    NSMutableString *loginResponseData;
    
    NSMutableDictionary *json;

}

@property(nonatomic, retain)NSString *searchString;


@end
