//
//  THLoginViewController.h
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/10/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THAccount;
@class THLoginViewController;

@protocol THLoginViewControllerDelegate <NSObject>

@required
- (void)loginViewControllerDidRequestSignIn:(THLoginViewController *)loginViewController;

@end

@interface THLoginViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *aaNumber;
@property (nonatomic, strong) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (nonatomic, weak) id <THLoginViewControllerDelegate> delegate;

@end
