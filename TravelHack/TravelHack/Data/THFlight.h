//
//  THFlight.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THFlightStatus.h"

@interface THFlight : NSObject
@property (nonatomic, strong) NSDate *depatureDate;
@property (nonatomic, strong) NSDate *arrivalDate;
@property (nonatomic, strong) NSDate *boardingTime;
@property (nonatomic, strong) NSString *originAirportCode;
@property (nonatomic, strong) NSString *destinationAirportCode;
@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *destinationCity;
@property (nonatomic, strong) THFlightStatus *flightStatus;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

- (NSString *)flightDescription;

@end
