//
//  AboutViewController.h
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

@interface AboutViewController : UIViewController <UIWebViewDelegate> {
    
    IBOutlet UIWebView *myWebView;
    
    IBOutlet UIButton *buttonProceed;
    BOOL bStartupMode;
    
}

@property (retain, nonatomic) IBOutlet UIView *viewAbout;
@property (retain, nonatomic) IBOutlet UIButton *buttonAboutNext;

@property (retain, nonatomic) IBOutlet UIView *viewHintDash;
@property (retain, nonatomic) IBOutlet UIImageView *viewImageDash;
@property (retain, nonatomic) IBOutlet UIButton *buttonDashPrev;
@property (retain, nonatomic) IBOutlet UIButton *buttonDashNext;

@property (retain, nonatomic) IBOutlet UIView *viewHintCards;
@property (retain, nonatomic) IBOutlet UIImageView *viewImageCard;
@property (retain, nonatomic) IBOutlet UIButton *buttonCardPrev;
@property (retain, nonatomic) IBOutlet UIButton *buttonCardNext;


@property (nonatomic, retain) UIWebView *myWebView;
@property (retain, nonatomic) UIButton *buttonProceed;

- (void)loadHTML:(NSString *)fileName;
- (void)adjustPosition;


- (IBAction)buttonProceed_Clicked:(id)sender;
- (IBAction)buttonHintDash_Clicked:(id)sender;
- (IBAction)buttonHintCards_Clicked:(id)sender;
- (IBAction)buttonAbout_Clicked:(id)sender;

- (void)StartupMode;
@end
