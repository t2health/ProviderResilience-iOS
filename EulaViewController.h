//
//  EulaViewController.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 6/21/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EulaViewController : UIViewController <UIAlertViewDelegate> {
    IBOutlet UITextView *textView_;
}

// Properties
@property(nonatomic, retain) IBOutlet UITextView *textView;

// IBActions
- (IBAction)handleAcceptedButtonTapped:(id)sender;
- (IBAction)handleDeclinedButtonTapped:(id)sender;


@end
