//
//  THAccount.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THAccountBalance.h"

@interface THAccount : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *aadvantageNumber;
@property (nonatomic, strong) NSString *tierLevel;
@property (nonatomic, strong) THAccountBalance *accountBalance;

- (void)configureWithDictionary:(NSDictionary *)dictionary;

@end
