//
//  THPastOpportunitiesViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THPastOpportunitiesViewController.h"
#import "THPastOpportunityCell.h"
#import "THOpportunityDemoFactory.h"
#import "THOpportunity.h"
#import "THOpportunityImageFactory.h"

@interface THPastOpportunitiesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *opportunities;
@property (nonatomic, strong) IBOutlet UITableView *opportunitiesTableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation THPastOpportunitiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _opportunities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _opportunities = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
	UINib *nib = [UINib nibWithNibName:@"THPastOpportunityCell" bundle:[NSBundle mainBundle]];
	[self.opportunitiesTableView registerNib:nib forCellReuseIdentifier:@"THPastOpportunityCell"];
	
	[self.opportunities addObjectsFromArray:[THOpportunityDemoFactory opportunities]];
    
    [self.opportunitiesTableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.opportunities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        
    THPastOpportunityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([THPastOpportunityCell class])];
    
    //set cell properties
	
	THOpportunity *op = self.opportunities[indexPath.row];	
	[cell setOpportunity:op];
    
    return cell;
}


#pragma mark - 

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
	
	CGRect frame = self.opportunitiesTableView.frame;
	self.opportunitiesTableView.frame = CGRectMake(0.0, CGRectGetHeight(self.view.bounds) - CGRectGetHeight(frame), CGRectGetWidth(frame), CGRectGetHeight(frame));
	self.imageView.frame = frame;
}

- (void)simulateOpportunity:(THOpportunity*)op
{
    NSArray *insertIndexPaths = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    [self.opportunities insertObject:op atIndex:0];
    // [self.dataForList count] is 1 now
    
    [self.opportunitiesTableView beginUpdates];
    [self.opportunitiesTableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationTop];
    [self.opportunitiesTableView endUpdates];
    
}


@end
