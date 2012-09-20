//
//  ViewBCVideoController.m
//  t
//
//  Created by Roger Reeder on 5/6/11.
//  Copyright 2011 T2. All rights reserved.
//

#import "ViewBCVideoController.h"
#import "ProviderResilienceAppDelegate.h"
#import "Reachability.h"
#import "BCMoviePlayerController.h"
#import <QuartzCore/QuartzCore.h>

#import "Analytics.h"

@implementation ViewBCVideoController
@synthesize bcPlayer;
@synthesize video;
@synthesize activityIndicator;
@synthesize lblLoading;
@synthesize videoID;
@synthesize videoDescription;
@synthesize delegate;

BOOL bPlayBackStopped=YES;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    ProviderResilienceAppDelegate *appDelegate = (ProviderResilienceAppDelegate *)[UIApplication sharedApplication].delegate;
    self.bcPlayer = [[BCMoviePlayerController alloc] init];
    [self.bcPlayer setUseApplicationAudioSession:NO];
    self.bcPlayer.view.hidden = YES;
    self.bcPlayer.controlStyle = MPMovieControlStyleDefault;
    [self.bcPlayer.view setFrame:self.view.bounds];
    [self.view addSubview:self.bcPlayer.view];
    self.bcPlayer.fullscreen = NO;
    self.bcPlayer.controlStyle = MPMovieControlStyleDefault;
    
    // Try this early on here (reduce latency?)
    [self.bcPlayer prepareToPlay];
    
    [bcPlayer searchForRenditionsBetweenLowBitRate:[NSNumber numberWithInt:800000] 
                                    andHighBitRate:[NSNumber numberWithInt:2000000]];
    
    if (appDelegate.networkStatus == ReachableViaWiFi) {
        [bcPlayer searchForRenditionsBetweenLowBitRate:[NSNumber numberWithInt:800000] 
                                        andHighBitRate:[NSNumber numberWithInt:2000000]];
        
        [Analytics logEvent:@"USE WI-FI"];
    } else {
        [Analytics logEvent:@"USE 3G"];
        [bcPlayer searchForRenditionsBetweenLowBitRate:[NSNumber numberWithInt:200000] 
                                        andHighBitRate:[NSNumber numberWithInt:500000]];
    }
     
      
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self 
           selector:@selector(playbackStateDidChange:) 
               name:MPMoviePlayerPlaybackStateDidChangeNotification 
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(loadStateDidChange:) 
               name:MPMoviePlayerLoadStateDidChangeNotification
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(willEnterFullscreen:) 
               name:MPMoviePlayerWillEnterFullscreenNotification
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(didExitFullscreen:) 
               name:MPMoviePlayerDidExitFullscreenNotification
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(playbackDidFinish:) 
               name:MPMoviePlayerPlaybackDidFinishNotification
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(sourceTypeAvailable:) 
               name:MPMovieSourceTypeAvailableNotification
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(durationAvailable:) 
               name:MPMovieDurationAvailableNotification
             object:bcPlayer];
    [nc addObserver:self 
           selector:@selector(didEnterFullscreen:) 
               name:MPMoviePlayerDidEnterFullscreenNotification
             object:bcPlayer];

    
    
    // Create a customized display to let the user know exactly what is going on with the video
    [self createWaitingOnDownload];
        
    bPlayBackStopped=NO;
    
}

- (void)dealloc
{
    [super dealloc];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self 
                  name:MPMoviePlayerPlaybackStateDidChangeNotification 
                object:bcPlayer];
    [nc removeObserver:self 
                  name:MPMoviePlayerLoadStateDidChangeNotification 
                object:bcPlayer]; 
    [nc removeObserver:self 
                  name:MPMoviePlayerWillEnterFullscreenNotification
                object:bcPlayer]; 
    [nc removeObserver:self 
                  name:MPMoviePlayerDidExitFullscreenNotification
                object:bcPlayer]; 
    [nc removeObserver:self 
                  name:MPMoviePlayerPlaybackDidFinishNotification
                object:bcPlayer]; 
    [nc removeObserver:self 
                  name:MPMovieSourceTypeAvailableNotification
                object:bcPlayer];
    [nc removeObserver:self 
                  name:MPMovieDurationAvailableNotification
                object:bcPlayer];
    [nc removeObserver:self 
                  name:MPMoviePlayerDidEnterFullscreenNotification
                object:bcPlayer];
    
    //[self.activityIndicator release];
    [self.bcPlayer release];
    self.bcPlayer = nil;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
- (void)viewWillAppear:(BOOL)animated  {
    
    [super viewWillAppear:animated];
}


- (void)viewDidAppear:(BOOL)animated {
    [Analytics logEvent:[NSString stringWithFormat:@"MOVIE: %@", self.videoDescription]];
    ProviderResilienceAppDelegate *appDelegate = (ProviderResilienceAppDelegate *)[UIApplication sharedApplication].delegate;
    NSError *err;
    if (self.videoID) {

        BCVideo *vid = (BCVideo *)[appDelegate.bcServices findVideoById:self.videoID error:&err];
        if (vid) {
            [self.bcPlayer setContentURL:vid];
            [self.bcPlayer prepareToPlay];
            [self.bcPlayer play];
            if (![self.activityIndicator isAnimating]) {
                [self.activityIndicator startAnimating];
            }
        } else {
            NSString *errStr = [appDelegate.bcServices getErrorsAsString:err];
            [Analytics logEvent:[NSString stringWithFormat:@"VIDEO PLAYBACK ERROR: %@",errStr]];
            //NSLog(@"BC Error: %@",errStr);
            //NSLog(@"NSError: %@",err);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                            message:@"A Connection to the Internet is needed and could not be found"
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
            [alert release];
        }
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidDisappear:(BOOL)animated {
    if (self.bcPlayer) {
        [self.bcPlayer stop];
        [self.bcPlayer release];
        self.bcPlayer = nil;
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // 08/09/12 Allow all orientations for the videos
   // BOOL biPhoneOrientation = (interfaceOrientation== UIInterfaceOrientationPortrait);
    //BOOL bOrientation = biPhoneOrientation;
    
    // Customize for iPad (orientation and other)
    /*
     BOOL biPadOrientation = biPhoneOrientation || (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) ||
     (interfaceOrientation==UIInterfaceOrientationLandscapeRight);
     
     //if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) bOrientation = biPadOrientation;
     */
    return YES; //bOrientation;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self fadeOutPlayer];
}
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.bcPlayer.view.frame = self.view.frame;
    [self fadeInPlayer];
}

#pragma mark -
#pragma mark Controller Animation Cycle
- (void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	if (animationID == @"fadeOutPlayer")/* && finished*/ {  
	
    }
	if (animationID == @"fadeInPlayer")/* && finished*/ {

	}
}	

- (void)fadeOutPlayer {		//Animate Fade Out
	[UIView beginAnimations:@"fadeOutPlayer" context:nil];
	[UIView setAnimationDuration:0.25f];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationHasFinished:finished:context:)];
	self.view.alpha = 0.0f;
	[UIView commitAnimations];
}

- (void)fadeInPlayer {		//Animate Fade Out
	[UIView beginAnimations:@"fadeInPlayer" context:nil];
	[UIView setAnimationDuration:0.25f];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationHasFinished:finished:context:)];
	self.view.alpha = 1.0f;
    [UIView commitAnimations];
}


#pragma mark -
#pragma mark Video Utilities
-(void)replay:(id)sender {
    if (self.bcPlayer) {
        [self.bcPlayer play];
    }
}


- (void)updateLayout:(CGRect)frame {
	[self.view setFrame:frame];
	if (self.lblLoading) {
		[self.lblLoading setCenter:CGPointMake(frame.size.width/2.0f, self.lblLoading.center.y)];
	}
	if (self.activityIndicator) {
		[self.activityIndicator setCenter:CGPointMake(frame.size.width/2.0f, frame.size.height/2.0f)];
	}
}

- (void)animateRotation:(UIInterfaceOrientation)interfaceOrientation 
               duration:(NSTimeInterval)duration {
/*    
    if (interfaceOrientation == UIInterfaceOrientationPortrait || 
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGRect portraitRect = CGRectMake(0.0f, 0.0f, 768.0f, 432.0f);
        [[self view] setFrame:portraitRect];
        [[bcPlayer view] setFrame:portraitRect];
        if (![bcPlayer isFullscreen]) {
            [[bcPlayer backgroundView] setFrame:portraitRect];
        //    [[bcPlayer backgroundView] setBackgroundColor:portraitBackground];
        }
        
        [activityIndicator setCenter:CGPointMake(384.0f,160.0f)];
    } else {
        CGRect landscapeRect = CGRectMake(0.0f, 0.0f, 1024.0f, 348.0f);        
        [[self view] setFrame:landscapeRect];        
        [[bcPlayer view] setFrame:CGRectMake(205.0f, 0.0f, 619.0f, 348.0f)];
        if (![bcPlayer isFullscreen]) {
            [[bcPlayer backgroundView] setFrame:CGRectMake(-205.0f, 0.0f, 1024.0f, 348.0f)];
        //    [[bcPlayer backgroundView] setBackgroundColor:landscapeBackground];
        }
        [activityIndicator setCenter:CGPointMake(512.0f,110.0f)];
    }
 */
}


// Create a customized display to let the user know exactly what is going on with the video
// (i.e.; we are waiting until there is enough downloaded to play without further interruption)
// Find the view that is in control....
- (void)createWaitingOnDownload {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIView *view = [[window subviews] objectAtIndex:0];
    
    // Make sure these views don't already exist...
    UILabel *testForView = (UILabel *)[view viewWithTag:20];
    if (testForView == Nil) {
        // Make this look nice by putting it all into a 'parent' label with rounded corners
        UILabel *backgroundView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 310.0f, 85.0f) ];
        backgroundView.frame = CGRectMake(0.0f, 0.0f, 310.0f, 85.0f);
        [backgroundView setCenter:CGPointMake(160.0f, 102.0f)];
        [backgroundView setBackgroundColor:[UIColor lightGrayColor]];
        backgroundView.layer.cornerRadius = 10.0;
        [backgroundView setTag:20];
        [view addSubview:backgroundView];
        [backgroundView release];
        
        
        // Create an activity indicator to show whenever we are waiting for the video
        // Note:  There is one created when we first start the video, but it won't work if we need to wait midway through the video!
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f) ];
        [activityView setCenter:CGPointMake(26.0f, 102.0f)];
        [activityView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
        // iOS 5.0  [activityView setColor:[UIColor blackColor]];
        [activityView setTag:21];           // Tag this view so we can find it later
        
        [view addSubview:activityView];                     // Add it to the view
        [activityView release];
        
        // Let's create a label also (to tell the user what is going on)
        UIFont *labelFont = [UIFont boldSystemFontOfSize:10.0];
        UILabel *labelView = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 260.0f, 75.0f) ];
        [labelView setCenter:CGPointMake(182.0f, 102.0f)];
        
        [labelView setBackgroundColor:[UIColor lightGrayColor]];
        [labelView setTextColor:[UIColor blackColor]];
        [labelView setFont:labelFont];
        [labelView setNumberOfLines:0];
        [labelView setTextAlignment:UITextAlignmentLeft];
        labelView.text = NSLocalizedString(@"The video is paused as more content is downloaded.  Playback will continue when enough content is downloaded to play the entire video uninterrupted.  You may manually restart the video at anytime to play the portions currently available.", @"");
        
        [labelView  setTag:22];                             // Tag this view also for later 
        [view addSubview:labelView];               // And add it to our view as well
        [labelView release];
   
    } 
        
    // Make sure we don't show this yet
    [self showWaitingOnDownload:NO];

}

// Show (or hide) information about why we are waiting for the download
// (and what the user can do)
- (void)showWaitingOnDownload:(BOOL)bShow {
        
    // Retrieve the Activity Indicator view (tag-21), label view (tag-22) and the parent label (tag-20) 
    // ...and activate/deactivate as indicated below
    // Note:  This is dependent on these elements being created in viewDidLoad()   We check just in case that didn't go well
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    UIView *view = [[window subviews] objectAtIndex:0];
    UILabel *backgroundView = (UILabel *)[view viewWithTag:20];
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[view viewWithTag:21];
    UILabel *labelView = (UILabel *)[view viewWithTag:22];
    
    // Note:  'bShow' is YES if we want to show the controls.   
    // But the property is 'hidden' so we need to say 'NO' instead of 'YES'
    if (backgroundView != Nil) {
        [view bringSubviewToFront:backgroundView];
        backgroundView.hidden=!bShow;
    }
    if (activityView != Nil) {
        [view bringSubviewToFront:activityView];
        activityView.hidden=!bShow;
        
        if (bShow)
        {
            [activityView startAnimating];
        } else
        {
            [activityView stopAnimating]; 
        }
    }       
    if (labelView != Nil) {
        [view bringSubviewToFront:labelView];
        labelView.hidden=!bShow;
    }
    
}

#pragma mark - MoviePlayer Notifications

- (void)playbackStateDidChange:(NSNotification *)notification {
    MPMoviePlaybackState playbackState = [self.bcPlayer playbackState];
//    MPMoviePlaybackStateStopped,
//    MPMoviePlaybackStatePlaying,
//    MPMoviePlaybackStatePaused,
//    MPMoviePlaybackStateInterrupted,
//    MPMoviePlaybackStateSeekingForward,
//    MPMoviePlaybackStateSeekingBackward
    NSString *lblText = @"";
   NSString *logText = @"";
    switch (playbackState) {
        case MPMoviePlaybackStateStopped:
            lblText = NSLocalizedString(@"Buffering ...",nil);
            logText = @"MPMoviePlaybackStateStopped";
            bPlayBackStopped = YES;
            break;
        case MPMoviePlaybackStatePlaying:
            lblText = NSLocalizedString(@"Buffering ...",nil);
            logText = @"MPMoviePlaybackStatePlaying";
            break;
        case MPMoviePlaybackStatePaused:
            lblText = NSLocalizedString(@"Buffering",nil);  //@"Paused";
            logText = @"MPMoviePlaybackStatePaused";
            break;
        case MPMoviePlaybackStateInterrupted:
            lblText = NSLocalizedString(@"Interrupted",nil);
            logText = @"MPMoviePlaybackStateInterrupted";
            break;
        case MPMoviePlaybackStateSeekingForward:
            lblText = NSLocalizedString(@"Seeking Forward",nil);
            logText = @"MPMoviePlaybackStateSeekingForward";
            break;
        case MPMoviePlaybackStateSeekingBackward:
            lblText = NSLocalizedString(@"Seeking Backward",nil);
            logText = @"MPMoviePlaybackStateSeekingBackward";
            break;
        default:
            break;
    }
    //NSLog(@"Video playbackstate: %@",logText);
    self.lblLoading.text = [NSString stringWithFormat:@"%@",lblText];
    
    // Pop out of full screen mode...we are done
    if ([self.bcPlayer playbackState] == MPMoviePlaybackStateStopped) {
        if ([self.bcPlayer isFullscreen]) {
            [self.bcPlayer setFullscreen:NO animated:YES];
        }
    }
}

- (void)loadStateDidChange:(NSNotification *)notification {
    NSInteger loadState = [self.bcPlayer loadState];
    NSString *logText = @"";
    if (loadState & MPMovieLoadStateUnknown) {
        logText = @"MPMovieLoadStateUnknown";  
    }
    if (loadState & MPMovieLoadStatePlayable) {
        logText = @"MPMovieLoadStatePlayable";   
    }
    if (loadState & MPMovieLoadStatePlaythroughOK) {
        logText = @"MPMovieLoadStatePlaythroughOK";   
    }
    if (loadState & MPMovieLoadStateStalled) {
        logText = @"MPMovieLoadStateStalled";   
    }
    //NSLog(@"loadStateDidChange: %@",logText);
//    MPMovieLoadStateUnknown        = 0,
//    MPMovieLoadStatePlayable       = 1 << 0,
//    MPMovieLoadStatePlaythroughOK  = 1 << 1, // Playback will be automatically started in this state when shouldAutoplay is YES
    //    MPMovieLoadStateStalled        = 1 << 2, // Playback will be automatically paused in this state, if started
    
   if ([self.bcPlayer loadState] == (MPMovieLoadStatePlaythroughOK | MPMovieLoadStatePlayable) || [self.bcPlayer loadState] ==MPMovieLoadStatePlayable)
     {
        if ([self.activityIndicator isAnimating]) {
            [self.activityIndicator stopAnimating];
        }
        
        // We are restarting our video 
        self.bcPlayer.view.hidden = NO;
        [self.bcPlayer setFullscreen:YES animated:YES];
        
        // Hide the controls that tell us we are waiting
        [self showWaitingOnDownload:NO];
        
        bPlayBackStopped=NO;
    } else
    {
        // Video playback stopped...show that we are waiting for download
        // But only if we are really waiting...if the user Stopped playback, they don't care
        if (bPlayBackStopped==NO)
            [self showWaitingOnDownload:YES];
    }
}

- (void)willEnterFullscreen:(NSNotification *)notification {
    [[self.bcPlayer backgroundView] setBackgroundColor:[UIColor blackColor]];
    
}

- (void)didEnterFullscreen:(NSNotification *)notification {    
}

- (void)playbackDidFinish:(NSNotification *)notification {
   // NSLog(@"playbackDidFinish...why?: %@",[notification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey]);
    
    if (MPMovieFinishReasonPlaybackError == 
                    [[notification.userInfo valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] integerValue]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Playback Error"
                                                        message:@"The video could not be played.  Access to the video might be restricted by your network settings."
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [alert release];   
    }

    
    bPlayBackStopped=YES;
    
    self.bcPlayer.view.hidden = YES;
    [self.bcPlayer.view removeFromSuperview];
    [self showWaitingOnDownload:NO];                // Make sure we aren't shown a progress indicator
    
    //[self.navigationController popViewControllerAnimated:YES];
    if (delegate && [delegate respondsToSelector:@selector(dismissViewBC:)]) 
	{
		[delegate dismissViewBC:self];
	}

}

- (void)didExitFullscreen:(NSNotification *)notification {
    UIDeviceOrientation interfaceOrientation = [[UIDevice currentDevice] orientation];
    if (interfaceOrientation == UIInterfaceOrientationPortrait || 
        interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
    } else {
    }
    bPlayBackStopped=YES;
	self.bcPlayer.view.hidden = YES;
	[self.bcPlayer.view removeFromSuperview];
    [self showWaitingOnDownload:NO];                    // Make sure we aren't show a progress indicator
    
    //[self.navigationController popViewControllerAnimated:YES];
    if (delegate && [delegate respondsToSelector:@selector(dismissViewBC:)]) 
	{
		[delegate dismissViewBC:self];
	}
    
}

- (void)sourceTypeAvailable:(NSNotification *)notification {
    /*
    MPMovieSourceType movieSourceType = [self.bcPlayer movieSourceType];
    NSString *logText = @"";
    switch (movieSourceType) {
        case MPMovieSourceTypeFile:
            logText = @"File";
            break;
        case MPMovieSourceTypeStreaming:
            logText = @"Streaming";
            break;
        case MPMovieSourceTypeUnknown:
        default:
            logText = @"Unknown";
            break;
    }
    NSLog(@"Movie Source Type: %@",logText);
     */
}

- (void)durationAvailable:(NSNotification *)notification {
    //NSTimeInterval duration = [self.bcPlayer duration];
    //NSLog(@"Movie Duration: %0.2f",duration);
    
    //NSTimeInterval currentPlaybackTime = [self.bcPlayer currentPlaybackTime];
    //NSLog(@"Movie Current Playback Time: %0.2f",currentPlaybackTime);
    
    //NSTimeInterval playableDuration = [self.bcPlayer playableDuration];
    //NSLog(@"Movie Playable Duration: %0.2f",playableDuration);
    
    //NSTimeInterval initialPlaybackTime = [self.bcPlayer initialPlaybackTime];
    //NSLog(@"Movie Initial Playback Time: %0.2f",initialPlaybackTime);
}


#pragma mark - UIAlertViewDelegate Methods

/**
 *  alertView:clickedButtonAtIndex
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    // buttonIndex 0 is the Cancel button. buttonIndex 1 is the "Yes" button.
    // No matter which button they clicked, dismiss this view
    if (delegate && [delegate respondsToSelector:@selector(dismissViewBC:)]) 
	{
		[delegate dismissViewBC:self];
	}
    
}




@end
