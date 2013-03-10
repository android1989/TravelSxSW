//
//  THSplitViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THSplitViewController.h"
#import "THConstants.h"
#import <QuartzCore/QuartzCore.h>

@interface THSplitViewController ()
@property (nonatomic, strong) IBOutlet UIImageView *splitImage;
@end

@implementation THSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.pointsLabel setFont:[UIFont fontWithName:LEAGUE_GOTHIC_R size:60]];
    [self.timeLabel setFont:[UIFont fontWithName:LEAGUE_GOTHIC_R size:30]];
    [self.statusLabel setFont:[UIFont fontWithName:LEAGUE_GOTHIC_R size:30]];
    [self.terminalLabel setFont:[UIFont fontWithName:LEAGUE_GOTHIC_R size:30]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)split
{
    [self.splitImage setAlpha:0];
}

- (void)join
{
    [self.splitImage setAlpha:1];
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	CGFloat maxX = CGRectGetMaxX(self.statusLabel.frame);
	[self.statusLabel sizeToFit];
	CGRect frame = self.statusLabel.frame;
	frame.origin.x = maxX - CGRectGetWidth(frame);
	self.statusLabel.frame = frame;
}

@end
