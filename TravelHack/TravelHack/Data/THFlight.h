//
//  THFlight.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THFlight : NSObject
@property (nonatomic, strong) NSString *depatureDate;
@property (nonatomic, strong) NSString *arrivalDate;
@property (nonatomic, strong) NSString *boardingTime;
@property (nonatomic, strong) NSString *originAirportCode;
@property (nonatomic, strong) NSString *destinationAirportCode;
@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *destinationCity;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

@end
