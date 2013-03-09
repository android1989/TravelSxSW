//
//  THAccount.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THAccount.h"

@implementation THAccount

- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	NSDictionary *root = [dictionary objectForKey:@"myAccount"];
	self.firstName = [root objectForKey:@"firstName"];
	self.lastName = [root objectForKey:@"lastName"];
	self.aadvantageNumber = [root objectForKey:@"aadvNumber"];
	self.tierLevel = [root objectForKey:@"tierLevel"];
	
	self.accountBalance = [[THAccountBalance alloc] init];
	[self.accountBalance configureWithDictionary:[root objectForKey:@"accountBalance"]];
}

@end
