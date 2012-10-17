//
//  DateTimePicker.h
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
@class DateTimePicker;

@protocol DateTimePickerDelegate < NSObject >

- (void)dateTimePickerOK:(DateTimePicker *)controller didPickDate:(NSDate *)date;
- (void)dateTimePickerCancel:(DateTimePicker *)controller;

@end

#import <UIKit/UIKit.h>

@interface DateTimePicker : UIViewController 
{
    IBOutlet UIDatePicker *datePicker;
    id < DateTimePickerDelegate > delegate;
	NSDate *defaultDate;
    
    UIDatePickerMode ourMode;
}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, assign) id < DateTimePickerDelegate > delegate;
@property (nonatomic, retain) NSDate *defaultDate;

- (IBAction)savePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

- (void)resetDatePickerMode:(UIDatePickerMode)newMode;

@end
