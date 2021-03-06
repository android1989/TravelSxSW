//
//  THDashboardViewController.m
//  TravelHack
//
//  Created by John Lawson on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THDashboardViewController.h"
#import "THAccountSummaryView.h"
#import "THSplitViewController.h"
#import "THPastOpportunitiesViewController.h"
#import "THMapViewController.h"
#import "THOpportunity.h"

@interface THDashboardViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, weak) THAccountSummaryView *accountSummaryView;

@property (nonatomic, strong) IBOutlet UIView *mapView;
@property (nonatomic, strong) IBOutlet UIView *pastView;

@property (nonatomic, strong) IBOutlet THSplitViewController *splitViewController;
@property (nonatomic, strong) IBOutlet THMapViewController *mapViewController;
@property (nonatomic, strong) IBOutlet THPastOpportunitiesViewController *pastViewController;
@property (nonatomic, assign) BOOL isSplitViewOpen;
@property (nonatomic, assign) BOOL isDown;

@end

@implementation THDashboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _isSplitViewOpen = NO;
        _isDown = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataSourceDidUpdate) name:THMemberDataSourceDidUpdate object:nil];
	
	if (self.dataSource.isReady)
		[self dataSourceDidUpdate];
	
	/*THAccountSummaryView *summaryView = [[THAccountSummaryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 109.f)];
	[self.view addSubview:summaryView];
	[summaryView setCurrentPoints:121000];
	[summaryView setBadgeImage:[UIImage imageNamed:@"badge"]];
	self.accountSummaryView = summaryView;*/
}

- (void)viewDidAppear:(BOOL)animated
{
    
    CGPoint finalPoint = CGPointMake(self.splitViewController.view.center.x,
                                     CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.splitViewController.view.bounds)/2.0f);
    
    [UIView animateWithDuration:1 delay:.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.splitViewController.view.center = finalPoint;
        [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), 0, CGRectGetWidth(self.mapView.frame), CGRectGetMinY(self.splitViewController.view.frame))];
        
        [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(self.splitViewController.view.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(self.splitViewController.view.frame))];
        
    } completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dataSourceDidUpdate
{
	THAccount *account = self.dataSource.account;
	THFlight *flight = self.dataSource.nextFlight;
	
	NSString *date = [NSDateFormatter localizedStringFromDate:flight.depatureDate dateStyle:NSDateFormatterNoStyle timeStyle:NSDateFormatterShortStyle];
	
	
	self.splitViewController.pointsLabel.text = [NSNumberFormatter localizedStringFromNumber:account.accountBalance.awardMileage numberStyle:NSNumberFormatterDecimalStyle];
	self.splitViewController.timeLabel.text = date;
	self.splitViewController.statusLabel.text = flight.flightStatus.status;
	self.splitViewController.nameLabel.text = [NSString stringWithFormat:@"%@ %@", account.firstName, account.lastName];
	self.splitViewController.terminalLabel.text = flight.flightStatus.originInfo.terminalDescription;
	self.flightDescription.text = [flight flightDescription];
	
	[self.splitViewController.view setNeedsLayout];
	
	/*
	@property (nonatomic, strong) IBOutlet UILabel *pointsLabel;
	@property (nonatomic, strong) IBOutlet UILabel *staticTimeLabel;
	@property (nonatomic, strong) IBOutlet UILabel *staticStatusLabel;
	@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
	@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
	@property (nonatomic, strong) IBOutlet UILabel *terminalLabel;
	 */
}

#pragma mark - Split View Gestures

- (IBAction)splitViewDidPan:(UIPanGestureRecognizer *)recognizer
{
    if (self.isSplitViewOpen)
    {
        return;
    }
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGFloat finalY = recognizer.view.center.y + (velocity.y * slideFactor);
        
        if (finalY > CGRectGetHeight(self.view.bounds)/2.0f)
        {
            finalY = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(recognizer.view.bounds)/2.0f;
            self.isDown = YES;
        }else{
            finalY = CGRectGetHeight(recognizer.view.bounds)/2.0f;
            self.isDown = NO;
        }
        
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x,
                                         finalY);
        
        CGFloat finalVelocity = MAX(.2, MIN(velocity.y/magnitude, .6));
        
        [UIView animateWithDuration:finalVelocity delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            recognizer.view.center = finalPoint;
            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), 0, CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.frame))];

        } completion:nil];
    }else{
        
        [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), 0, CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.frame))];
        
        [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.frame))];
    }
}

- (IBAction)splitViewTopTouchUpInside:(UITapGestureRecognizer *)recognizer
{
    if (!self.isSplitViewOpen)
    {
        [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            [recognizer.view.superview setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), CGRectGetMinY(self.mapView.frame), CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.superview.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.superview.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.superview.frame))];
            
            [self.splitViewController split];
        } completion:^(BOOL finished) {
            self.isSplitViewOpen = YES;
            
        }];
    }else{
        [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            [recognizer.view.superview setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-218, CGRectGetWidth(self.view.bounds), 218)];
            
            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), CGRectGetMinY(self.mapView.frame), CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.superview.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.superview.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.superview.frame))];
            
            [self.splitViewController join];
        } completion:^(BOOL finished) {
            self.isSplitViewOpen = NO;
            
        }];
    }
}

- (IBAction)splitViewBottomTouchUpInside:(UITapGestureRecognizer *)recognizer
{
    if (!self.isSplitViewOpen)
    {
        [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            [recognizer.view.superview setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), CGRectGetMinY(self.mapView.frame), CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.superview.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.superview.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.superview.frame))];
            
            [self.splitViewController split];
        } completion:^(BOOL finished) {
            self.isSplitViewOpen = YES;
            
        }];
    }else{
        [UIView animateWithDuration:.4 delay:0 options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionBeginFromCurrentState animations:^{
            
            [recognizer.view.superview setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 218)];

            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), CGRectGetMinY(self.mapView.frame), CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.superview.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.superview.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.superview.frame))];
            
            [self.splitViewController join];
        } completion:^(BOOL finished) {
            self.isSplitViewOpen = NO;
            
        }];
    }
}

- (IBAction)simulateOpportuniy:(id)sender
{
    THOpportunity *op = [self randomOpportunity];
    THAccount *account = self.dataSource.account;
    [self.splitViewController incrementMiles:[op.pointValue integerValue] basePoints:[account.accountBalance.awardMileage integerValue]];
    [self.pastViewController simulateOpportunity:op];
    
    account.accountBalance.awardMileage = [NSNumber numberWithInt:[account.accountBalance.awardMileage integerValue]+[op.pointValue integerValue]];
    
}

- (THOpportunity*)randomOpportunity
{
    THOpportunity *op = [[THOpportunity alloc] init];
    int randomOp = rand()%5;
    switch (randomOp) {
        case 0:
            op.title = @"Gate Check-in";
            op.category = THOpportunityCategoryGateCheckin;
            break;
        case 1:
            op.title = @"Flight Check-in";
            op.category = THOpportunityCategoryFlightCheckin;
            break;
        case 2:
            op.title = @"Chili's";
            op.category = THOpportunityCategoryFood;
            break;
        case 3:
            op.title = @"Brookstone";
            op.category = THOpportunityCategoryNewsstand;
            break;
        case 4:
            op.title = @"Best Buy Kiosk";
            op.category = THOpportunityCategoryTechKiosk;
            break;
        default:
            break;
    }
    op.pointValue  = [NSNumber numberWithInt:((rand()%3)*100)+50];
    op.date = @"03/10/13";
    op.location = @"AUS";
    op.distance = 0;
    return op;
}

#pragma mark - 
@end
