//
//  THAppDelegate.m
//  TravelHack
//
//  Created by Andrew Hulsizer on 3/9/13.
//  Copyright (c) 2013 Team AT&T Travel Hackathon. All rights reserved.
//

#import "THAppDelegate.h"
#import "DCIntrospect.h"
#import "THAAClient.h"
#import "THMemberDataSource.h"
#import "THNLClient.h"
#import "THDashboardViewController.h"
#import "THLoginViewController.h"

@interface THAppDelegate() <THLoginViewControllerDelegate>

@property (nonatomic, strong) THMemberDataSource *memberDataSource;
@property (nonatomic, strong) THLoginViewController *loginViewController;
@property (nonatomic, strong) THDashboardViewController *dashboardViewController;

@end

@implementation THAppDelegate

#pragma mark - THLoginViewControllerDelegate
- (void)loginViewController:(THLoginViewController *)loginViewController didRetrieveMember:(THMemberDataSource *)member
{
	self.memberDataSource = member;
	
	self.dashboardViewController = [[THDashboardViewController alloc] init];
	self.dashboardViewController.dataSource = self.memberDataSource;
	
	[UIView transitionFromView:self.loginViewController.view toView:self.dashboardViewController.view duration:.6 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionCurlUp completion:^(BOOL finished) {
	
		self.window.rootViewController = self.dashboardViewController;
		self.loginViewController = nil;
	}];

}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
	
	self.loginViewController = [[THLoginViewController alloc] init];
	self.loginViewController.delegate = self;
	
	self.window.rootViewController = self.loginViewController;
	[self.window makeKeyAndVisible];
		
#if TARGET_IPHONE_SIMULATOR
	[[DCIntrospect sharedIntrospector] start];
#endif
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
