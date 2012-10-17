//
//  SettingsViewController.m
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
#import "SettingsViewController.h"
#import "Analytics.h"
#import <QuartzCore/QuartzCore.h>

// Tag values to distinguish UIAlertViews
#define kTagResetApplication        1
#define kTagSendFeedback            2

// Tag values to distinguish DateTimePicker
#define kTagRemindAt        0
#define kTagResetScores     1

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize labelReset;
@synthesize buttonReset;
@synthesize labelWelcome;
@synthesize buttonWelcome;
@synthesize labelReminder;
@synthesize buttonReminder;
@synthesize labelRemindAt;
@synthesize buttonRemindAt;
@synthesize labelAnonymous;
@synthesize buttonAnonymous;
@synthesize labelResetScores;
@synthesize buttonResetScores;
@synthesize labelFeedback;
@synthesize buttonFeedback;
@synthesize img_anonymousOnOff;
@synthesize img_reminderOnOff;
@synthesize img_welcomeOnOff;
@synthesize currentSettings;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    // ***** NOTE Save this until we terminate!
    // Grab the current settings
    self.currentSettings = [SaveSettings alloc];
    [self.currentSettings initPlist];
    
    // Set up the On/Off buttons 
    [self setUpWelcomeButton:[self.currentSettings boolFromNumber:[self.currentSettings bWelcomeMessage]]];
    [self setUpReminderButton:[self.currentSettings boolFromNumber:[self.currentSettings bDailyReminders]]];
    [self setUpAnonymousButton:[self.currentSettings boolFromNumber:[self.currentSettings bAnonymousData]]];
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
    // Customize the look of our labels/buttons
    self.buttonReset.layer.cornerRadius = 8;
    self.buttonWelcome.layer.cornerRadius = 8;
    self.buttonReminder.layer.cornerRadius = 8;
    self.buttonRemindAt.layer.cornerRadius = 8;
    self.buttonAnonymous.layer.cornerRadius = 8;
    self.buttonResetScores.layer.cornerRadius = 8;
    self.buttonFeedback.layer.cornerRadius = 8;
    self.labelReset.layer.cornerRadius = 8;
    self.labelWelcome.layer.cornerRadius = 8;
    self.labelReminder.layer.cornerRadius = 8;
    self.labelRemindAt.layer.cornerRadius = 8;
    self.labelAnonymous.layer.cornerRadius = 8;
    self.labelResetScores.layer.cornerRadius = 8;
    self.labelFeedback.layer.cornerRadius = 8;
}

- (void)viewDidUnload
{
    [self setButtonWelcome:nil];
    [self setButtonReminder:nil];
    [self setButtonAnonymous:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated  {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [img_welcomeOnOff release];
    [img_reminderOnOff release];
    [img_anonymousOnOff release];
    [buttonWelcome release];
    [buttonReminder release];
    [buttonAnonymous release];
    [currentSettings release];
    self.currentSettings = nil;
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    BOOL biPhoneOrientation = (interfaceOrientation== UIInterfaceOrientationPortrait);
    BOOL bOrientation = biPhoneOrientation;
    
    // Customize for iPad (orientation and other)
    /*
     BOOL biPadOrientation = biPhoneOrientation || (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) ||
     (interfaceOrientation==UIInterfaceOrientationLandscapeRight);
     
     //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) bOrientation = biPadOrientation;
     */
    return bOrientation;
}

// Reset Application
- (IBAction)reset_Clicked:(id)sender {
    // Double check with the user...this will delete all the App data
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Reset Application", @"")
                          message:NSLocalizedString(@"Are you sure you want to delete all your saved data?", @"")
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                          otherButtonTitles:NSLocalizedString(@"Cancel", @""),nil];
    
    alert.tag = kTagResetApplication;
    [alert show];
    [alert release];
}

// Reset Application
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (alertView.tag) {
        case kTagResetApplication:
            // Reset the Application...or not
            if (buttonIndex == 0)
            {
                [self resetUserData];
            }
            break;
            
        case kTagSendFeedback:
            // Send Feedback...or not
            if (buttonIndex == 0)
            {
                [self launchMailAppOnDevice];
            }
            break;
            
        default:
            break;
    }
}
/**
 *  resetUserData
 */
- (void)resetUserData {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        // Clear out the user data.
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *applicationDocumentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSError *error = nil;
        for (NSString *filename in [fileManager contentsOfDirectoryAtPath:applicationDocumentsPath error:&error]) {
            [fileManager removeItemAtPath:[applicationDocumentsPath stringByAppendingPathComponent:filename] error:&error];
        }  
        
        [fileManager release];
        
        // Reset the user defaults
        
        
        // Switch back to the main thread for updating the UI.
        dispatch_sync(dispatch_get_main_queue(), ^{
            // Tear down the UI ???
            
            NSString *alertTitle = NSLocalizedString(@"Application Reset", nil);
            NSString *alertMessage = NSLocalizedString(@"All user-entered data has been cleared.", nil);
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle 
                                                                message:alertMessage 
                                                               delegate:nil 
                                                      cancelButtonTitle:NSLocalizedString(@"OK", nil) 
                                                      otherButtonTitles:nil];
            [alertView show];
            [alertView release];
        });
    });
}

// Welcome Message
- (IBAction)welcome_Clicked:(id)sender {
    // Toggle the status of the Welcome Message
    //self.currentSettings = [SaveSettings alloc];
    [self.currentSettings initPlist];
    BOOL bCurrent = ![self.currentSettings boolFromNumber:[self.currentSettings bWelcomeMessage]]; 
    //[self.currentSettings boolToNumber:bCurrent :[self.currentSettings bWelcomeMessage]]; 
    [self.currentSettings uWelcome:bCurrent];
    [self.currentSettings writeToPlist];     // Save the changes
    
    [self setUpWelcomeButton:bCurrent];  
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
}

- (void)setUpWelcomeButton:(BOOL)bOnOff {
    // Set the button image and title based on the status
    if (bOnOff) {
        img_welcomeOnOff.image = [UIImage imageNamed:@"exercise.png"];
        [buttonWelcome setTitle:@"On" forState:UIControlStateNormal];
    } else {
        img_welcomeOnOff.image = [UIImage imageNamed:@"bg-on-1pxl.png"]; 
        [buttonWelcome setTitle:@"Off" forState:UIControlStateNormal]; 
    }
}

#pragma mark Reset Daily Scores
- (IBAction)resetScores_clicked:(id)sender {
    
    // Present dialog to allow user to enter the time of day to reset the daily scores
	DateTimePicker *controller = [[DateTimePicker alloc] init];
    [controller resetDatePickerMode:UIDatePickerModeTime];
	controller.delegate = self;
    
    // Use the current value
    [self.currentSettings initPlist];
	controller.defaultDate = [self.currentSettings dateTimeScoresReset]; 
    controller.view.tag = kTagResetScores;
    
	[self presentModalViewController:controller animated:YES];
	[controller release];    
}


#pragma mark Reminder Notifications
// Daily Reminder Notifications
- (IBAction)reminder_Clicked:(id)sender {
    // Toggle the status of the Reminder Notifications
    //self.currentSettings = [SaveSettings alloc];
    [self.currentSettings initPlist];
    
    BOOL bCurrent = ![self.currentSettings boolFromNumber:[self.currentSettings bDailyReminders]]; 
    
    // Now turn on/off the Reminder notifications
    
    [self.currentSettings uDaily:bCurrent];
    [self.currentSettings writeToPlist];     // Save the changes
    
    [self setUpReminderButton:bCurrent];
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
}

- (void)setUpReminderButton:(BOOL)bOnOff {
    // Set the button image and title based on the status
    if (bOnOff) {
        img_reminderOnOff.image = [UIImage imageNamed:@"exercise.png"];
        [buttonReminder setTitle:@"On" forState:UIControlStateNormal];
    } else {
        img_reminderOnOff.image = [UIImage imageNamed:@"bg-on-1pxl.png"]; 
        [buttonReminder setTitle:@"Off" forState:UIControlStateNormal]; 
    }
    
    [self scheduleNotification:bOnOff];
}

// Remind me at:
- (IBAction)remindAt_Clicked:(id)sender {
    // Present dialog to allow user to enter the time of day to send the notification reminder
	DateTimePicker *controller = [[DateTimePicker alloc] init];
    [controller resetDatePickerMode:UIDatePickerModeTime];
	controller.delegate = self;
  
    // Use the current value
    [self.currentSettings initPlist];
	controller.defaultDate = [self.currentSettings dateTimeDailyReminders]; 
    controller.view.tag = kTagRemindAt;
    
	[self presentModalViewController:controller animated:YES];
	[controller release];
    
}


- (void)scheduleNotification:(BOOL)bRemindersOn {
    
    [self.currentSettings initPlist];
    
    // Always cancel any current notifications
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    // And if we are turning notifications on, then start them up!
    if (bRemindersOn) {
        Class cls = NSClassFromString(@"UILocalNotification");
        if (cls != nil) {
            
            UILocalNotification *notif = [[cls alloc] init];
            notif.fireDate = [self.currentSettings dateTimeDailyReminders];
            notif.timeZone = [NSTimeZone defaultTimeZone];
            notif.repeatInterval = NSDayCalendarUnit;
            
            notif.alertBody = @"It is time to update your Provider Resilience Score.";
            notif.alertAction = @"Show me";
            notif.soundName = UILocalNotificationDefaultSoundName;
            notif.applicationIconBadgeNumber = 1;
            
            NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"YES"                 // Indicate that something is scheduled
                                                                 forKey:kNotifyDailyReminder];
            notif.userInfo = userDict;
            
            [[UIApplication sharedApplication] scheduleLocalNotification:notif];
            [notif release];
        }
    }
     
}

#pragma mark Anonymous Data
// Anonymous Data
- (IBAction)anonymous_Clicked:(id)sender {
    // Toggle the status of the Anonymous Data
    [self.currentSettings initPlist];
    BOOL bCurrent = ![currentSettings boolFromNumber:[self.currentSettings bAnonymousData]]; 
    //[self.currentSettings boolToNumber:bCurrent :[self.currentSettings bAnonymousData]];
    
    [self.currentSettings uAnonymous:bCurrent];
    [self.currentSettings writeToPlist];     // Save the changes
        
    [self setUpAnonymousButton:bCurrent];
}

- (void)setUpAnonymousButton:(BOOL)bOnOff {
    // Set the button image and title based on the status
    if (bOnOff) {
        img_anonymousOnOff.image = [UIImage imageNamed:@"exercise.png"];
        [buttonAnonymous setTitle:@"On" forState:UIControlStateNormal];
    } else {
        img_anonymousOnOff.image = [UIImage imageNamed:@"bg-on-1pxl.png"]; 
        [buttonAnonymous setTitle:@"Off" forState:UIControlStateNormal];
    }
}

// Send Feedback
- (IBAction)feedback_Clicked:(id)sender {	
    // Launch Email so the user can send feedback
	Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
	if (mailClass != nil)
	{
		// We must always check whether the current device is configured for sending emails
		if ([mailClass canSendMail])
		{
			[self displayComposerSheet];
		}
		else
		{
			[self shouldWeLaunchEmail];
		}
	}
	else
	{
		[self shouldWeLaunchEmail];
	}
}

// If the user doesn't already have email setup, give them a chance to not launch it
// (They will leave our App to configure the email)
-(void)shouldWeLaunchEmail {
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Email is Not Setup", @"")
                          message:NSLocalizedString(@"In order to send your feedback, Email needs to be setup on your device.\n\nDo you want to switch to the Email App to setup your email?", @"")
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                          otherButtonTitles:NSLocalizedString(@"Cancel", @""),nil];
    
    alert.tag = kTagSendFeedback;
    [alert show];
    [alert release];
}
#pragma mark Date Time Delegate
- (void)dateTimePickerOK:(DateTimePicker *)controller didPickDate:(NSDate *)date
{
    // User changed and saved the time...get it        
    // Grab the current settings file contents
    [self.currentSettings initPlist];
    
    if (controller.view.tag == kTagRemindAt) {
        // Reset the time to remind the user to update their scores
        [self.currentSettings uDateTimeDailyReminders:date];
        [self.currentSettings writeToPlist];     // Save the changes
        
        // Now cancel any existing notification (and activate the new one if notifications were already on)
        BOOL bCurrent = [self.currentSettings boolFromNumber:[self.currentSettings bDailyReminders]]; 
        [self scheduleNotification:bCurrent];
    }
    
    if (controller.view.tag == kTagResetScores) {
        // Reset the time that the daily scores will be reset
        [self.currentSettings uDateTimeScoresReset:date];
        [self.currentSettings uDateTimeLastReset:[NSDate date]];    // And remember when we did this!
        [self.currentSettings writeToPlist];     // Save the changes
        
        // We won't do anything else here...we will use the 1 minute timer we have elsewhere to see if we should reset the scores
    }
    
    
	[controller dismissModalViewControllerAnimated:YES];
    
    self.view = self.view;
    
}

- (void)dateTimePickerCancel:(DateTimePicker *)controller
{
	[controller dismissModalViewControllerAnimated:YES];
    self.view = self.view;
}

#pragma mark -
#pragma mark Compose Mail For Feedback

// Displays an email composition interface inside the application. Populates all the Mail fields. 
-(void)displayComposerSheet 
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:NSLocalizedString(@"Provider Resilience Feedback", @"")];
    [Analytics logEvent:[NSString stringWithFormat:@"EMAIL COMPOSE: %@",@"Provider Resilience Feedback"]];
	
    
	// Set up recipients
	NSArray *toRecipients = [NSArray arrayWithObject:@"mobileapplications@t2health.org"]; 
	//NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil]; 
	//NSArray *bccRecipients = [NSArray arrayWithObject:@"brian.doherty@tee2.org"]; 
	
	[picker setToRecipients:toRecipients];
	//[picker setCcRecipients:ccRecipients];	
	//[picker setBccRecipients:bccRecipients];
	
	// Attach the T2 Logo to the email
	//NSString *path = [[NSBundle mainBundle] pathForResource:@"T2_logo" ofType:@"png"];
    //NSData *myData = [NSData dataWithContentsOfFile:path];
	//[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"T2_logo"];
    
 
	// Fill out the email body text
    // Start out with some header information 
	NSMutableString *emailBody = [NSMutableString stringWithCapacity:1000];
    
    [emailBody appendString:@"<html><body style=""background-color:blue;""><p style=""font-family:arial;color:red;font-size:14px;"">We appreciate your comments.</p><p style=""font-family:arial;color:blue;font-size:14px;"">Please enter your feedback below:</p>"];

    
	[picker setMessageBody:emailBody isHTML:YES];
    
    picker.navigationBar.barStyle = UIBarStyleBlack;
    picker.navigationBarHidden = NO;
	
	[self presentModalViewController:picker animated:YES];
    [picker release];
}

#pragma mark Email delegate
// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{	
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
            NSLog(@"Mail compose:  Cancelled");
            //[Analytics logEvent:[NSString stringWithFormat:@"EMAIL COMPOSE: %@",@"Canceled"]];
			break;
		case MFMailComposeResultSaved:
            NSLog(@"Mail compose:  Saved");
            //[Analytics logEvent:[NSString stringWithFormat:@"EMAIL COMPOSE: %@",@"Saved"]];
			break;
		case MFMailComposeResultSent:
            NSLog(@"Mail compose:  Sent");
            //[Analytics logEvent:[NSString stringWithFormat:@"EMAIL COMPOSE: %@",@"Sent"]];
			break;
		case MFMailComposeResultFailed:
            NSLog(@"Mail compose:  Failed");
            //[Analytics logEvent:[NSString stringWithFormat:@"EMAIL COMPOSE: %@",@"Failed"]];
			break;
		default:
            NSLog(@"Mail compose:  Other?");
            //[Analytics logEvent:[NSString stringWithFormat:@"EMAIL COMPOSE: %@",@"Not Sent (?)"]];
			break;
	}
	[self dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark Utilities

// Launches the Mail application on the device.
-(void)launchMailAppOnDevice
{
	NSString *recipients = @"mailto:first@example.com?cc=second@example.com,third@example.com&subject=Hello from Seattle!";
	NSString *body = @"&body=It is raining in sunny Seattle!";
	
	NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}



@end
