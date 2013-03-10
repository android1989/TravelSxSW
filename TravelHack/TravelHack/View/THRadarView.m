//
//  THRadarView.m
//  CoreMotionTest
//
//  Created by Austen Green on 3/10/13.
//  Copyright (c) 2013 Austen Green. All rights reserved.
//

#import "THRadarView.h"

@interface THRadarView()
{
	NSMutableArray *_dataViews;
}
@end

@implementation THRadarView

void THRadarViewCommonInit(THRadarView *view)
{
	view->_backgroundImageView = [[UIImageView alloc] initWithFrame:view.bounds];
	view->_backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	view->_backgroundImageView.userInteractionEnabled = YES;
	view->_backgroundImageView.contentMode = UIViewContentModeCenter;
	[view addSubview:view->_backgroundImageView];
	
	view->_dataViews = [[NSMutableArray alloc] init];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		THRadarViewCommonInit(self);
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		THRadarViewCommonInit(self);
	}
	return self;
}

- (void)setAngle:(CGFloat)angle
{
	_angle = angle;
	self.backgroundImageView.transform = CGAffineTransformMakeRotation(angle);
	
	for (UIView *view in self.dataViews)
	{
		view.transform = CGAffineTransformMakeRotation(-angle);
	}
}

- (void)addDataView:(UIView *)view atRadius:(CGFloat)radius angle:(CGFloat)angleInRadians
{
	[self.backgroundImageView addSubview:view];
	[_dataViews addObject:view];
	
	view.frame = view.bounds;
	
	CGFloat x = cosf(angleInRadians) * radius;
	CGFloat y = sinf(angleInRadians) * radius;
	
	view.center = CGPointMake(CGRectGetMidX(self.backgroundImageView.bounds) + x, CGRectGetMidY(self.backgroundImageView.bounds) + y);
}

@end
