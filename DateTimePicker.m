//
//  DateTimePicker.m
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
#import "DateTimePicker.h"

@implementation DateTimePicker

@synthesize datePicker, delegate, defaultDate;

- (IBAction)savePressed:(id)sender
{
	if (delegate && [delegate respondsToSelector:@selector(dateTimePickerOK:didPickDate:)]) 
	{
		[delegate dateTimePickerOK:self didPickDate:datePicker.date];
	}
}

- (IBAction)cancelPressed:(id)sender
{
    /*
    if (datePicker.datePickerMode == UIDatePickerModeDateAndTime)
        NSLog(@"Mode is Data and Time");
    if (datePicker.datePickerMode == UIDatePickerModeTime)
        NSLog(@"Mode Time Only");
     */
	if (delegate && [delegate respondsToSelector:@selector(dateTimePickerCancel:)]) 
	{
		[delegate dateTimePickerCancel:self];
	}
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	[datePicker setDate:defaultDate animated:YES];
    [datePicker setDatePickerMode:ourMode];             // Note...this must be set as part of initialization
}

- (void)resetDatePickerMode:(UIDatePickerMode)newMode {
     ourMode = newMode;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

- (void)dealloc 
{
	[datePicker release];
	[defaultDate release];
	
    [super dealloc];
}

@end
