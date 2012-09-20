//
//  DateTimePicker.m
//

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
