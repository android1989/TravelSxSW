//
//  THMemberDataSource.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THMemberDataSource.h"

extern NSString * const THMemberDataSourceDidBecomeReadyNotification = @"THMemberDataSourceDidBecomeReadyNotification";
extern NSString * const THMemberDataSourceDidUpdate = @"THMemberDataSourceDidUpdate";


@interface THMemberDataSource()
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@end

@implementation THMemberDataSource

- (id)initWithUsername:(NSString *)username password:(NSString *)password
{
	self = [super init];
	if (self)
	{
		_userName = [username copy];
		_password = [password copy];
		
		[self _fetchAccountInfo];
		
	}
	return self;
}

- (void)_fetchAccountInfo
{
	[self.client fetchAccountInformationWithUsername:self.userName password:self.password completion:^(id responseData, NSError *error) {
		_account = responseData;
	}];
}

- (void)_fetchReservationList
{
#warning Implement
}

@end
