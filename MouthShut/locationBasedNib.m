//
//  locationBasedNib.m
//  MouthShut
//
//  Created by Administrator on 26/02/14.
//  Copyright (c) 2014 MouthShut.com. All rights reserved.
//

#import "locationBasedNib.h"

@implementation locationBasedNib
@synthesize imageForCustomCell, cellTitleLabel, ratingsView, reviewsLabel, likesLabel, distanceLabel, distanceView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
