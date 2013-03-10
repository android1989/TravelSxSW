//
//  THFlightStatus.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class THFlightStatusInformation;

@interface THFlightStatus : NSObject
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) THFlightStatusInformation *originInfo;
@property (nonatomic, strong) THFlightStatusInformation *destinationInfo;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

@end

@interface THFlightStatusInformation : NSObject
@property (nonatomic, strong) NSString *gate;
@property (nonatomic, strong) NSString *terminal;
@property (nonatomic, strong) NSString *boardingTime;
@property (nonatomic, strong) NSString *actualTime;
@property (nonatomic, strong) NSString *flightStatus;
@property (nonatomic, strong) NSString *baggageClaimArea;
@property (nonatomic, strong) NSString *estimatedTime;
@property (nonatomic, strong) NSString *flightNumber;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

- (NSString *)terminalDescription;

@end