//
//  THAAClient.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THAAClient.h"
#import "AFHTTPClient.h"
#import "THAccount.h"
#import "THFlight.h"
#import "THReservation.h"

static NSString * const AABaseURL = @"https://aahackathon.api.layer7.com:9443/AA1/";
static NSString * const AAAPIKey = @"l7xxd09d84947ffb4482a8e87cd76926065c";

@interface NSURLRequest (DummyInterface)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString*)host;
+ (void)setAllowsAnyHTTPSCertificate:(BOOL)allow forHost:(NSString*)host;
@end


@interface THAAClient()
@property (nonatomic, strong) NSURL *baseURL;
@property (nonatomic, strong) AFHTTPClient *httpClient;
@end

@implementation THAAClient

+ (THAAClient *)client
{
	static THAAClient *_client;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_client = [[self alloc] init];
	});
	return _client;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		_baseURL = [NSURL URLWithString:AABaseURL];
		_httpClient = [AFHTTPClient clientWithBaseURL:_baseURL];
		[_httpClient setDefaultHeader:@"apikey" value:AAAPIKey];
		[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:@"aahackathon.api.layer7.com"];
	}
	return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password
{
	if (!username.length || !password.length)
		return;
	
	[self executeRequestWithPath:@"login" httpMethod:@"POST" parameters:@{@"aadvantageNumber": username, @"password": password} completion:^(id responseData, NSError *error) {
		NSLog(@"%@ \n Error: %@", responseData, error);
	}];
}

- (void)fetchAccountInformationWithUsername:(NSString *)username password:(NSString *)password completion:(THAAClientCompletionBlock)completion
{
	// Fill in
    [self executeRequestWithPath:@"account" httpMethod:@"GET" parameters:@{@"aadvantageNumber" : username, @"password":password} completion:^(id responseData, NSError *error) {
		
		THAccount *account = nil;
		
		if (!error)
		{
			account = [[THAccount alloc] init];
			[account configureWithDictionary:[NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error]];
		}
		
        if (completion) {
            completion(account, error);
        }
    }];
}

- (void)fetchReservationListWithUsername:(NSString *)username password:(NSString *)password completion:(THAAClientCompletionBlock)completion
{
    [self executeRequestWithPath:@"reservationlist" httpMethod:@"GET" parameters:@{@"aadvantageNumber" : username, @"password":password, @"noWindowCheck" : @"true"} completion:^(id responseData, NSError *error) {
		
		THReservation *reservation = nil;
		if (!error)
		{
			NSDictionary *root = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
			root = [root valueForKey:@"reservation"];
			reservation = [[THReservation alloc] init];
			[reservation configureWithDictionary:root];
			reservation.isNextReservation = YES;
		}
		
		
        if (completion) {
            completion(reservation, error);
        }
    }];
}

- (void)fetchFlightStatusWithFlight:(THFlight *)flight account:(THAccount *)account completion:(THAAClientCompletionBlock)completion
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSMonthCalendarUnit fromDate:flight.depatureDate];
	
    NSString *departureMonth = [NSString stringWithFormat:@"%d", components.month];
    NSString *departureDay = [NSString stringWithFormat:@"%d", components.day];
    NSString *flightNumber = flight.flightNumber;
    NSDictionary *parameters = @{@"departureMonth": departureMonth, @"departureDay":departureDay , @"flightNumber": flightNumber };
	
    [self executeRequestWithPath:@"flightstatus" httpMethod:@"GET" parameters:parameters completion:^(id responseData, NSError *error) {

#warning Parse!
		THFlight *flight = nil;
		if (!error && [responseData length])
		{
			NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
			NSArray *flights = [dictionary valueForKeyPath:@"FIS flight status.flights"];
			if (flights.count)
			{
				NSDictionary *flightDictionary = flights[0];
				flight = [[THFlight alloc] init];
				[flight configureWithDictionary:flightDictionary];
			}
		}
				
		if (completion)
			completion(flight, error);
    }];
}


- (void)executeRequestWithPath:(NSString *)path httpMethod:(NSString *)method parameters:(NSDictionary *)parameters completion:(THAAClientCompletionBlock)completion
{
	NSMutableDictionary *allParameters = [NSMutableDictionary dictionaryWithObject:AAAPIKey forKey:@"apikey"];
	[allParameters addEntriesFromDictionary:parameters];
	
	NSMutableURLRequest *request = [self.httpClient requestWithMethod:@"GET" path:path parameters:allParameters];
	request.HTTPMethod = method;
	
	AFHTTPRequestOperation *operation = [self.httpClient HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
		if (completion)
			completion(responseObject, nil);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		if (completion)
			completion(nil, error);
	}];
	
	[self.httpClient enqueueHTTPRequestOperation:operation];
}

@end
