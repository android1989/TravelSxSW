//
//  THAccountSummaryView.m
//  TravelHack
//
//  Created by John Lawson on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THAccountSummaryView.h"

@interface THAccountSummaryView ()

@end

@implementation THAccountSummaryView

#pragma mark - Properties
- (void)setBadgeImage:(UIImage *)badgeImage
{
	self.badgeImageView.image = badgeImage;
}

- (void)setCurrentPoints:(NSUInteger)currentPoints
{
	static NSNumberFormatter *currencyFormatter = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		currencyFormatter = [[NSNumberFormatter alloc] init];
		currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
		currencyFormatter.currencySymbol = @"";
		currencyFormatter.maximumFractionDigits = 0;
	});
	self.currentPointsLabel.text = [currencyFormatter stringFromNumber:@(currentPoints)];
}

#pragma mark - UIView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // badge image view
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		[self addSubview:imageView];
		imageView.backgroundColor = [UIColor clearColor];
		self.badgeImageView = imageView;
		
		// current points label
		UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
		[self addSubview:label];
		label.font = [UIFont fontWithName:LEAGUE_GOTHIC_R size:60.f];
		label.minimumScaleFactor = 3.f;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = NSTextAlignmentRight;
		label.textColor = [UIColor colorWithRed:237.f/255.f green:237.f/255.f blue:240.f/255.f alpha:1];
		self.currentPointsLabel = label;
		
		UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile_top"]];
		[self addSubview:bgImageView];
		[self sendSubviewToBack:bgImageView];
    }
    return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];
	
	CGFloat margin = floorf(floorf(CGRectGetHeight(self.bounds)*0.1f)/2.f);
	CGFloat badgeHeight = floorf(CGRectGetHeight(self.bounds)*0.9f);
	self.badgeImageView.frame = CGRectMake(margin, margin, badgeHeight, badgeHeight);
	
	CGFloat xOffset = CGRectGetMaxX(self.badgeImageView.frame)+margin;
	self.currentPointsLabel.frame = CGRectMake(xOffset, margin, CGRectGetWidth(self.bounds)-margin-xOffset, badgeHeight);
}

@end
