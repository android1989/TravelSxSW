//
//  THFlightStatus.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THFlightStatus.h"

@implementation THFlightStatus

- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	self.status = [dictionary objectForKey:@"flightStatus"];
	self.originInfo = [[THFlightStatusInformation alloc] init];
	[self.originInfo configureWithDictionary:[dictionary objectForKey:@"originInfo"]];
	self.destinationInfo = [[THFlightStatusInformation alloc] init];
	[self.destinationInfo configureWithDictionary:[dictionary objectForKey:@"destinationInfo"]];
}

@end

@implementation THFlightStatusInformation

- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	[self setValuesForKeysWithDictionary:dictionary];
}

@end