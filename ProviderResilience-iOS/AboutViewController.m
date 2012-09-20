//
//  AboutViewController.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "AboutViewController.h"
#import "ProviderResilienceAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface AboutViewController ()

@end

@implementation AboutViewController
@synthesize myWebView;
@synthesize buttonProceed;
@synthesize viewAbout;
@synthesize buttonAboutNext;

@synthesize viewHintDash;
@synthesize viewImageDash;
@synthesize buttonDashNext;
@synthesize buttonDashPrev;

@synthesize viewHintCards;
@synthesize viewImageCard;
@synthesize buttonCardNext;
@synthesize buttonCardPrev;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        bStartupMode = FALSE;           // Not in Startup Mode unless told so
    }
    return self;
}

- (void)viewDidLoad
{
    // Handle Swipe Gestures
    UISwipeGestureRecognizer *swipeLeft1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestures:)];
    [swipeLeft1 setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [self.viewAbout addGestureRecognizer:swipeLeft1];
    UISwipeGestureRecognizer *swipeLeft2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestures:)];
    [swipeLeft2 setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [self.viewHintDash addGestureRecognizer:swipeLeft2];
    UISwipeGestureRecognizer *swipeLeft3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestures:)];
    [swipeLeft3 setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [self.viewHintCards addGestureRecognizer:swipeLeft3];
    [swipeLeft1 release];
    [swipeLeft2 release];
    [swipeLeft3 release];
    
    UISwipeGestureRecognizer *swipeRight1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestures:)];
    [swipeRight1 setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [self.viewAbout addGestureRecognizer:swipeRight1];
    UISwipeGestureRecognizer *swipeRight2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestures:)];
    [swipeRight2 setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [self.viewHintDash addGestureRecognizer:swipeRight2];
    UISwipeGestureRecognizer *swipeRight3 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGestures:)];
    [swipeRight3 setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [self.viewHintCards addGestureRecognizer:swipeRight3];
    [swipeRight1 release];
    [swipeRight2 release];
    [swipeRight3 release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    myWebView.delegate = self;
    
    // Make the webview transparent
    myWebView.opaque = NO;
    myWebView.backgroundColor = [UIColor clearColor];
    myWebView.autoresizingMask = ~UIViewAutoresizingNone;
    self.view.autoresizingMask = ~UIViewAutoresizingNone;
    
    // Customize the Proceed button
    self.buttonProceed.layer.cornerRadius = 8;
    
    /*
    // If we are in Startup mode, then select a random card to display...and give ourselves a way out
    if (bStartupMode) {
        buttonProceed.enabled = YES;
        buttonProceed.hidden = NO;
    } else {
        buttonProceed.enabled = FALSE;
        buttonProceed.hidden = YES;
    }
    */
    // Always enable this
    buttonProceed.enabled = YES;
    buttonProceed.hidden = NO;
    
    // Adjust the position of some of the elements if we are not in Starup mode
    [self adjustPosition];
    
    
    // Load the content (depends on the device)
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
        [self loadHTML:@"About-iPad"];
    else
        [self loadHTML:@"About"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning
{
    //NSLog(@"AboutViewController Did Receive Memory Warning");
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated  {
    
    [Analytics logEvent:@"ABOUT VIEW"];
    [super viewWillAppear:animated];
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

- (void)dealloc {
    myWebView.delegate = nil;
    [super dealloc];
}
#pragma mark Startup Mode
// Indicate that we are in Startup Mode
- (IBAction)buttonProceed_Clicked:(id)sender {
    // Present the Help for the Dash
    self.view = self.viewHintDash;
}

- (IBAction)buttonHintDash_Clicked:(id)sender {
    // Present the Help for the Cards
    self.view = self.viewHintCards;
}

- (IBAction)buttonHintCards_Clicked:(id)sender{
    
    // Refer back to the delegate to keep going with the normal stuff 
    // We are not in startup mode anymore
    bStartupMode = FALSE;
    // Adjust the position of the elements to account for the tabbar (which is not there in startup mode
    [self adjustPosition];
    
    
    ProviderResilienceAppDelegate *appDelegate = (ProviderResilienceAppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate normalStartUp];
}

- (void)adjustPosition {
    if (!bStartupMode) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            // About view
            CGRect myFrame = self.buttonAboutNext.frame;
            self.buttonAboutNext.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-48, myFrame.size.width, myFrame.size.height);
            
            // Dash view
            myFrame = self.buttonDashNext.frame;
            self.buttonDashNext.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            myFrame = self.buttonDashPrev.frame;
            self.buttonDashPrev.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            myFrame = self.viewImageDash.frame;
            self.viewImageDash.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            
            // Card view
            self.buttonCardNext.hidden = YES;           // Leave the code here to adjust it, but hide it because we don't need it
            myFrame = self.buttonCardNext.frame;        // AND if we leave it visible to tap, then these adjustments will get applied again!
            self.buttonCardNext.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            
            myFrame = self.buttonCardPrev.frame;
            self.buttonCardPrev.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            myFrame = self.viewImageCard.frame;
            self.viewImageCard.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            
        } else {
            // iPad adjustments
            // About view
            CGRect myFrame = self.buttonAboutNext.frame;
            self.buttonAboutNext.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            
            // Dash view
            myFrame = self.buttonDashNext.frame;
            self.buttonDashNext.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            myFrame = self.buttonDashPrev.frame;
            self.buttonDashPrev.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            myFrame = self.viewImageDash.frame;
            self.viewImageDash.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            
            // Card view
            self.buttonCardNext.hidden = YES;           // Leave the code here to adjust it, but hide it because we don't need it
            myFrame = self.buttonCardNext.frame;        // AND if we leave it visible to tap, then these adjustments will get applied again!
            self.buttonCardNext.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            
            myFrame = self.buttonCardPrev.frame;
            self.buttonCardPrev.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
            myFrame = self.viewImageCard.frame;
            self.viewImageCard.frame  = CGRectMake(myFrame.origin.x, myFrame.origin.y-45, myFrame.size.width, myFrame.size.height);
        }   
    }
}

-(void)StartupMode {
    bStartupMode = TRUE;
}

// Back to the About view
- (IBAction)buttonAbout_Clicked:(id)sender {
    self.view = self.viewAbout;    
}

- (void)loadHTML:(NSString *)fileName{
    
    // Now test if this file exists (in the Main Bundle)
    NSString *fooFile = [[NSBundle mainBundle] pathForResource:fileName ofType:@"htm"];
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:fooFile];
    
    if (!fileExists)
    {
        // Log the error
        
        // File does not exist...display a default htm file that will tell the user about the error
        fileName = @"MissingFile";
    }
    
    NSString *htmPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"htm"];
    NSURL *htmURL = [NSURL fileURLWithPath:htmPath];
    NSURLRequest *URLReq = [NSURLRequest requestWithURL:htmURL];
      
    [myWebView loadRequest:URLReq];   
    
}
#pragma mark Gestures

// Move through the Array of Virtue Cards (based on the swipe gesture from the user)
-(void)handleSwipeGestures:(UISwipeGestureRecognizer *)recognizer {
    
    // We check if we are in start up mode (determines how we can exit)
   // if (!bStartupMode) {
        // Swipe Right...we want to go BACK a view
        if (recognizer.direction & UISwipeGestureRecognizerDirectionRight) { 
            if (self.view == self.viewHintDash)
                self.view = self.viewAbout;
            if (self.view == self.viewHintCards)
                self.view = self.viewHintDash;
        }
        
        // Swipe Left...we want to go FORWARD a view
        if (recognizer.direction & UISwipeGestureRecognizerDirectionLeft) { 
            if (self.view == self.viewHintDash)
                self.view = self.viewHintCards;
            if (self.view == self.viewAbout)
                self.view = self.viewHintDash;
        }
 
    //}

    
}

@end
