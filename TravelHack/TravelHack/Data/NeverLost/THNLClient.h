//
//  THNLClient.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^THNLClientCompletionBlock)(id responseData, NSError *error);

@interface THNLClient : NSObject

+ (THNLClient *)sharedClient;
- (void)executePOISearchForAirportCode:(NSString *)airportCode completion:(THNLClientCompletionBlock)completion;

@end
