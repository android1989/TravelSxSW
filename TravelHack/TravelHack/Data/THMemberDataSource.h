//
//  THMemberDataSource.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const THMemberDataSourceDidBecomeReadyNotification;
extern NSString * const THMemberDataSourceDidUpdate;

@interface THMemberDataSource : NSObject

- (BOOL)isReady;

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

@end
