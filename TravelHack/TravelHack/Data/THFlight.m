//
//  THFlight.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THFlight.h"

static NSDateFormatter *_formatter;

@implementation THFlight

+ (void)initialize
{
	_formatter = [[NSDateFormatter alloc] init];
	_formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_POSIX"];
	_formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
//	_formatter.dateFormat = @"yyyy'-'MM'-'d''T'HH':'mm':'ss'.'SSSS
}


- (void)configureWithDictionary:(NSDictionary *)dictionary
{
	self.depatureDate = [dictionary objectForKey:@"departureDate"];
	self.arrivalDate = [dictionary objectForKey:@"arrivalDate"];
	self.boardingTime = [dictionary objectForKey:@"boardingTime"];
	self.originAirportCode = [dictionary objectForKey:@"originAirportCode"];
	self.destinationAirportCode = [dictionary objectForKey:@"destinationAirportCode"];
	self.flightNumber = [dictionary objectForKey:@"flightKey"];
	self.destinationCity = [dictionary objectForKey:@"destinationCity"];
	
	self.flightStatus = [[THFlightStatus alloc] init];
	[self.flightStatus configureWithDictionary:[dictionary objectForKey:@"flightStatus"]];
}

@end
