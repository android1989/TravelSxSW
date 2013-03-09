//
//  THZuluDateFormatter.m
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THZuluDateFormatter.h"

@interface THZuluDateFormatter ()
@property (nonatomic, strong) NSDateFormatter *formatter;
@end

@implementation THZuluDateFormatter

- (id)init
{
	self = [super init];
	if (self)
	{
		_formatter = [[NSDateFormatter alloc] init];
		_formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_POSIX"];
		_formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
		_formatter.dateFormat = @"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSSSZ";
	}
	return self;
}

- (NSDate *)dateFromString:(NSString *)string
{
	NSMutableString *mutableString = [string mutableCopy];
	NSRange range = [string rangeOfString:@":" options:NSBackwardsSearch];
	[mutableString deleteCharactersInRange:range];
	
	NSDate *date = [self.formatter dateFromString:mutableString];
	return date;
}

@end
