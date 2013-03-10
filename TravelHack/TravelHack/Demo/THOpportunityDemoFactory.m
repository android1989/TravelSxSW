//
//  THOpportunityDemoFactory.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THOpportunityDemoFactory.h"
#import "THOpportunity.h"

@implementation THOpportunityDemoFactory

+ (NSArray *)opportunities
{
	NSURL *URL = [[NSBundle mainBundle] URLForResource:@"DemoOpportunities" withExtension:@"plist"];
	return [self opportunitiesWithURL:URL];
}

+ (NSArray *)opportunitiesWithURL:(NSURL *)URL
{
	NSArray *array = [NSArray arrayWithContentsOfURL:URL];
	
	NSMutableArray *opportunities = [NSMutableArray array];
	for (NSDictionary *dictionary in array)
	{
		THOpportunity *opportunity = [[THOpportunity alloc] init];
		[opportunity setValuesForKeysWithDictionary:dictionary];
		[opportunities addObject:opportunity];
	}
	
	return opportunities;

}

+ (NSArray *)reedemableOpportunities
{
	NSURL *URL = [[NSBundle mainBundle] URLForResource:@"DemoRedeemables" withExtension:@"plist"];
	return [self opportunitiesWithURL:URL];
}

@end
