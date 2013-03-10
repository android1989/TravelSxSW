//
//  THMapViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THMapViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "THOpportunity.h"
#import "THOpportunityDemoFactory.h"
#import "THOpportunityImageFactory.h"
#import <objc/runtime.h>
#import "THPastOpportunityCell.h"
#import <QuartzCore/QuartzCore.h>

static NSString * const THMapViewAssociatedOpportunity = @"THMapViewAssociatedOpportunity";

@interface THMapViewController ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@property (nonatomic, strong) THPastOpportunityCell *notificationView;
@end

@implementation THMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
	[self.motionManager stopDeviceMotionUpdates];
}

- (void)loadNotificationView
{
	self.notificationView = [[[UINib nibWithNibName:@"THPastOpportunityCell" bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil] lastObject];
	self.notificationView.frame = CGRectOffset(self.notificationView.bounds, 0.0, -CGRectGetHeight(self.notificationView.bounds));
	
	UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
	imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	imageView.frame = self.notificationView.bounds;
	imageView.clipsToBounds = YES;
	
	UIView *view = self.notificationView;
	view.layer.shadowOpacity = 0.7;
	view.layer.shadowOffset = CGSizeMake(0.0, 3.0);
	
	[self.notificationView addSubview:imageView];
	[self.notificationView sendSubviewToBack:imageView];
	
	[self.view addSubview:self.notificationView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
		
	self.opportunities = [THOpportunityDemoFactory opportunities];
	[self loadNotificationView];
	
	self.radarView.backgroundImageView.image = [UIImage imageNamed:@"map_background"];
	
	[self applyOpportunitiesToRadar:self.opportunities];
    
	self.motionManager = [[CMMotionManager alloc] init];
	self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
	[self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:CMAttitudeReferenceFrameXMagneticNorthZVertical toQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
		CMRotationMatrix matrix = motion.attitude.rotationMatrix;
		
		CGFloat x = matrix.m11 + matrix.m12;
		CGFloat y = matrix.m21 + matrix.m22;
		CGFloat theta = atan2f(x, y);

		self.radarView.angle = theta;
	}];
}

- (void)setOpportunities:(NSArray *)opportunities
{
	NSPredicate *filter = [NSPredicate predicateWithFormat:@"distance != 0"];
	_opportunities = [opportunities filteredArrayUsingPredicate:filter];
	[self applyOpportunitiesToRadar:_opportunities];
}

- (void)applyOpportunitiesToRadar:(NSArray *)opportunities
{
	[self.radarView.dataViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
	
	for (THOpportunity *opportunity in opportunities)
	{
		CGFloat radius = [self radiusForOpportunityDistance:opportunity.distance.integerValue];
		CGFloat angle = [self angleForOpportunity:opportunity];
		
		if (radius > 0)
		{
			UIButton *dataPoint = [UIButton buttonWithType:UIButtonTypeCustom];
			
			objc_setAssociatedObject(dataPoint, &THMapViewAssociatedOpportunity, opportunity, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
			
			[dataPoint setImage:[self imageForOpportunity:opportunity] forState:UIControlStateNormal];
			[dataPoint sizeToFit];
			[self.radarView addDataView:dataPoint atRadius:radius angle:angle];
			
			[dataPoint addTarget:self action:@selector(buttonSelected:) forControlEvents:UIControlEventTouchUpInside];
		}
	}
}

- (void)buttonSelected:(UIButton *)button
{
	THOpportunity *opportunity = objc_getAssociatedObject(button, &THMapViewAssociatedOpportunity);
	[self displayOpportunity:opportunity];
}

- (void)displayOpportunity:(THOpportunity *)opportunity
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(dismissOpportunity) object:nil];
	
	[self.view bringSubviewToFront:self.notificationView];
	[self.notificationView setOpportunity:opportunity];
	
	[UIView animateWithDuration:0.5 animations:^{
		self.notificationView.frame = self.notificationView.bounds;
	} completion:^(BOOL finished) {
		[self performSelector:@selector(dismissOpportunity) withObject:nil afterDelay:3.0];
	}];
}

- (void)dismissOpportunity
{
	[UIView animateWithDuration:0.5 animations:^{
		self.notificationView.frame = CGRectOffset(self.notificationView.bounds, 0.0, -CGRectGetHeight(self.notificationView.bounds));
	}];
}

- (CGFloat)radiusForOpportunityDistance:(NSInteger)distance
{
	CGFloat radius = 0.0f;
	switch (distance) {
		case 1:
			radius = 40.0f;
			break;
		case 2:
			radius = 80.0f;
			break;
		case 3:
			radius = 120.0f;
			break;
		default:
			break;
	}
	return radius;
}

- (CGFloat)angleForOpportunity:(THOpportunity *)opportunity
{
	return fmodf(random(), M_PI * 2.0);
}

- (UIImage *)imageForOpportunity:(THOpportunity *)opportunity
{
	return [THOpportunityImageFactory imageForOpportunity:opportunity];
}

@end
