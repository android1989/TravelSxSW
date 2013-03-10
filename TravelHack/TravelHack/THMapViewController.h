//
//  THMapViewController.h
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THRadarView.h"

@interface THMapViewController : UIViewController
@property (weak, nonatomic) IBOutlet THRadarView *radarView;
@property (nonatomic, copy) NSArray *opportunities;

@end
