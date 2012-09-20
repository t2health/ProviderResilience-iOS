//
//  SettingsViewController.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

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
