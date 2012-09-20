//
//  ProviderResilienceAppDelegate.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "ProviderResilienceAppDelegate.h"
#import "ToolsViewController.h"
#import "DashboardViewController.h"
#import "CardsViewController.h"
#import "PRdatabaseSQL.h"
#import "EulaViewController.h"
#import "AboutViewController.h"

@implementation ProviderResilienceAppDelegate

@synthesize rootController = __rootController;;
@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

@synthesize networkStatus;
@synthesize connectionRequired;
@synthesize bcServices;

void uncaughtExceptionHandler(NSException *exception) {
    [FlurryAnalytics logError:@"Uncaught" message:@"Crash!" exception:exception];
}

- (void)dealloc
{
    [_window release];
    [__managedObjectContext release];
    [__managedObjectModel release];
    [__persistentStoreCoordinator release];
    [__rootController release];
    
    
    [hostReach release];
    [wifiReach release];
    [internetReach release];
    
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // Grab the current settings
    SaveSettings *currentSettings = [SaveSettings alloc];
    [currentSettings initPlist];
    
    // Remove any badges
	application.applicationIconBadgeNumber = 0;
	
    // Make sure we get our Brightcove connection (can be removed if we implement the stuff that follows!)
    [self checkBCConnection];
    
    
    
    NSString *reachablityURL = [self getAppSetting:@"URLs" withKey: @"reachablityCheckBC"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(reachabilityChanged:) name: kReachabilityChangedNotification object: nil];
    
    
    hostReach = [[Reachability reachabilityWithHostName: reachablityURL] retain];
	[hostReach startNotifier];
	
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
    
    wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
	[wifiReach startNotifier]; 
    
    // Production time! (7/30/2012)
    //#ifdef DEBUG
    //  NSString *analyticsKey = [self getAppSetting:@"Analytics" withKey:@"debugKey"];
    //#else
    NSString *analyticsKey = [self getAppSetting:@"Analytics" withKey:@"appKey"];
    //#endif
    
    // Enable/Disable Analytics
    BOOL bAnonymousData = [currentSettings boolFromNumber:[currentSettings bAnonymousData]];
    
    [Analytics init:analyticsKey isEnabled:bAnonymousData];        // Enable/Disable Analytics 
    
    // Make sure we have a database before we go too far
    PRdatabaseSQL *mySQL = [PRdatabaseSQL alloc];
    [mySQL createDbTables];
    [mySQL release];
    
    //self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    //[self.window addSubview:rootController.view];
    
    // Check NSUserDefaults to make sure we have read the EULA
    // Note...we will not create the KEY if the user says NO...
    // So if the KEY is missing, they have not agreed to the EULA yet
    NSString *kEULAdone					= @"eulaDONE";
    NSString *testValue = [[NSUserDefaults standardUserDefaults] stringForKey:kEULAdone];
    if (testValue == nil)
    {
        // User needs to agree to the EULA before continuing...
        EulaViewController *viewController = [EulaViewController alloc];
        self.window.rootViewController = viewController;
        [viewController release];
    } else {        
        // Check if they want the welcome screen
        
        // Set up the On/Off buttons 
        BOOL bShowWelcome = [currentSettings boolFromNumber:[currentSettings bWelcomeMessage]];
        if (bShowWelcome) {
            // Display the welcome
            AboutViewController *viewController = [AboutViewController alloc];
            [viewController StartupMode];
            self.window.rootViewController = viewController;
            [viewController release];
                        
        } else {
            // Show a random card
            CardsViewController *viewController = [CardsViewController alloc];
            [viewController StartupMode];
            self.window.rootViewController = viewController;
            [viewController release];
        }
        
    }
    
    [currentSettings release];
    
    return YES;
}

- (void)eulaStartUp {
    
    // Display the welcome
    AboutViewController *viewController = [AboutViewController alloc];
    [viewController StartupMode];
    self.window.rootViewController = viewController;
    [viewController release];
    
    // Grab the current settings
    SaveSettings *currentSettings = [SaveSettings alloc];
    [currentSettings initPlist];
    [currentSettings uWelcome:NO];
    [currentSettings writeToPlist];     // Turn off the welcome message after the first showing
}

- (void)normalStartUp {
    // Hand off to the tab bar controller
    self.window.rootViewController = __rootController;
    self.window.rootViewController.tabBarController.selectedIndex = 2;   // Display the cards first
    self.window.rootViewController.tabBarController.delegate = self;
    [self.window makeKeyAndVisible];
    
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
    // Remove any badges
	application.applicationIconBadgeNumber = 0;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark local notifications
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

// UIApplicationState state = [application applicationState];
// if (state == UIApplicationStateInactive) {

// Application was in the background when notification
// was delivered.
// }

// Remove the badges
application.applicationIconBadgeNumber = 0;
    
    /*
    if ([@"YES" isEqualToString:[notification.userInfo valueForKey:kNotifyDailyReminder]]) NSLog(@"Daily Reminder received");
    else NSLog(@"Other local notification received");
    */
    
    if ([@"YES" isEqualToString:[notification.userInfo valueForKey:kNotifyDailyReminder]]) {
        
        NSString *alertTitle = NSLocalizedString(@"Reminder", nil);
        NSString *alertMessage = NSLocalizedString(@"Please remember to update your Provider Resilience Score!", nil);
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle 
                                                            message:alertMessage 
                                                           delegate:nil 
                                                  cancelButtonTitle:NSLocalizedString(@"OK", nil) 
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
}

#pragma mark TabBarController Delegate Methods
/*
- (void)tabBar:(UITabBar *)theTabBar didSelectItem:(UITabBarItem *)item {
    NSUInteger indexOfTab = [[theTabBar items] indexOfObject:item];
    NSLog(@"Tab index = %u", indexOfTab);
}
 */
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    //NSLog(@"tabBarController delegate called: %@",viewController.nibName);
    // The user has tapped a Tab Bar item
    // Return this controller to its default view (well, the ones that have more than one view)
    if ([viewController.nibName isEqualToString:@"ToolsViewController"]) {
        ToolsViewController *ourView = (ToolsViewController *)viewController;
        viewController.view = ourView.viewToolsMenu;
    }
    
    if ([viewController.nibName isEqualToString:@"DashboardViewController"]) {
        DashboardViewController *ourView = (DashboardViewController *)viewController;
        [ourView NoAssessment];         // Turn off Assessment mode
        viewController.view = ourView.viewMainDashboard;
        [ourView attachDigitalClockView:viewController.view];   // Make sure we have the digital clock                
    }
    
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ProviderResilience_iOS" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ProviderResilience_iOS.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
#pragma mark -
#pragma mark FlurryAnalytics Functions
-(void) FlurryAnalyticsPageView:(NSString *)PageViewed {
	[Analytics logEvent:PageViewed];
	[Analytics countPageView];
}

#pragma mark -
#pragma mark Checking Internet Connection

-(BOOL)checkInternet{
    
    NSString *reachablityURL = [self getAppSetting:@"URLs" withKey:@"reachablityCheckBC"];
	Reachability *r = [Reachability reachabilityWithHostName:reachablityURL];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	BOOL internet;
	if(internetStatus == ReachableViaWiFi || internetStatus == ReachableViaWWAN) {
		internet = YES;
	}else {
        NSLog(@"Internet is not available");
		internet = NO;
	}
	return internet;
     
}

//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
    
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    [self updateInterfaceWithReachability:curReach];
     
}

- (void) updateInterfaceWithReachability: (Reachability*) curReach {
    if(curReach == hostReach) {
        self.networkStatus = [curReach currentReachabilityStatus];
        self.connectionRequired= [curReach connectionRequired];
        if (self.networkStatus == NotReachable) {
            self.connectionRequired = NO;
        }
    }
    if (!self.bcServices) {
        BOOL hasInternet = NO;
        switch (self.networkStatus) {
            case NotReachable:
                hasInternet = NO;
                break;
            default:
                if (!self.connectionRequired) {
                    hasInternet = YES;
                }
                break;
        }
        [self checkBCConnection];
    }
}


- (void)checkBCConnection {
    // init Brightcove Media API
    NSString *apiKey = [self getAppSetting:@"Brightcove" withKey:@"apikey1"];
    BCMediaAPI *bcServ = [[[BCMediaAPI alloc] initWithReadToken:apiKey] retain];
    [bcServ setMediaDeliveryType:BCMediaDeliveryTypeHTTP];
    
    bcServices = bcServ;
    [bcServ release];
}

- (void)resetBCConnection:(NSString *)key {
    
    // init Brightcove Media API
    if (self.bcServices) {
        [self.bcServices release];
    }
    NSString *apiKey = [self getAppSetting:@"Brightcove" withKey:key];
    BCMediaAPI *bcServ = [[[BCMediaAPI alloc] initWithReadToken:apiKey] retain];
    [bcServ setMediaDeliveryType:BCMediaDeliveryTypeHTTP];
    
    bcServices = bcServ;
    [bcServ release];
}

#pragma mark -
#pragma mark Utilities
-(NSString *)getAppSetting:(NSString *)group withKey:(NSString *)key {
    NSDictionary *ps = [NSPropertyListSerialization propertyListFromData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"app" ofType:@"plist"]] 
                                                        mutabilityOption:NSPropertyListImmutable 
                                                                  format:nil errorDescription:nil];
    NSDictionary *grp = (NSDictionary *)[ps objectForKey:group];
    return (NSString *)[grp objectForKey:key];
}

@end
