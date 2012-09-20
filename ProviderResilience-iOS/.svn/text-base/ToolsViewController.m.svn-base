//
//  ToolsViewController.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "ToolsViewController.h"
#import "DashboardViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RSSEntry.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"
#import "ViewBCVideoController.h"
#import "ProviderResilienceAppDelegate.h"

@interface ToolsViewController ()

@end

@implementation ToolsViewController
@synthesize viewToolsMenu;
@synthesize viewExercise;
@synthesize viewVideos;
@synthesize viewScrollVideos;
@synthesize viewRemindVideos;
@synthesize viewRemindScrollVideos;
@synthesize viewProQOLGraph;
@synthesize stretchCards;
@synthesize videoButton;
@synthesize physicalButton;
@synthesize remindButton;
@synthesize laughButton;
@synthesize viewRSSFeed;
@synthesize webView;
@synthesize proqolButton;
@synthesize viewProQOLHelper;
@synthesize graphButton;
@synthesize burnoutButton;
@synthesize allEntries = _allEntries;
@synthesize receivedData;
@synthesize prevButton_Dilbert;
@synthesize nextButton_Dilbert;
@synthesize nameDateDiblert;
@synthesize dilbertActivityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark View Life Cycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setVideoButton:nil];
    [self setPhysicalButton:nil];
    [self setRemindButton:nil];
    [self setLaughButton:nil];
    [self setProqolButton:nil];
    [self setGraphButton:nil];
    [self setBurnoutButton:nil];
    [self setViewToolsMenu:nil];
    [self setViewExercise:nil];
    [viewStretchCard release];
    viewStretchCard = nil;
    [stretchCards release];
    stretchCards = nil;
    
    [self setViewProQOLHelper:nil];
    [self setWebView:nil];
    [self setViewRSSFeed:nil];
    [self setPrevButton_Dilbert:nil];
    [self setNextButton_Dilbert:nil];
    [self setNameDateDiblert:nil];
    [self setDilbertActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)viewWillAppear:(BOOL)animated  {
    
    [Analytics logEvent:@"TOOLS"];
    self.view = self.viewToolsMenu;
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)dealloc {
    [videoButton release];
    [physicalButton release];
    [remindButton release];
    [laughButton release];
    [proqolButton release];
    [graphButton release];
    [burnoutButton release];
    [viewToolsMenu release];
    [viewExercise release];
    [viewStretchCard release];
    [stretchCards release];
    [viewProQOLHelper release];
    [webView release];
    [viewRSSFeed release];
    [prevButton_Dilbert release];
    [nextButton_Dilbert release];
    [nameDateDiblert release];
    [dilbertActivityIndicator release];
    [super dealloc];
}

#pragma mark Video buttons
// Clicked when the user selects the video menu
- (IBAction)videoButton_Clicked:(id)sender {
    
    [Analytics logEvent:@"VIDEOS"];
    // First make sure the content size is set (for scrolling)
    [self.viewScrollVideos setContentSize:CGSizeMake(self.view.frame.size.width, 300.0f)]; 
    
    [self scoreFunStuff];           // Give the user 'credit' for doing something fun/healthy
       
    videoReturn = 0;                // Remember to come back here after displaying the video!
    self.view = self.viewVideos;
}

- (IBAction)videoSelection_Clicked:(id)sender {
    // Select the video to play (identified by the tag value)
    UIButton *ourButton = (UIButton *)sender;
    long long videoID;
    NSString *videoName = [NSString stringWithFormat:@"alcohol"];
    NSString *videoKey = [NSString stringWithFormat:@"apikey2"];
    
    switch (ourButton.tag) {
        case 1:
            [Analytics logEvent:@"VIDEO ALCOHOL"];
            videoName = [NSString stringWithFormat:@"alcohol"];
            videoKey = [NSString stringWithFormat:@"apikey2"];
            break;
            
        case 2:
            [Analytics logEvent:@"VIDEO ANGER"];
            videoName = [NSString stringWithFormat:@"anger"];
            videoKey = [NSString stringWithFormat:@"apikey2"];
            break;
            
        case 3:
            [Analytics logEvent:@"VIDEO COMPASSION"];
            videoName = [NSString stringWithFormat:@"compassion"];
            videoKey = [NSString stringWithFormat:@"apikey1"];
            break;
            
        case 4:
            [Analytics logEvent:@"VIDEO DEPRESSION"];
            videoName = [NSString stringWithFormat:@"depression"];
            videoKey = [NSString stringWithFormat:@"apikey2"];
            break;
            
        case 5:
            [Analytics logEvent:@"VIDEO STIGMA"];
            videoName = [NSString stringWithFormat:@"stigma"];
            videoKey = [NSString stringWithFormat:@"apikey2"];
            break;
            
        case 6:
            [Analytics logEvent:@"VIDEO TRAUMA"];
            videoName = [NSString stringWithFormat:@"trauma"];
            videoKey = [NSString stringWithFormat:@"apikey1"];
            break;
            
        case 7:
            [Analytics logEvent:@"VIDEO DEPRESSION SUPPORT"];
            videoName = [NSString stringWithFormat:@"depression2"];
            videoKey = [NSString stringWithFormat:@"apikey2"];
            break;
            
        default:
            break;
    }
    
    // Now get the Video ID and the Video Key
    ProviderResilienceAppDelegate *appDelegate = (ProviderResilienceAppDelegate *)[[UIApplication sharedApplication] delegate];
    videoID = [[appDelegate getAppSetting:@"Brightcove" withKey:videoName] longLongValue];
    
    // And make sure we have the correct API key
    [appDelegate resetBCConnection:videoKey];
    
    NSString *controllerBundle;
    controllerBundle = @"ViewBCVideoController";
    
    ViewBCVideoController *anotherController2 = [[ViewBCVideoController alloc] initWithNibName:controllerBundle bundle:nil];
    
    anotherController2.videoID = videoID;
    anotherController2.delegate = self;
    
	[self presentModalViewController:anotherController2 animated:YES];
    //[anotherController2 release];
}

#pragma mark View BC delegate
- (void)dismissViewBC:(ViewBCVideoController *)controller {
    // The video finished...return to menu
	[controller dismissModalViewControllerAnimated:YES];
    
    // Where do we go from here...depends on who called us to begin with
    if (videoReturn == 0) self.view = self.viewVideos;
    else self.view = self.viewRemindVideos;
}

#pragma mark Scoring
-(void)scoreFunStuff{
    
    // Give then credit for doing a fun activity today
    SaveSettings *currentSettings = [[SaveSettings alloc] init];
    [currentSettings initPlist];
    NSInteger myScore = [currentSettings.nScoreFunStuff integerValue]; 
    myScore++;  
    [currentSettings uScoreFunStuff:&myScore];
     
    [currentSettings writeToPlist];
    [currentSettings release];
}


#pragma mark Physical Exercise
// View the Stretch cards
- (IBAction)physicalButton_Clicked:(id)sender {
    [Analytics logEvent:@"PHYSICAL EXERCISE"];
    self.view = self.viewExercise;
    
    // Handle Swipe Gestures for these Stretch/Exercise cards
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesturesStretch:)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft )];
    [self.view addGestureRecognizer:swipeLeft];
    [swipeLeft release];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeGesturesStretch:)];
    [swipeRight setDirection:(UISwipeGestureRecognizerDirectionRight )];
    [self.view addGestureRecognizer:swipeRight];
    [swipeRight release];
    
    // Get the cards
    stretchCards = [VirtueCardDeck alloc];
    stretchCards.pListFileName = [NSString stringWithFormat:@"StretchCards"];
    [stretchCards initPlist];
    
    // Display the currently selected Virtue Card
    NSBundle* myBundle = [NSBundle mainBundle];
    NSString* myImage = [myBundle pathForResource:[stretchCards fileForStretch:[[stretchCards CurrentVirtue] intValue]] ofType:@"png"];
    //NSLog(@"Image name: %@",myImage);
    viewStretchCard.image = [UIImage imageWithContentsOfFile:myImage];
    
}

#pragma mark Gestures Stretch

// Move through the Array of Stretch Cards (based on the swipe gesture from the user)
-(void)handleSwipeGesturesStretch:(UISwipeGestureRecognizer *)recognizer {

    // Swipe Right...we want to go BACK a card
    if (recognizer.direction & UISwipeGestureRecognizerDirectionRight) { 
        [stretchCards getPrevVirtue];
    }

    // Swipe Left...we want to go FORWARD a card
    if (recognizer.direction & UISwipeGestureRecognizerDirectionLeft) { 
        [stretchCards getNextVirtue];
    }

    // Select the new Virtue Card
    NSBundle* myBundle = [NSBundle mainBundle];
    NSString* myImage = [myBundle pathForResource:[stretchCards fileForStretch:[[stretchCards CurrentVirtue] intValue]] ofType:@"png"];
    //NSLog(@"Image name: %@",myImage);
    viewStretchCard.image = [UIImage imageWithContentsOfFile:myImage];

    // Dynamically resize elements (if needed)
    //NSLog(@"label: %@",labelTitle.text);
    //NSLog(@"copyRight: %@",labelCopyright.text);
    //NSLog(@"Image Size: w: %0.2f h: %0.2f",viewVirtueCard.frame.size.height,viewVirtueCard.frame.size.width);

    CATransition *transition = [CATransition animation];
    transition.duration = 0.5f;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    // Swipe Left...push the Next Card in
    if (recognizer.direction & UISwipeGestureRecognizerDirectionLeft) {
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
    }

    // Swipe Right...push the Previous Card in
    if (recognizer.direction & UISwipeGestureRecognizerDirectionRight) {
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
    }

    // Swipe Up or Down...fade between the Front and Back of the card
    if (recognizer.direction & (UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown)) {        
        transition.type = kCATransitionFade;
    }

    [viewStretchCard.layer addAnimation:transition forKey:nil];
}

- (IBAction)remindButton_Clicked:(id)sender {
    [Analytics logEvent:@"REMIND ME"];
    // Give them credit for doing something fun today
    [self scoreFunStuff];
    
    // First make sure the content size is set (for scrolling)
    [self.viewRemindScrollVideos setContentSize:CGSizeMake(self.view.frame.size.width, 500.0f)]; 
    
    videoReturn = 1;                        // Remember to come back here after the video!
    self.view = self.viewRemindVideos;
    

}

#pragma mark Dilbert RSS Feed

- (IBAction)laughButton_Clicked:(id)sender {
    [Analytics logEvent:@"I NEED A LAUGH"];
    // Give them credit for doing something fun today
    [self scoreFunStuff];
    
    self.view = self.viewRSSFeed;
    
    // Don't temp the users with the buttons until we have something for them:-)
    [self.prevButton_Dilbert setEnabled:NO];
    [self.nextButton_Dilbert setEnabled:NO];
    
#ifdef bgd
    // Clear the credential cache
    NSDictionary *credentialsDict = [[NSURLCredentialStorage sharedCredentialStorage] allCredentials];
    
    if ([credentialsDict count] > 0) {
        // the credentialsDict has NSURLProtectionSpace objs as keys and dicts of userName => NSURLCredential
        NSEnumerator *protectionSpaceEnumerator = [credentialsDict keyEnumerator];
        id urlProtectionSpace;
        
        // iterate over all NSURLProtectionSpaces
        while (urlProtectionSpace = [protectionSpaceEnumerator nextObject]) {
            NSEnumerator *userNameEnumerator = [[credentialsDict objectForKey:urlProtectionSpace] keyEnumerator];
            id userName;
            
            // iterate over all usernames for this protectionspace, which are the keys for the actual NSURLCredentials
            while (userName = [userNameEnumerator nextObject]) {
                NSURLCredential *cred = [[credentialsDict objectForKey:urlProtectionSpace] objectForKey:userName];
                [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:cred forProtectionSpace:urlProtectionSpace];
            }
        }
    }
    #endif
    
    // Show a message while we retrieve the data
    NSString *htmPath = [[NSBundle mainBundle] pathForResource:@"NetworkWait" ofType:@"htm"];
    NSURL *htmURL = [NSURL fileURLWithPath:htmPath];
    NSURLRequest *URLReq = [NSURLRequest requestWithURL:htmURL];
    
    // And start the activity indicator
    dilbertActivityIndicator.hidesWhenStopped = YES;
    [dilbertActivityIndicator startAnimating];
    
    [webView setDelegate:self];              // Track the completion of web page loading
    [webView loadRequest:URLReq];
    
    
    // Populate the array of RSS Feed(s)  
    self.allEntries = [NSMutableArray array]; 
    
    // RSS from Feedmill  
    NSURL *url = [NSURL URLWithString:@"https://feedsservice.amuniversal.com/feeds/feature/dt.rss"]; 
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    NSURLConnection *myConnection = [[[NSURLConnection alloc] initWithRequest:request delegate:self] autorelease];
    
    if (myConnection) {
        //NSLog(@"Connection established to: %@",url);
        // Allocate the buffer to collect the data here as it arrives
        receivedData = [[NSMutableData data] retain];
    } else {
        NSLog(@"Connection Error...provide a way to gracefully exit from here!");
        //
        //NSString *errorIdentifier = [NSString stringWithFormat:@"(%@)[%d]",error.domain,error.code];
        //NSLog(@"%@",errorIdentifier);
        //NSLog(@"Error User Info: %@",error.userInfo);
         
    }
    
}
#pragma mark NSURL Connection Delegate
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    /*return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
     if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        NSLog(@"authentication method is TRUE");
    else NSLog(@"authentication method is FALSE");
    
    NSLog(@"Authenticate against any server");
     */
    return (YES);
     
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    //if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    //    if ([trustedHosts containsObject:challenge.protectionSpace.host])
    //        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    
    // Answer the challenge
    //NSLog(@"Answer the Authentication Challenge");
    NSURLCredential *cred = [[[NSURLCredential alloc] initWithUser:@"nct_feeds" password:@"!nctele" persistence:NSURLCredentialPersistenceForSession] autorelease];
    //NSLog(@"cred u: %@ pw: %@",[cred user],[cred password]);
    [[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
    
    //[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}
#pragma mark NSURL connection methods
/*---------------------------------------------------------------------------
 * Received a server challenge
 *--------------------------------------------------------------------------*/
// Respond to the server's request for credentials
// Note:  This message comes before the actual request...so we can cancel OR respond with credentials
- (void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    //NSLog(@"******************************************************************************");
    //NSLog(@"willSendRequestForAuthenticationChallenge entered");
    //NSLog(@"challenge: prev Error count %d",[challenge previousFailureCount]);
    //NSLog(@"challenge error: %@",[challenge error]);
    // 08/06/12 Don't log these...they are 'normal' and will be handled below
    /*
    if ([challenge failureResponse]  != nil) {
        NSHTTPURLResponse *pResponse = (NSHTTPURLResponse *)[challenge failureResponse];
        NSLog(@"Failure Response: %@",pResponse);
        NSLog(@"FR URL: %@",pResponse.URL);
        //NSLog(@"FR Expected Length: %@",pResponse.expectedContentLength);
        NSLog(@"FR suggestedFilename: %@",pResponse.suggestedFilename);
        NSLog(@"FR MIMEType: %@",pResponse.MIMEType);
        NSLog(@"FR textEncodingName: %@",pResponse.textEncodingName);
        NSLog(@"FR statusCode: %d",pResponse.statusCode);
        NSLog(@"FR Headers: %@",pResponse.allHeaderFields);
        NSLog(@"FR explain: %@",[NSHTTPURLResponse localizedStringForStatusCode:pResponse.statusCode]);
    }
    */
    
    //NSLog(@"challenge sender: %@",[challenge sender]);
    //NSLog(@"challenge proposed credential: %@",[challenge proposedCredential]);
    
    // Access has failed multiple times...
    if ([challenge previousFailureCount] > 3)
    {
        //[urlConnection release];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Error"
                                                        message:@"Too many unsuccessul login attempts." 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }
    else 
    {
        // Answer the challenge
        //NSLog(@"Answer the Authentication Challenge");
       NSURLCredential *cred = [[[NSURLCredential alloc] initWithUser:@"nct_feeds" password:@"!nctele" persistence:NSURLCredentialPersistenceForSession] autorelease];
        //NSLog(@"cred u: %@ pw: %@",[cred user],[cred password]);
        [[challenge sender] useCredential:cred forAuthenticationChallenge:challenge];
    }
    
    
    //NSLog(@"******************************************************************************");
}

- (void)useCredential:(NSURLCredential *)credential forAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    //NSLog(@"useCredential forAuthenticationChallenge");
}

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection {
    //NSLog(@"connectionShouldUseCredentialStorage");
    
    return NO;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
   // NSLog(@"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO didReceiveResponse: %@",response);
   // NSLog(@"response URL: %@",response.URL);
    
    if (response  != nil) {
        NSHTTPURLResponse *pResponse = (NSHTTPURLResponse *)response;
        //NSLog(@"Response: %@",pResponse);
        //NSLog(@"res URL: %@",pResponse.URL);
        //NSLog(@"FR Expected Length: %@",pResponse.expectedContentLength);
        //NSLog(@"ressuggestedFilename: %@",pResponse.suggestedFilename);
        //NSLog(@"res MIMEType: %@",pResponse.MIMEType);
        //NSLog(@"res textEncodingName: %@",pResponse.textEncodingName);
        NSLog(@"res statusCode: %d",pResponse.statusCode);
        //NSLog(@"res Headers: %@",pResponse.allHeaderFields);
        //NSLog(@"res explain: %@",[NSHTTPURLResponse localizedStringForStatusCode:pResponse.statusCode]);
    }
    
    // Reset our received data...we will be starting over 
    [receivedData setLength:0];
    //NSLog(@"OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO");
    
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    //NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   didReceiveData: %@",data);
    // Accumulate our data here
    [receivedData appendData:data];
    //NSLog(@"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    
    
    NSString *errorIdentifier = [NSString stringWithFormat:@"(%@)[%d]",error.domain,error.code];
    NSLog(@"Connection Error User Info: %@",error.userInfo);
    NSLog(@"Connection Error %@",errorIdentifier);
    
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    
    //[urlConnection release];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                    message:[error localizedDescription]
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    [alert release];
    
    // We are done...clean up
    //[connection release];
    //connection = nil;
    //[receivedData release];
    //receivedData = nil;
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    //NSLog(@"didFinishLoading");
    NSError *error = nil;
    // Write out the file (so we can study it!)
   NSString *cachesFolder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
   NSString *file = [cachesFolder stringByAppendingPathComponent:@"dilbertXMLfile"]; 
    
    // IMPORTANT...the data stream has an error....at least our parser doesn't like it!
    // There are carriage returns and blanks before the first XML statement (starts with '<')
    // So, remove these before parsing the file
    unsigned char testBuffer[3];       // Plenty long enough to test one char a a time
    [receivedData getBytes:testBuffer length:1];
    while (testBuffer[0] != '<') {
        [receivedData replaceBytesInRange:NSMakeRange(0, 1) withBytes:NULL length:0];
        [receivedData getBytes:testBuffer length:1];
    }
    
    [receivedData writeToFile:file options:NSDataWritingAtomic error:nil];  // Now save the file while we are still testing
    
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:receivedData
                                                           options:0 error:&error];
                                 
    if (doc == nil) { 
        NSLog(@"Failed to parse the URL data");
        NSString *errorIdentifier = [NSString stringWithFormat:@"(%@)[%d]",error.domain,error.code];
        NSLog(@"error id: %@",errorIdentifier);
        
        NSString *htmPath = [[NSBundle mainBundle] pathForResource:@"NetworkError" ofType:@"htm"];
        NSURL *htmURL = [NSURL fileURLWithPath:htmPath];
        NSURLRequest *URLReq = [NSURLRequest requestWithURL:htmURL];
        
        [webView loadRequest:URLReq]; 
    } else {
        
        [self.prevButton_Dilbert setEnabled:YES];
        [self.nextButton_Dilbert setEnabled:YES];
        
        [self parseFeed:doc.rootElement entries:[self allEntries]];    
        //NSLog(@"# of entries: %d",[self.allEntries count]);
        
        if ([self.allEntries count] >0) {
            // Load the first URL from this article
            nCurrentEntry = 0;                  
            NSURL *urlRSS = [NSURL URLWithString:[[self.allEntries objectAtIndex:nCurrentEntry] articleUrl]]; 
            nameDateDiblert.text = [[self.allEntries objectAtIndex:nCurrentEntry] articleTitle]; 
            
            //NSLog(@"min/max zoomscale: %f/%f",webView.scrollView.minimumZoomScale,webView.scrollView.maximumZoomScale);
            [webView loadRequest:[NSURLRequest requestWithURL:urlRSS]];
            [dilbertActivityIndicator startAnimating];
        }
        
        // Disable the Next Day button (we are at the beginning...which represents the most current day)
        [self.nextButton_Dilbert setEnabled:NO];
        
        // And if there is only one entry...go ahead and disable both buttons...we won't need them
        if ([self.allEntries count] == 1) {
            [self.prevButton_Dilbert setEnabled:NO];
            [self.nextButton_Dilbert setEnabled:NO];
        }
    } 
    [doc release];
    
    // Stop the activity indicator
    [dilbertActivityIndicator stopAnimating];
    
    // Release the connection and data
    //[connection release];
}

#pragma mark Web Page Delegates
- (void)webViewDidFinishLoad:(UIWebView *)wView {
    // Adjust the size
    if ([UIWebView instancesRespondToSelector:@selector(scrollView)]) {
        CGRect zoomRect = CGRectMake(0, 0, 110, 100);
        UIScrollView *myScrollView = wView.scrollView;
        [myScrollView zoomToRect:zoomRect animated:YES];
    } else {
        for (UIView *subview in webView.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]]) {
                CGRect zoomRect = CGRectMake(0, 0, 110, 100);
                [((UIScrollView *)subview)  zoomToRect:zoomRect animated:YES];
            }
        }
    }
    [dilbertActivityIndicator stopAnimating];
}

#pragma mark Dilbert next-previous
// Get the previous entry
- (IBAction)prevDilbert:(id)sender {
   // NSLog(@"Prev Day entry:  cnt: %d  size: %d",nCurrentEntry,[self.allEntries count]);
    // We know we can go back one day...or the button the got us here would have been disabled
    // NOTE:  Going back one day means we go forward in the array (higher index!)
    nCurrentEntry++;                  
    if (nCurrentEntry >= [self.allEntries count]-1)
        [self.prevButton_Dilbert setEnabled:NO];
    
    // Enable Previous Day button if we can go that way
    if (nCurrentEntry > 0)
        [self.nextButton_Dilbert setEnabled:YES];
       
    //NSLog(@"Prev Day exit:  cnt: %d  size: %d",nCurrentEntry,[self.allEntries count]);
    [dilbertActivityIndicator startAnimating];
    NSURL *urlRSS = [NSURL URLWithString:[[self.allEntries  objectAtIndex:nCurrentEntry] articleUrl]];   
    nameDateDiblert.text = [[self.allEntries objectAtIndex:nCurrentEntry] articleTitle]; 
    //NSLog(@"prev url: %@",urlRSS);
    [webView loadRequest:[NSURLRequest requestWithURL:urlRSS]];
}

// Get the next entry
- (IBAction)nextDilbert:(id)sender {
    //NSLog(@"Next Day entry:  cnt: %d  size: %d",nCurrentEntry,[self.allEntries count]);
    // We know we can go forward one day...or the button the got us here would have been disabled
    // NOTE:  Going forward one day means we go backward in the array (lower index!)
    nCurrentEntry--;                  
    if (nCurrentEntry == 0)
        [self.nextButton_Dilbert setEnabled:NO];
    
    // Enable Next Day button if we can go that way
    if (nCurrentEntry < [self.allEntries count]-1)
        [self.prevButton_Dilbert setEnabled:YES];

    //NSLog(@"Next Day exit:  cnt: %d  size: %d",nCurrentEntry,[self.allEntries count]);
    [dilbertActivityIndicator startAnimating];
    NSURL *urlRSS = [NSURL URLWithString:[[self.allEntries  objectAtIndex:nCurrentEntry] articleUrl]];   
    nameDateDiblert.text = [[self.allEntries objectAtIndex:nCurrentEntry] articleTitle]; 
    //NSLog(@"next url: %@",urlRSS);
    [webView loadRequest:[NSURLRequest requestWithURL:urlRSS]];
}

- (void)parseFeed:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {   
    //NSLog(@"parseFeed rootElement.name: %@",rootElement.name);
    if ([rootElement.name compare:@"rss"] == NSOrderedSame) {
        [self parseRss:rootElement entries:entries];
    } else if ([rootElement.name compare:@"feed"] == NSOrderedSame) {                       
        [self parseAtom:rootElement entries:entries];
    } else {
        NSLog(@"Unsupported root element: %@", rootElement.name);
    }    
}
- (void)parseRss:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSArray *channels = [rootElement elementsForName:@"channel"];
    for (GDataXMLElement *channel in channels) {            
        
        // Capture the name of this channel
        NSString *blogTitle = [channel valueForChild:@"title"];     
        //NSLog(@"Title: %@",blogTitle);
        
        // Now look at each item in this channel
        NSArray *items = [channel elementsForName:@"item"];
        for (GDataXMLElement *item in items) {
            
            // Grab the title and publication date
            NSString *articleTitle = [item valueForChild:@"title"];          
            NSString *articleDateString = [item valueForChild:@"pubDate"];
            
            // The URL we want is buried in the assets (which is in description)
            // In fact, it is in the last asset....
            // So we will just loop through them all and retain the last one
            NSString *articleURL;
            /*
            NSArray *descs = [item elementsForName:@"description"];
            for (GDataXMLElement *desc in descs) {
                NSArray *assets = [desc elementsForName:@"asset"];
                for (GDataXMLElement *asset in assets) {
                    articleURL = [asset valueForChild:@"image_link"];
                }
            }
             */
            
            NSArray *descs = [item elementsForName:@"description"];
            BOOL bFoundIt = NO;
            for (GDataXMLElement *desc in descs) {
                NSArray *assets = [desc elementsForName:@"asset"];
                for (GDataXMLElement *asset in assets) {
                    // Use the 'mutable' asset
                    if ([[asset valueForChild:@"asset_type"] compare:@"mutable"] == NSOrderedSame) {
                        articleURL = [asset valueForChild:@"image_link"];
                        bFoundIt = YES;
                        break;              // Quit when we find what we are looking for
                    }
                }
                if (bFoundIt) break;   // And out of this loop also
            }
            
            //NSLog(@"Title: %@ Date: %@ URL: %@",articleTitle,articleDateString,articleURL);
            
            RSSEntry *entry = [[[RSSEntry alloc] initWithBlogTitle:blogTitle 
                                                      articleTitle:articleTitle 
                                                        articleUrl:articleURL 
                                                       articleDate:articleDateString] autorelease];
            [entries addObject:entry];
            
        }      
    }
    
}

- (void)parseAtom:(GDataXMLElement *)rootElement entries:(NSMutableArray *)entries {
    
    NSString *blogTitle = [rootElement valueForChild:@"title"];                    
    
    NSArray *items = [rootElement elementsForName:@"entry"];
    for (GDataXMLElement *item in items) {
        
        NSString *articleTitle = [item valueForChild:@"title"];
        NSString *articleUrl = nil;
        NSArray *links = [item elementsForName:@"link"];        
        for(GDataXMLElement *link in links) {
            NSString *rel = [[link attributeForName:@"rel"] stringValue];
            NSString *type = [[link attributeForName:@"type"] stringValue]; 
            if ([rel compare:@"alternate"] == NSOrderedSame && 
                [type compare:@"text/html"] == NSOrderedSame) {
                articleUrl = [[link attributeForName:@"href"] stringValue];
            }
        }
        
        NSString *articleDateString = [item valueForChild:@"updated"];   
        
        RSSEntry *entry = [[[RSSEntry alloc] initWithBlogTitle:blogTitle 
                                                  articleTitle:articleTitle 
                                                    articleUrl:articleUrl 
                                                   articleDate:articleDateString] autorelease];
        [entries addObject:entry];
        
    }      
    
}
// Add the RSS Feed to our array

- (void)addRows {    
    RSSEntry *entry1 = [[[RSSEntry alloc] initWithBlogTitle:@"1" 
                                               articleTitle:@"1" 
                                                 articleUrl:@"1" 
                                                articleDate:[NSDate date]] autorelease];
    /*
    RSSEntry *entry2 = [[[RSSEntry alloc] initWithBlogTitle:@"2" 
                                               articleTitle:@"2" 
                                                 articleUrl:@"2" 
                                                articleDate:[NSDate date]] autorelease];
    RSSEntry *entry3 = [[[RSSEntry alloc] initWithBlogTitle:@"3" 
                                               articleTitle:@"3" 
                                                 articleUrl:@"3" 
                                                articleDate:[NSDate date]] autorelease];    
    */
    
    [self.allEntries insertObject:entry1 atIndex:0];
    //[_allEntries insertObject:entry2 atIndex:0];
    //[_allEntries insertObject:entry3 atIndex:0];        
}


#pragma mark ProQOL Helper Pocket Card
- (IBAction)proqolButton_Clicked:(id)sender {
    self.view = self.viewProQOLHelper;
}

#pragma mark ProQOL Graph
- (IBAction) graphButton_Clicked:(id)sender {
    [Analytics logEvent:@"PROQOL GRAPH"];
    [self createQOLChart];
    self.view = self.viewProQOLGraph;
    [qolDatasource reReadData];
    [qolChart reloadData];
    [qolChart redrawChartAndGL:YES];
}

- (void)createQOLChart {
    
    //Create the chart (if needed)
    if (qolChart == nil) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)  
            qolChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 95, 768,910)];  // iPad
        else
            qolChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 55, 320,390)];  // iPhone
        
        // Set a different theme on the chart
        SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
        [qolChart setTheme:midnight];
        [midnight release];
        
        //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
        qolChart.autoresizingMask = ~UIViewAutoresizingNone;
        
        // Initialise the data source we will use for the chart
        qolDatasource = [[LineChartDataSource alloc] initWithFileName:LineChartSource_ProQOL seriesCount:3];
        
        // Give the chart the data source
        qolChart.datasource = qolDatasource;
        [qolDatasource release];
        
        // Create a date time axis to use as the x axis.    
        SChartDateTimeAxis *xAxis = [[SChartDateTimeAxis alloc] init];
        
        // Enable panning and zooming on the x-axis.
        xAxis.enableGesturePanning = YES;
        xAxis.enableGestureZooming = YES;
        xAxis.enableMomentumPanning = YES;
        xAxis.enableMomentumZooming = YES;
        xAxis.axisPositionValue = [NSNumber numberWithInt: 0];
        
        // And allow them to scroll past the default range
        xAxis.allowPanningOutOfMaxRange = YES;
        xAxis.allowPanningOutOfDefaultRange = YES;
        
        // Make the frequency of tick marks be one day
        SChartDateFrequency *freq = [[SChartDateFrequency alloc] initWithDay:1];
        xAxis.majorTickFrequency = freq;
        
        qolChart.xAxis = xAxis;
        [xAxis release];
        
        //Create a number axis to use as the y axis.
        NSNumber *lowRange = [[NSNumber alloc] initWithInteger:0];
        NSNumber *highRange = [[NSNumber alloc] initWithInteger:50];
        
        SChartNumberRange *yRange = [[SChartNumberRange alloc] initWithMinimum:lowRange andMaximum:highRange];
        SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] initWithRange:yRange ];
        
        //Enable panning and zooming on Y
        yAxis.enableGesturePanning = NO;
        yAxis.enableGestureZooming = NO;
        yAxis.enableMomentumPanning = NO;
        yAxis.enableMomentumZooming = NO;
        
        //[yAxis setRangeWithMinimum:[NSNumber numberWithDouble: 0.0] andMaximum:[NSNumber numberWithDouble: 100.0] withAnimation:NO];
        
        qolChart.yAxis = yAxis;
        [lowRange release];
        [highRange release];
        [yRange release];
        [yAxis release];
        
        //Show the legend
        qolChart.legend.hidden = NO;
        qolChart.legend.style.font = [UIFont fontWithName:@"Futura" size:17.0f];
        qolChart.legend.symbolWidth = [NSNumber numberWithInt:75];
        qolChart.legend.style.borderColor = [UIColor clearColor];
        qolChart.legend.placement = SChartLegendPlacementOutsidePlotArea;
        qolChart.legend.position = SChartLegendPositionBottomMiddle;
        qolChart.legend.maxSeriesPerLine = 1;
        // Build the labels
        
        
        //[qolChart.legend.labels replaceObjectAtIndex:0 withObject:[NSString stringWithFormat:@"Compassion"]];
        
        //Set the chart title
        
         qolChart.title = @"";
         if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         qolChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
         } else {
         qolChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
         }
         qolChart.titleLabel.textColor = [UIColor whiteColor];
         
        
        // If you have a trial version, you need to enter your licence key here:
        //    chart.licenseKey = @"";
        
        // Add the chart to the view controller
        [self.viewProQOLGraph addSubview:qolChart];
    }
    
    // Make sure we get the latest data
    //NSInteger lastScore = [qolDatasource reReadData];
    //[self vasBurnoutImage:lastScore];
    //[self vasBurnoutScore:lastScore];
    [qolChart reloadData];
    [qolChart redrawChartAndGL:YES];
    
}


#pragma mark Burnout Graph
- (IBAction)burnoutButton_Clicked:(id)sender {
    
    // The Burnout is in the Dashboard View Controller (which is first in our tabcontroller array)
    // ...Sooo, switch there...but also tell it to switch the view to Burnout!
    self.tabBarController.selectedIndex = 0;   // 0 means first
    [(DashboardViewController *)self.tabBarController.selectedViewController changeViewToBurnoutChart];
    
}

#pragma mark - UIAlertViewDelegate Methods

/**
 *  alertView:clickedButtonAtIndex
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // buttonIndex 0 is the Cancel button. buttonIndex 1 is the "Yes" button.
    // No matter which button they clicked, just send them back to the main Tools menu
    self.view = self.viewToolsMenu;
    
}

@end
