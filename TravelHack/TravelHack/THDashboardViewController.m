//
//  THDashboardViewController.m
//  TravelHack
//
//  Created by John Lawson on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THDashboardViewController.h"
#import "THAccountSummaryView.h"

@interface THDashboardViewController ()

@property (nonatomic, weak) THAccountSummaryView *accountSummaryView;

@end

@implementation THDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	THAccountSummaryView *summaryView = [[THAccountSummaryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 109.f)];
	[self.view addSubview:summaryView];
	[summaryView setCurrentPoints:121000];
	[summaryView setBadgeImage:[UIImage imageNamed:@"badge"]];
	self.accountSummaryView = summaryView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
