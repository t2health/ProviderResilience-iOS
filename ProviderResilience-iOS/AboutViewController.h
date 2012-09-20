//
//  AboutViewController.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

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
