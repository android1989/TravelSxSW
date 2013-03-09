//
//  THAccountBalance.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THAccountBalance : NSObject
@property (nonatomic, strong) NSNumber *awardMileage;
@property (nonatomic, strong) NSNumber *upgradeQualify;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

/*
"awardMileage": 1832536,
"eliteQualifyingMiles": 45000,
"millionMilerMileage": 800699,
"upgradeQualify": false,
"deferredExpirationMiles": 1832536, "eliteQualifyingSegments": 45,
"upgradeQualifyingMiles": 0,
"eliteQualifyingPoints": 75000,
"programToDateMiles": 2584668,
"upgradeBalance": 184,
"deferredExpirationMilesDate": "2012-06-17T00:00:00.000-05:00"
 */
@end
