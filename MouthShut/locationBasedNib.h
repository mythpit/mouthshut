//
//  locationBasedNib.h
//  MouthShut
//
//  Created by Administrator on 26/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface locationBasedNib : UITableViewCell

@property(nonatomic, retain)IBOutlet UIImageView *imageForCustomCell;

@property(nonatomic, retain)IBOutlet UILabel *cellTitleLabel;

@property(nonatomic, retain)IBOutlet UIView *ratingsView;

@property(nonatomic, retain)IBOutlet UILabel *reviewsLabel;

@property(nonatomic, retain)IBOutlet UILabel *likesLabel;

@property(nonatomic, retain)IBOutlet UIView *distanceView;

@property(nonatomic, retain)IBOutlet UILabel *distanceLabel;

@end
