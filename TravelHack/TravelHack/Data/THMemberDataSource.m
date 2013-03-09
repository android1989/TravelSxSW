//
//  THMemberDataSource.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THMemberDataSource.h"

NSString * const THMemberDataSourceDidBecomeReadyNotification = @"THMemberDataSourceDidBecomeReadyNotification";
NSString * const THMemberDataSourceDidUpdate = @"THMemberDataSourceDidUpdate";


@interface THMemberDataSource()
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, strong) THAAClient *client;
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
		
	}
	return self;
}

- (void)_fetchAccountInfo
{
	[self.client fetchAccountInformationWithUsername:self.userName password:self.password completion:^(id responseData, NSError *error) {
		if (!error)
		{
			_account = responseData;
			[self postUpdateNotificationsIfNeeded];
		}
	}];
}

- (BOOL)isReady
{
	return _account != nil;
}

- (void)postUpdateNotificationsIfNeeded
{
	if (![self isReady])
		return;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:THMemberDataSourceDidUpdate object:self];
}

- (void)_fetchReservationList
{
#warning Implement
}

@end
