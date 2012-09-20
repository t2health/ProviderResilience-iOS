//
//  DateTimePicker.h
//

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
