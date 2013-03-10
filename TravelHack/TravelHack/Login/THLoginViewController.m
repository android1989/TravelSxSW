//
//  THLoginViewController.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THLoginViewController.h"
#import "THAccount.h"

@interface THLoginViewController ()



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
	THAccount *account = [[THAccount alloc] init];
	account.aadvantageNumber = self.aaNumber.text;
	
    [self.delegate loginViewControllerDidRequestSignIn:self];
	[self.spinner startAnimating];
}

@end
