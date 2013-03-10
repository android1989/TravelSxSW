//
//  THPastOpportunitiesViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THPastOpportunitiesViewController.h"
#import "THPastOpportunityCell.h"

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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for (int i = 0; i < 10; i++)
    {
        [self.opportunities addObject:@"wooo"];
    }
    
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
    
    if (cell == nil)
    {
        cell = [[THPastOpportunityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([THPastOpportunityCell class])];
    }
    
    //set cell properties
    
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
@end
