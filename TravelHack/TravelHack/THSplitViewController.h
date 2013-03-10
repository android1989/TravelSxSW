//
//  THSplitViewController.h
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THSplitViewController : UIViewController

@property (nonatomic, strong) IBOutlet UILabel *pointsLabel;
@property (nonatomic, strong) IBOutlet UILabel *staticTimeLabel;
@property (nonatomic, strong) IBOutlet UILabel *staticStatusLabel;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UILabel *terminalLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *topSplitView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomSplitView;

- (void)split;
- (void)join;
- (void)incrementMiles:(NSInteger)addition basePoints:(NSInteger)basePoints;
- (void)decrementMiles:(NSInteger)subtraction basePoints:(NSInteger)basePoints;
@end
