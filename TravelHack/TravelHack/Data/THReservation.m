//
//  THReservation.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THReservation.h"
#import "THFlight.h"

@implementation THReservation

- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	self.isNextReservation = [[dictionary objectForKey:@"nextRes"] boolValue];
	self.recordLocator = [dictionary objectForKey:@"recordLocator"];
	
	NSMutableArray *flights = [NSMutableArray array];
	for (NSArray *flightArray in [dictionary objectForKey:@"flights"])
	{
		NSMutableArray *legFlights = [NSMutableArray array];
		
		for (NSDictionary *flightDictionary in flightArray)
		{
			THFlight *flight = [[THFlight alloc] init];
			[flight configureWithDictionary:flightDictionary];
			[legFlights addObject:flight];
		}
		
		[flights addObject:legFlights];
	}
	
	self.flights = flights;
}

- (THFlight *)nextFlight
{
	if (!self.flights.count)
		return nil;
	
	NSArray *leg = self.flights[0];
	
	if (!leg.count)
		return nil;
	
	THFlight *flight = leg[0];
	return flight;
}

@end
