//
//  THLoginViewController.h
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THLoginViewController;
@class THMemberDataSource;

@protocol THLoginViewControllerDelegate <NSObject>

@required
- (void)loginViewController:(THLoginViewController *)loginViewController didRetrieveMember:(THMemberDataSource *)member;

@end

@interface THLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, weak) id <THLoginViewControllerDelegate> delegate;

@end
