//
//  THMapViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THMapViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface THMapViewController ()
@property (nonatomic, strong) CMMotionManager *motionManager;
@end

@implementation THMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
	
	self.radarView.backgroundImageView.image = [UIImage imageNamed:@"map_background"];
	
	UIButton *dataPoint = [UIButton buttonWithType:UIButtonTypeCustom];
	[dataPoint setImage:[UIImage imageNamed:@"coffee_table_cell"] forState:UIControlStateNormal];
	[dataPoint sizeToFit];
	[self.radarView addDataView:dataPoint atRadius:150.0 angle:M_PI_4];

    
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

@end
