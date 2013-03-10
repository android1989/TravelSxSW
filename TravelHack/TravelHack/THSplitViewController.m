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
#import "THOpportunityDemoFactory.h"
#import "THPastOpportunityCell.h"
#import "THOpportunityDemoFactory.h"

@interface THSplitViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UIImageView *splitImage;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *redeemableOpportunities;
@end

@implementation THSplitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		_redeemableOpportunities = [THOpportunityDemoFactory reedemableOpportunities];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _redeemableOpportunities = [THOpportunityDemoFactory reedemableOpportunities];
    }
    return self;
}

- (void)setupTableView
{
	UIView *view = [[self.view subviews] objectAtIndex:0];
	
	self.tableView = [[UITableView alloc] initWithFrame:view.bounds style:UITableViewStylePlain];
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	self.tableView.backgroundColor = nil;
	
	CGFloat top = CGRectGetHeight(self.topSplitView.bounds);
	CGFloat bottom = CGRectGetHeight(self.bottomSplitView.bounds);
	
	if (!top)
		top = 109.0;
	if (!bottom)
		bottom = 109.0;
	
	self.tableView.contentInset = UIEdgeInsetsMake(top, 0.0, bottom, 0.0);
	self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
	
	
	[view addSubview:self.tableView];
	
	UINib *nib = [UINib nibWithNibName:@"THPastOpportunityCell" bundle:[NSBundle mainBundle]];
	[self.tableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([THPastOpportunityCell class])];

	self.tableView.rowHeight = [THPastOpportunityCell preferredHeight];
	self.tableView.dataSource = self;
	self.tableView.delegate = self;
	
	[self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"Identifier"];
		
	[self.tableView reloadData];
}

- (void)viewDidLoad
{
	[self setupTableView];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.redeemableOpportunities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	THPastOpportunityCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([THPastOpportunityCell class])];
	THOpportunity *opportunity = [self.redeemableOpportunities objectAtIndex:indexPath.row];
	[cell setOpportunity:opportunity];
	
	return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{	
	UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"Identifier"];
	view.textLabel.text = @"SHOP With Miles";
	view.textLabel.textAlignment = NSTextAlignmentCenter;
	view.textLabel.textColor = [UIColor colorWithRed:237.0 / 255.0 green:237.0 /255.0  blue:240.0 / 255.0 alpha:1.0];
	view.tintColor = [UIColor colorWithRed:76.0 / 255.0 green:86.0 / 255.0 blue:114.0 / 255.0 alpha:1.0];
	return view;
}

@end
