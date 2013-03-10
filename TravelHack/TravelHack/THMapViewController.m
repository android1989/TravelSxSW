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

@interface THMapViewController ()
@property (nonatomic, strong) CMMotionManager *motionManager;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.opportunities = [THOpportunityDemoFactory opportunities];
	
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
			[dataPoint setImage:[self imageForOpportunity:opportunity] forState:UIControlStateNormal];
			[dataPoint sizeToFit];
			[self.radarView addDataView:dataPoint atRadius:radius angle:angle];
		}
	}
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
	return [UIImage imageNamed:@"coffee_table_cell"];
}

@end
