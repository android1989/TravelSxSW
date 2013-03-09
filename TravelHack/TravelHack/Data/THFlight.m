//
//  THFlight.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THFlight.h"
#import "THZuluDateFormatter.h"

static THZuluDateFormatter *_formatter;

@implementation THFlight

+ (void)initialize
{
	_formatter = [[THZuluDateFormatter alloc] init];
}


- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	self.depatureDate = [dictionary objectForKey:@"departDate"];
	self.arrivalDate = [dictionary objectForKey:@"arrivalDate"];
	self.boardingTime = [dictionary objectForKey:@"boardingTime"];
	self.originAirportCode = [dictionary objectForKey:@"originAirportCode"];
	self.destinationAirportCode = [dictionary objectForKey:@"destinationAirportCode"];
	self.flightNumber = [dictionary objectForKey:@"flightKey"];
	self.destinationCity = [dictionary objectForKey:@"destinationCity"];
	
	NSError *error = nil;
	NSDate *date = [_formatter dateFromString:[dictionary objectForKey:@"departDate"]];
	
	self.flightStatus = [[THFlightStatus alloc] init];
	[self.flightStatus configureWithDictionary:[dictionary objectForKey:@"flightStatus"]];
}

@end
