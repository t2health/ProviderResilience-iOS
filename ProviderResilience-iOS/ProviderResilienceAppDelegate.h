//
//  ProviderResilienceAppDelegate.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//
/*
 *
 * Provider Resilience
 *
 * Copyright © 2009-2012 United States Government as represented by
 * the Chief Information Officer of the National Center for Telehealth
 * and Technology. All Rights Reserved.
 *
 * Copyright © 2009-2012 Contributors. All Rights Reserved.
 *
 * THIS OPEN SOURCE AGREEMENT ("AGREEMENT") DEFINES THE RIGHTS OF USE,
 * REPRODUCTION, DISTRIBUTION, MODIFICATION AND REDISTRIBUTION OF CERTAIN
 * COMPUTER SOFTWARE ORIGINALLY RELEASED BY THE UNITED STATES GOVERNMENT
 * AS REPRESENTED BY THE GOVERNMENT AGENCY LISTED BELOW ("GOVERNMENT AGENCY").
 * THE UNITED STATES GOVERNMENT, AS REPRESENTED BY GOVERNMENT AGENCY, IS AN
 * INTENDED THIRD-PARTY BENEFICIARY OF ALL SUBSEQUENT DISTRIBUTIONS OR
 * REDISTRIBUTIONS OF THE SUBJECT SOFTWARE. ANYONE WHO USES, REPRODUCES,
 * DISTRIBUTES, MODIFIES OR REDISTRIBUTES THE SUBJECT SOFTWARE, AS DEFINED
 * HEREIN, OR ANY PART THEREOF, IS, BY THAT ACTION, ACCEPTING IN FULL THE
 * RESPONSIBILITIES AND OBLIGATIONS CONTAINED IN THIS AGREEMENT.
 *
 * Government Agency: The National Center for Telehealth and Technology
 * Government Agency Original Software Designation: Provider Resilience001
 * Government Agency Original Software Title: Provider Resilience
 * User Registration Requested. Please send email
 * with your contact information to: robert.kayl2@us.army.mil
 * Government Agency Point of Contact for Original Software: robert.kayl2@us.army.mil
 *
 */
#import <UIKit/UIKit.h>
#import "Analytics.h"
#import "Reachability.h"
#import "BCMediaAPI.h"
#import "SaveSettings.h"

@class ProviderResilienceViewController;

@interface ProviderResilienceAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate, UITabBarDelegate> {
    IBOutlet UIWindow *window;
    IBOutlet UITabBarController *rootController;
    
    
    Reachability* hostReach;
    Reachability* internetReach;
    Reachability* wifiReach;
    NetworkStatus networkStatus;
    BOOL connectionRequired;
    
	BCMediaAPI *bcServices;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UITabBarController *rootController;


@property (nonatomic) BOOL connectionRequired;
@property (nonatomic) NetworkStatus networkStatus;
@property (nonatomic, readonly) BCMediaAPI *bcServices;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)normalStartUp;
- (void)eulaStartUp;

-(void) FlurryAnalyticsPageView:(NSString *)PageViewed;

-(BOOL)checkInternet;
-(void)reachabilityChanged:(NSNotification* )note;
-(void)updateInterfaceWithReachability:(Reachability*)curReach;

-(NSString *)getAppSetting:(NSString *)group withKey:(NSString *)key;

- (void)checkBCConnection;
- (void)resetBCConnection:(NSString *)key;
@end
