//
//  THOpportunityImageFactory.h
//  TravelHack
//
//  Created by Austen Green on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THOpportunity.h"

@interface THOpportunityImageFactory : NSObject

+ (UIImage *)imageForOpportunity:(THOpportunity *)opportunity;

@end
