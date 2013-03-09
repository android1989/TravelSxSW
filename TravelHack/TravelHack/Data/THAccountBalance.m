//
//  THAccountBalance.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THAccountBalance.h"

@implementation THAccountBalance

- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	self.awardMileage = [dictionary objectForKey:@"awardMileage"];
	self.upgradeQualify = [dictionary objectForKey:@"upgradeQualify"];
}

@end
