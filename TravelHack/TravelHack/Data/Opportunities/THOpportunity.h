//
//  THOpportunity.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THOpportunity : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *pointValue;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *callToAction;
@property (nonatomic, strong) NSString *location;

@property (nonatomic, strong) NSString *category;

@end


extern NSString * const THOpportunityCategoryCoffee;
extern NSString * const THOpportunityCategoryBookStore;
extern NSString * const THOpportunityCategoryGateCheckin;
extern NSString * const THOpportunityCategoryBar;
extern NSString * const THOpportunityCategoryFlightCheckin;
extern NSString * const THOpportunityCategoryBagCheck;
extern NSString * const THOpportunityCategoryAirlineLounge;
extern NSString * const THOpportunityCategoryStore;
extern NSString * const THOpportunityCategoryTechKiosk;
extern NSString * const	THOpportunityCategoryFood;
extern NSString * const THOpportunityCategoryNewsstand;