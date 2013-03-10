//
//  THAccountSummaryView.h
//  TravelHack
//
//  Created by John Lawson on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THAccountSummaryView : UIView

@property (nonatomic, weak) IBOutlet UIImageView *badgeImageView;
@property (nonatomic, weak) IBOutlet UILabel *currentPointsLabel;

- (void)setCurrentPoints:(NSUInteger)currentPoints;
- (void)setBadgeImage:(UIImage *)badgeImage;

@end
