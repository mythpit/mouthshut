//
//  CustomOnlineCell.h
//  MouthShut
//
//  Created by Administrator on 24/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomOnlineCell : UITableViewCell
{
    
    
}

@property(nonatomic, retain)IBOutlet UIImageView *imageForCustomCell;

@property(nonatomic, retain)IBOutlet UILabel *cellTitleLabel;

@property(nonatomic, retain)IBOutlet UIView *ratingsView;

@property(nonatomic, retain)IBOutlet UILabel *reviewsLabel;

@property(nonatomic, retain)IBOutlet UILabel *likesLabel;


@end
