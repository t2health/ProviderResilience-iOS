//
//  SettingsViewController.h
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
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "DateTimePicker.h"
#import "SaveSettings.h"

@interface SettingsViewController : UIViewController <MFMailComposeViewControllerDelegate, DateTimePickerDelegate> {
    // Persistent data that we will store in Settings.plist  
    BOOL bWelcomeMsg;
    BOOL bDailyReminders;
    BOOL bAnonymousData;
    
    SaveSettings *currentSettings;
}

@property (retain, nonatomic) SaveSettings *currentSettings;

// Reset Application
- (IBAction)reset_Clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelReset;
@property (retain, nonatomic) IBOutlet UIButton *buttonReset;

// Welcome Message (display or not display)
- (IBAction)welcome_Clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelWelcome;
@property (retain, nonatomic) IBOutlet UIButton *buttonWelcome;
@property (retain, nonatomic) IBOutlet UIImageView *img_welcomeOnOff;

// Daily Reminders (yes/no)
- (IBAction)reminder_Clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelReminder;
@property (retain, nonatomic) IBOutlet UIButton *buttonReminder;
@property (retain, nonatomic) IBOutlet UIImageView *img_reminderOnOff;

// Remind me at:
- (IBAction)remindAt_Clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelRemindAt;
@property (retain, nonatomic) IBOutlet UIButton *buttonRemindAt;

// Anonymous Data (yes/no)
- (IBAction)anonymous_Clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelAnonymous;
@property (retain, nonatomic) IBOutlet UIButton *buttonAnonymous;
@property (retain, nonatomic) IBOutlet UIImageView *img_anonymousOnOff;

// Reset Scores Time
- (IBAction)resetScores_clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelResetScores;
@property (retain, nonatomic) IBOutlet UIButton *buttonResetScores;

// Send Feedback
- (IBAction)feedback_Clicked:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *labelFeedback;
@property (retain, nonatomic) IBOutlet UIButton *buttonFeedback;

// Email methods
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
-(void)shouldWeLaunchEmail;

// Helper Methods
- (void)setUpWelcomeButton:(BOOL)bOnOff;
- (void)setUpReminderButton:(BOOL)bOnOff;
- (void)setUpAnonymousButton:(BOOL)bOnOff;

@end
