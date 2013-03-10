//
//  THNLClient.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THNLClient.h"
#import "AFNetworking.h"

static NSString * const NLBaseServicesURL = @"http://stg-services.navsol.net";
static NSString * const NLTenantGUID = @"1B789923-C734-4E53-87AD-6ECB9AE37397";;
static NSString * const NLApplicationGUID = @"E5677C50-3DC2-45F3-9C83-9A99EB51A03C";

@interface THNLClient()
@property (nonatomic, strong) AFHTTPRequestOperation *tokenOperation;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) AFHTTPClient *client;
@end

@implementation THNLClient

+ (THNLClient *)sharedClient
{
	static THNLClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedClient = [[self alloc] init];
	});
	return _sharedClient;
}

- (id)init
{
	self = [super init];
	if (self)
	{
		NSURL *URL = [NSURL URLWithString:NLBaseServicesURL];
		_client = [AFHTTPClient clientWithBaseURL:URL];
		[_client setDefaultHeader:@"content-type" value:@"application/json"];
		[_client setDefaultHeader:@"accept" value:@"application/json"];

		[self loadTokenData];
		
		_operationQueue = [[NSOperationQueue alloc] init];
	}
	return self;
}

- (void)loadTokenData
{
	NSDictionary *parameters = @{@"tenantGuid" : NLTenantGUID, @"applicationGuid" : NLApplicationGUID};
	NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:@"security/tokenmanagement/createtoken" parameters:parameters];
	
	AFHTTPRequestOperation *operation = [self.client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSError *error = nil;
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
	
	self.tokenOperation = operation;
	[self.client enqueueHTTPRequestOperation:operation];
}

- (void)executePOISearchForAirportCode:(NSString *)airportCode completion:(THNLClientCompletionBlock)completion
{
	if (!airportCode.length)
		return;
		
	NSDictionary *parameters = @{@"phrase": airportCode};
	[self executeRequestWithPath:@"search/pois/" httpMethod:@"GET" parameters:parameters completion:^(id responseData, NSError *error) {
		NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
		NSNumber *latitude = [dictionary valueForKeyPath:@"Data.Latitude"];
		NSNumber *longitude = [dictionary valueForKeyPath:@"Data.Longitude"];
		
		NSDictionary *parameters = @{@"latitude": [latitude description], @"longitude" : [longitude description], @"alwaysSearch" : @"true", @"CityId" : @"35196", @"mapRadius" : @"1", @"radius" : @"1", @"phrase" : @"shopping, food"};
		[self executeRequestWithPath:@"search/pois/" httpMethod:@"GET" parameters:parameters completion:^(id responseData, NSError *error) {
			NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
			
			if (completion)
				completion(dictionary, error);
		}];
		
	}];
}

- (void)addTokenDataIfNeeded
{
	if (!self.token)
	{
		NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:self.tokenOperation.responseData options:0 error:nil];
		self.token = [dictionary objectForKey:@"Data"];
		[self.client setDefaultHeader:@"Authorization" value:self.token];
	}
}

- (void)executeRequestWithPath:(NSString *)path httpMethod:(NSString *)method parameters:(NSDictionary *)parameters completion:(THNLClientCompletionBlock)completion
{
	NSOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
		[self addTokenDataIfNeeded];
		
		NSMutableURLRequest *request = [self.client requestWithMethod:@"GET" path:path parameters:parameters];
		request.HTTPMethod = method;
		
		AFHTTPRequestOperation *operation = [self.client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
			if (completion)
				completion(responseObject, nil);
		} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			if (completion)
				completion(nil, error);
		}];

		[self.client enqueueHTTPRequestOperation:operation];
	}];
	
	[blockOperation addDependency:self.tokenOperation];
	[self.operationQueue addOperation:blockOperation];
}

- (AFHTTPRequestOperation *)operationWithPath:(NSString *)path httpMethod:(NSString *)method parameters:(NSDictionary *)parameters completion:(THNLClientCompletionBlock)completion
{
	
}

@end
