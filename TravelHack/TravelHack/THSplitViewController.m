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
@property (nonatomic, strong) NSTimer *addUpTimer;
@property (nonatomic, assign) NSInteger basePoints;
@property (nonatomic, assign) NSInteger additions;
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

- (void)incrementMiles:(NSInteger)addition basePoints:(NSInteger)basePoints
{
    self.basePoints = basePoints;
    self.additions = addition;
    self.addUpTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(addUpTimer:) userInfo:nil repeats:YES];
}

- (void)decrementMiles:(NSInteger)subtraction basePoints:(NSInteger)basePoints
{
    while (subtraction > 0)
    {
        basePoints -= 1;
        subtraction += 1;
        if (basePoints <= 0)
        {
            basePoints = 0;
            subtraction = 0;
        }
        [self.pointsLabel setText:[NSString stringWithFormat:@"%d",basePoints]];
    }
}

- (void)addUpTimer:(NSTimer*)timer
{
    self.basePoints += 5;
    self.additions -= 5;
    [self.pointsLabel setText:[NSString stringWithFormat:@"%d",self.basePoints]];
    
    if (self.additions <= 0)
    {
        [self.addUpTimer invalidate];
    }
}
@end
