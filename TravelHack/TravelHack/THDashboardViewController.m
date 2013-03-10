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
	
	/*THAccountSummaryView *summaryView = [[THAccountSummaryView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 109.f)];
	[self.view addSubview:summaryView];
	[summaryView setCurrentPoints:121000];
	[summaryView setBadgeImage:[UIImage imageNamed:@"badge"]];
	self.accountSummaryView = summaryView;*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split View Gestures

- (IBAction)splitViewDidPan:(UIPanGestureRecognizer *)recognizer
{
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

- (IBAction)splitViewTouchUpInside:(UITapGestureRecognizer *)recognizer
{
    if (!self.isSplitViewOpen)
    {
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [recognizer.view.superview setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), CGRectGetMinY(self.mapView.frame), CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.superview.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.superview.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.superview.frame))];
            
            [self.splitViewController split];
        } completion:^(BOOL finished) {
            self.isSplitViewOpen = YES;
            
        }];
    }else{
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (!self.isDown)
            {
                [recognizer.view.superview setFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 218)];
            }else{
                [recognizer.view.superview setFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-218, CGRectGetWidth(self.view.bounds), 218)];
            }
            
            
            [self.mapView setFrame:CGRectMake(CGRectGetMinX(self.mapView.frame), CGRectGetMinY(self.mapView.frame), CGRectGetWidth(self.mapView.frame), CGRectGetMinY(recognizer.view.superview.frame))];
            
            [self.pastView setFrame:CGRectMake(CGRectGetMinX(self.pastView.frame), CGRectGetMaxY(recognizer.view.superview.frame), CGRectGetWidth(self.pastView.frame), CGRectGetHeight(self.view.frame)-CGRectGetMaxY(recognizer.view.superview.frame))];
            
            [self.splitViewController join];
        } completion:^(BOOL finished) {
            self.isSplitViewOpen = NO;
            
        }];
    }
    
    
}
@end
