//
//  THMemberDataSource.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THAccount.h"
#import "THAAClient.h"
#import "THFlight.h"

extern NSString * const THMemberDataSourceDidBecomeReadyNotification;
extern NSString * const THMemberDataSourceDidUpdate;

@interface THMemberDataSource : NSObject
@property (nonatomic, readonly) THAccount *account;
@property (nonatomic, readonly) THFlight *nextFlight;

- (BOOL)isReady;

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

@end
