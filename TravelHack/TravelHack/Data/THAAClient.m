//
//  THAAClient.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THAAClient.h"
#import "BRNetworkManager.h"
#import "BRNetworkCallback.h"
#import "BRRequestParameter.h"
#import "AFHTTPClient.h"

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
	
	[self.httpClient postPath:@"login" parameters:@{@"aadvantageNumber": username, @"password" : password, @"apikey" : AAAPIKey} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"%@", responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"%@", error);
	}];
}

@end
