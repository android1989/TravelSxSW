//
//  THAAClient.h
//  TravelHack
//
//  Created by Austen Green on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^THAAClientCompletionBlock)(id responseData, NSError *error);

@interface THAAClient : NSObject

+ (THAAClient *)client;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;

@end
