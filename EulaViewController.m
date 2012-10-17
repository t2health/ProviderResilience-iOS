//
//  EulaViewController.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 6/21/12.
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
#import "EulaViewController.h"
#import "ProviderResilienceAppDelegate.h"
#import "Analytics.h"

@implementation EulaViewController

#pragma mark - Properties

@synthesize textView = textView_;

#pragma mark - Lifecycle


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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_image.png"]];
    
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Software License Agreement", @"");
    
    NSStringEncoding encoding;
    NSError *error;
    NSString *EULAPath = [[NSBundle mainBundle] pathForResource:@"EULA" ofType:@"txt"];  
    NSString *EULAText = [NSString stringWithContentsOfFile:EULAPath usedEncoding:&encoding error:&error];
    
    self.textView.text = EULAText;
}

- (void)viewDidUnload
{
    self.textView = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated  {
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [Analytics logEvent:@"EULA VIEW"];
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    //NSLog(@"EulaViewController Did Receive Memory Warning");
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


/**
 *  dealloc
 */
- (void)dealloc {
    [textView_ release];
    
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
#pragma mark - IBActions

/**
 *  handleAcceptedButtonTapped
 */
- (IBAction)handleAcceptedButtonTapped:(id)sender {
    [Analytics logEvent:@"EULA ACCEPTED"];
    
    // Application preference keys
    NSString *kEULAdone					= @"eulaDONE";
    // Indicate the user has agreed to the EULA
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"YES" forKey:kEULAdone];
    
    [defaults synchronize];
    
    // Refer back to the delegate to keep going with any start up stuff  
    ProviderResilienceAppDelegate *appDelegate = (ProviderResilienceAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate eulaStartUp];
}

/**
 *  handleDeclinedButtonTapped
 */
- (IBAction)handleDeclinedButtonTapped:(id)sender {
    /*
    NSString *alertTitle = NSLocalizedString(@"Quit Provider Resilience App?", @"");
    NSString *alertMessage = NSLocalizedString(@"Are you sure you want to quit Provider Resilience Application?", @"");
    NSString *okTitle = NSLocalizedString(@"YES", @"");
    NSString *cancelTitle = NSLocalizedString(@"NO", @"");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle 
                                                        message:alertMessage 
                                                       delegate:self 
                                              cancelButtonTitle:cancelTitle 
                                              otherButtonTitles:okTitle, nil];
    [alertView show];
    [alertView release];
     */
    
}

#pragma mark - UIAlertViewDelegate Methods

/**
 *  alertView:clickedButtonAtIndex
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // buttonIndex 0 is the Cancel button. buttonIndex 1 is the "Yes" button.
    if (buttonIndex == 1) {
        // Quit the application. Note that per Apple's own documentation, we aren't supposed to quit. 
        // http://developer.apple.com/library/ios/#qa/qa1561/_index.html
        
        [Analytics logEvent:@"EULA DECLINED"];
        
        // Exiting the main thread will quit the app, but it might cause App Store rejection.
        //exit(0);
    }
}


@end
