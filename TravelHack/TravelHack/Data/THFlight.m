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
	self.depatureDate = [_formatter dateFromString:[dictionary objectForKey:@"departDate"]];
	self.arrivalDate =  [_formatter dateFromString:[dictionary objectForKey:@"arrivalDate"]];
	self.boardingTime = [_formatter dateFromString:[dictionary objectForKey:@"boardingTime"]];
	self.originAirportCode = [dictionary objectForKey:@"originAirportCode"];
	self.destinationAirportCode = [dictionary objectForKey:@"destinationAirportCode"];
	self.flightNumber = [dictionary objectForKey:@"flightNumber"];
	self.destinationCity = [dictionary objectForKey:@"destinationCity"];
		
	self.flightStatus = [[THFlightStatus alloc] init];
	[self.flightStatus configureWithDictionary:[dictionary objectForKey:@"flightStatus"]];
}

- (NSString *)flightDescription
{
	return [NSString stringWithFormat:@"%@ to %@", self.originAirportCode, self.destinationAirportCode];
}

@end
