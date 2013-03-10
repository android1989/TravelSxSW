//
//  THLoginViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THLoginViewController.h"
#import "THMemberDataSource.h"

@interface THLoginViewController ()

@property (nonatomic, strong) IBOutlet UITextField *aaNumber;
@property (nonatomic, strong) IBOutlet UITextField *password;

@property (nonatomic, strong) THMemberDataSource *memberDataSource;

@end

@implementation THLoginViewController

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
    // Do any additional setup after loading the view from its nib.
	
	self.aaNumber.text = AAADVANTAGE_NUMBER;
	self.password.text = PASSWORD;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.aaNumber resignFirstResponder];
    [self.password resignFirstResponder];
}

- (IBAction)login:(id)sender
{
	if ([self.spinner isAnimating])
		return;
	
	[self.spinner startAnimating];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:THMemberDataSourceDidBecomeReadyNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberDataSourceDidBecomeReadyNotification:) name:THMemberDataSourceDidBecomeReadyNotification object:nil];
	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:THMemberDataSourceDidFail object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memberDataSourceDidFailNotification:) name:THMemberDataSourceDidFail object:nil];
	
	
	self.memberDataSource = [[THMemberDataSource alloc] initWithUsername:self.aaNumber.text password:self.password.text];
}

#pragma mark - THMemberDataSource Notifications

- (void)memberDataSourceDidBecomeReadyNotification:(NSNotification *)note
{
	[self.delegate loginViewController:self didRetrieveMember:self.memberDataSource];
	[self.spinner stopAnimating];
}

- (void)memberDataSourceDidFailNotification:(NSNotification *)note
{
	NSError *error = [note object];
	
	NSLog(@"Failed to fetch all member information: %@", error);
	
	[self.spinner stopAnimating];
	[[[UIAlertView alloc] initWithTitle:@"Unable to login at this time. Please try again." message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
