//
//  ViewVideoController.h
//  BrightcoveTest
//
//  Created by Roger Reeder on 5/6/11.
//  Copyright 2011 T2. All rights reserved.
//
//  Modified:
//  07/16/2012 BGD To use modally (requires a delegate)
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
#import "BCMoviePlayerController.h"

#import "BCVideo.h"
@class ViewBCVideoController;

@protocol ViewBCDelegate <NSObject>

- (void)dismissViewBC:(ViewBCVideoController *)controller;

@end


@interface ViewBCVideoController : UIViewController <UIAlertViewDelegate>{
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *lblLoading;
    BCMoviePlayerController *bcPlayer;
    BCVideo *video;
    long long videoID;
    NSString *videoDescription;
    
    // Delegate
    id < ViewBCDelegate > delegate;
}
@property (nonatomic, retain) BCMoviePlayerController *bcPlayer;
@property (nonatomic, retain) BCVideo *video;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) long long videoID;
@property (nonatomic, retain) NSString *videoDescription;
@property (nonatomic, retain) 	IBOutlet UILabel *lblLoading;
@property (nonatomic, assign) id < ViewBCDelegate > delegate;

- (void)updateLayout:(CGRect)frame;

- (void)replay:(id)sender;
- (void)animateRotation: (UIInterfaceOrientation) interfaceOrientation 
               duration: (NSTimeInterval )duration;

- (void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
- (void)fadeOutPlayer;
- (void)fadeInPlayer;
- (void)showWaitingOnDownload:(BOOL)bShow;
- (void)createWaitingOnDownload;

@end

