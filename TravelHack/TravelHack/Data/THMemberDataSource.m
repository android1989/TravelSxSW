//
//  THMemberDataSource.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THMemberDataSource.h"
#import "THReservation.h"

NSString * const THMemberDataSourceDidBecomeReadyNotification = @"THMemberDataSourceDidBecomeReadyNotification";
NSString * const THMemberDataSourceDidUpdate = @"THMemberDataSourceDidUpdate";

NSString * const THMemberDataSourceDidFail = @"THMemberDataSourceDidFail";

@interface THMemberDataSource ()

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) THAAClient *client;
@property (nonatomic, strong) THReservation *reservation;

@end

@implementation THMemberDataSource

- (id)initWithUsername:(NSString *)username password:(NSString *)password
{
	self = [super init];
	if (self)
	{
		_userName = [username copy];
		_password = [password copy];
		_client = [THAAClient client];
		
		[self _fetchAccountInfo];
		[self _fetchFlightInfo];
	}
	return self;
}

- (void)_fetchAccountInfo
{
	[self.client fetchAccountInformationWithUsername:self.userName password:self.password completion:^(id responseData, NSError *error) {
		if (!error)
		{
			_account = responseData;
			[self _fetchCurrentFlightInfoIfPossible];
			[self postUpdateNotificationsIfNeeded];
		}
		else
		{
			[self postFailureNotificationWithError:error];
		}
	}];
}

- (void)_fetchFlightInfo
{
	[self.client fetchReservationListWithUsername:self.userName password:self.password completion:^(id responseData, NSError *error) {
		if (!error)
		{
			self.reservation = responseData;
			[self _fetchCurrentFlightInfoIfPossible];
		}
		else
		{
			[self postFailureNotificationWithError:error];
		}
	}];
}
		
- (void)_fetchCurrentFlightInfoIfPossible
{
	if (!self.reservation || !self.account)
		return;
	
	THFlight *flight = self.reservation.nextFlight;
	[self _fetchCurrentFlightInfoWithFlight:flight];
}

- (void)_fetchCurrentFlightInfoWithFlight:(THFlight *)flight
{
	[self.client fetchFlightStatusWithFlight:flight account:self.account completion:^(id responseData, NSError *error) {
		
		if (!error)
		{
			_nextFlight = responseData;
			[self postUpdateNotificationsIfNeeded];
		}
		else
		{
			[self postFailureNotificationWithError:error];
		}
	}];
}

- (BOOL)isReady
{
	return self.account != nil && self.nextFlight != nil;
}

- (void)postFailureNotificationWithError:(NSError *)error
{
	[[NSNotificationCenter defaultCenter] postNotificationName:THMemberDataSourceDidFail object:error];
}

- (void)postUpdateNotificationsIfNeeded
{
	[[NSNotificationCenter defaultCenter] postNotificationName:THMemberDataSourceDidUpdate object:self];
	
	if (![self isReady])
		return;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:THMemberDataSourceDidBecomeReadyNotification object:self];
}

@end
