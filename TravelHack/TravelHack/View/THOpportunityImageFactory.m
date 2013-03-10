//
//  THOpportunityImageFactory.m
//  TravelHack
//
//  Created by Austen Green on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THOpportunityImageFactory.h"

static NSDictionary *_imageMap;
static NSString *_defaultImageName;

@implementation THOpportunityImageFactory

+ (void)initialize
{
	NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
	[dictionary setObject:@"coffee_table_cell" forKey:THOpportunityCategoryCoffee];
	_defaultImageName = @"coffee_table_cell";
	
	_imageMap = dictionary;
}

+ (UIImage *)imageForOpportunity:(THOpportunity *)opportunity
{
	NSString *name = [_imageMap objectForKey:opportunity.category];
	if (!name)
		name = _defaultImageName;
	
	return [UIImage imageNamed:name];
}

@end
