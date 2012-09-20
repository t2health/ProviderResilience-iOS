//
//  ProviderResilienceAppDelegate.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

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
