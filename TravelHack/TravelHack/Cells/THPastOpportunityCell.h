//
//  THPastOpportunityCell.h
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THOpportunity.h"

@interface THPastOpportunityCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *opportunityLabel;
@property (nonatomic, strong) IBOutlet UILabel *dateLabel;
@property (nonatomic, strong) IBOutlet UIImageView *opportunityIcon;
@property (nonatomic, strong) IBOutlet UILabel *pointLabel;

- (void)setOpportunity:(THOpportunity *)opportunity;
@end
