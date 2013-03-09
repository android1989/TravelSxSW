//
//  THReservation.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THFlight.h"

@interface THReservation : NSObject
@property (nonatomic, assign) BOOL isNextReservation;
@property (nonatomic, strong) NSString *recordLocator;
@property (nonatomic, strong) NSArray *flights;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

- (THFlight *)nextFlight;

@end

