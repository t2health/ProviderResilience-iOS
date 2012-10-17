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

@class CLLocationManager;
@class CLLocation;

@interface FlurryAnalyticsAPI : NSObject {
}

/*
 optional sdk settings that should be called before start session
 */
+ (void)setAppVersion:(NSString *)version;		// override the app version
+ (NSString *)getFlurryAnalyticsAgentVersion;			// get the FlurryAnalytics Agent version number
+ (void)setAppCircleEnabled:(BOOL)value;		// default is NO
+ (void)setShowErrorInLogEnabled:(BOOL)value;	// default is NO
+ (void)unlockDebugMode:(NSString*)debugModeKey apiKey:(NSString *)apiKey;	// generate debug logs for FlurryAnalytics support
+ (void)setPauseSecondsBeforeStartingNewSession:(int)seconds; // default is 10 seconds

/*
 start session, attempt to send saved sessions to server 
 */
+ (void)startSession:(NSString *)apiKey;

/*
 log events or errors after session has started
 */
+ (void)logEvent:(NSString *)eventName;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;
+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error;

/* 
 start or end timed events
 */
+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters timed:(BOOL)timed;
+ (void)endTimedEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;	// non-nil parameters will update the parameters

/*
 count page views
 */
+ (void)countPageViews:(id)target;		// automatically track page view on UINavigationController or UITabBarController
+ (void)countPageView;					// manually increment page view by 1

/*
 set user info
 */
+ (void)setUserID:(NSString *)userID;	// user's id in your system
+ (void)setAge:(int)age;				// user's age in years
+ (void)setGender:(NSString *)gender;	// user's gender m or f

/*
 optional session settings that can be changed after start session
 */
+ (void)setSessionReportsOnCloseEnabled:(BOOL)sendSessionReportsOnClose;	// default is YES
+ (void)setSessionReportsOnPauseEnabled:(BOOL)setSessionReportsOnPauseEnabled;	// default is YES
+ (void)setEventLoggingEnabled:(BOOL)value;		// default is YES

/* 
 create an AppCircle banner on a hook and a view parent 
 subsequent calls will return the same banner for the same hook and parent until removed with the API
 */
+ (UIView *)getHook:(NSString *)hook xLoc:(int)x yLoc:(int)y view:(UIView *)view;
/* 
 create an AppCircle banner on a hook and view parent using optional parameters 
 */
+ (UIView *)getHook:(NSString *)hook xLoc:(int)x yLoc:(int)y view:(UIView *)view attachToView:(BOOL)attachToView orientation:(NSString *)orientation canvasOrientation:(NSString *)canvasOrientation autoRefresh:(BOOL)refresh canvasAnimated:(BOOL)canvasAnimated;
/* 
 update an existing AppCircle banner with a new ad
 */
+ (void)updateHook:(UIView *)banner;
/* 
 remove an existing AppCircle banner from its hook and parent
 a new banner can be created on the same hook and parent after the existing banner is removed
 */
+ (void)removeHook:(UIView *)banner;
/*
 open the canvas without using a banner
 */
+ (void)openCatalog:(NSString *)hook canvasOrientation:(NSString *)canvasOrientation canvasAnimated:(BOOL)canvasAnimated;
/*
 refer to FlurryAnalyticsAdDelegate.h for delegate details
 */
+ (void)setAppCircleDelegate:(id)delegate;

@end
