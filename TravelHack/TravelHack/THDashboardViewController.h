//
//  THDashboardViewController.h
//  TravelHack
//
//  Created by John Lawson on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THMemberDataSource.h"

@interface THDashboardViewController : UIViewController
@property (nonatomic, strong) THMemberDataSource *dataSource;

@end
