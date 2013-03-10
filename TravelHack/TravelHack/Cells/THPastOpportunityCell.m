//
//  THPastOpportunityCell.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THPastOpportunityCell.h"

@implementation THPastOpportunityCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"THPastOpportunityCell" owner:self options:nil];
        [self addSubview:[array objectAtIndex:0]];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		NSLog(@"%@", self.pointLabel);
	}
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat width = CGRectGetWidth(self.opportunityLabel.frame);
	self.opportunityLabel.numberOfLines = 2;
	[self.opportunityLabel sizeToFit];
	CGRect frame = self.opportunityLabel.frame;
	frame.size.width = width;
	
	self.opportunityLabel.frame = frame;
	
	self.dateLabel.frame = CGRectOffset(self.dateLabel.bounds, CGRectGetMinX(self.dateLabel.frame), CGRectGetMaxY(frame));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
