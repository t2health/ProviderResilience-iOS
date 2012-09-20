//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software 
// and associated documentation files (the "Software"), to deal in the Software without restriction, 
// including without limitation the rights to use, copy, modify, merge, publish, distribute, 
// sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
// 
// 1.  The permission granted herein does not extend to commercial use of the Software by entities 
// primarily engaged in providing online video and related services; and
// 
// 2.  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING 
// BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND 
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, 
// DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

/**
 @mainpage Brightcove iPad iPhone Kit
 
 The Brightcove iPad iPhone Kit is a Cocoa/Objective-C Library for playing back your Brightcove content
 on iOS 3.1 and greater.
 
 The BCMoviePlayerController class inherits from the Apple MPMoviePlayerController class. This is done to give you more controll over how your video
 player is displayed and exposes the increased functionality that Apple has given developers. We are moving away from the fullscreen only experience that
 didn't give developers the control they need over the playback experience. The BCMoviePlayerController injects things like exstracting the correct url to 
 play back into the MPMoviePlayerController classes flow. The Brightcove specific methods exposed are setContentURL:(BCVideo *) video, searchForRenditionsBetweenLowBitRate:(int) 
 lowBitRate andHighBitRate:(int) highBitRate and initWithContentURL:(BCVideo *) video searchForRenditionWithLowBitRate:(NSNumber *) lowBitRate 
 andHighBitRate:(NSNumber *) highBitRate;. These port over the major parts of the BCPlayer class that deal with video playback. To make sure the Brightcove 
 code interacts with the MPMoviePlayerController correctly you need to follow one of the following flows.
 
 Flow 1
 OS Targets: iOS 3.2 and greater 
 Description: This flow is best used when you are targeting iOS 3.2 currently only on the iPad and iOS 4 currently only on the iPhone (3G, 3GS & 4).
 Linked Library Type: Required
 
 (1) Create the object with the init method and not any other convienence methods.
 @code
 BCMoviePlayerController *player = [[BCMoviePlayerController alloc] init];
 @endcode
 
 (2) If you want to use the searchForRenditionsBetweenLowBitRate:andHighBitRate: method you have to call it before you set the content.
 @code
 [player searchForRenditionsBetweenLowBitRate:[NSNumber numberWithInt:200000] andHighBitRate:[NSNumber numberWithInt:300000]];
 @endcode
 
 (3) Finally you set the content, this can be done before or after you have added the player to a view.    
 @code
 [player setContentURL:myVideo];
 @endcode
 
 @section Sample Code
 @code
 // Don't forget to include this line in your source:
 #import "BCMoviePlayerController.h"
 
 BCMoviePlayerController *player = [[BCMoviePlayerController alloc] init];
 [player setContentURL:self.video]; // video fetched via the media apis, type is BCVideo
 
 CGRect rect = CGRectMake(0.0f, 0.0f, 480.0f, 320.0f);
 UIView *pView = player.view;
 [pView setFrame:rect];
 
 [self.view addSubview:player.view];
 @endcode
 
 Flow 2
 OS Targets: iOS 3.1 and greater 
 Description: This flow allows you to develop code that will run on 3.1 and greater with out using any runtime checking to see what OS version you are running.
 Linked Library Type: Weak
 
 (1) Create the object with the initWithContentURL: searchForRenditionWithLowBitRate: andHighBitRate: method. If you do not want to change the default bit-rates
 that we search for 200000 - 500000 you can pass nil for the last two params.
 @code
 BCMoviePlayerController *player = [[BCMoviePlayerController alloc] initWithContentURL:self.video 
                                                      searchForRenditionWithLowBitRate:[NSNumber numberWithInt:200000] 
                                                                        andHighBitRate:[NSNumber numberWithInt:300000]];
 @endcode
 
 (2) Call the play method to start playback
 @code
 [player play];
 @endcode
 
 */


#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@class BCVideo;

@interface BCMoviePlayerController : MPMoviePlayerController <MPMediaPlayback> {
    BCVideo *bcVideo;
    int renditionLowBitRate;
    int renditionHighBitRate;
    BOOL shouldLog;
    BOOL isThreeDotTwoOrGreater;
    BOOL initialized;
    BOOL sortHTTPStreamingPlaylistForWIFI;
}

- (id)initWithContentURL:(BCVideo *)video searchForRenditionWithLowBitRate:(NSNumber *)lowBitRate andHighBitRate:(NSNumber *)highBitRate;
- (void)setContentURL:(BCVideo *)video;
- (void)searchForRenditionsBetweenLowBitRate:(NSNumber *)lowBitRate andHighBitRate:(NSNumber *)highBitRate;

/**
 When the call for the HTTP Streaming Playlist a.k.a. Variant Playlist goes out the url param
 "connection=wifi" is appended. This sorts the renditions so the playback experience is better from 
 the begining on a WIFI connection. Only works with the BCMediaDeliveryTypeHTTP_IOS media delivery
 type, does nothing with other delivery types.
 */
@property(nonatomic, assign) BOOL sortHTTPStreamingPlaylistForWIFI;

#pragma mark -
#pragma mark Apple MPMediaPlayback Protocal
- (void)prepareToPlay;

// Returns YES if prepared for playback.
@property(nonatomic, readonly) BOOL isPreparedToPlay;

// Plays items from the current queue, resuming paused playback if possible.
- (void)play;

// Pauses playback if playing.
- (void)pause;

// Ends playback. Calling -play again will start from the beginnning of the queue.
- (void)stop;

// The current playback time of the now playing item in seconds.
@property(nonatomic) NSTimeInterval currentPlaybackTime;

// The current playback rate of the now playing item. Default is 1.0 (normal speed).
// Pausing will set the rate to 0.0. Setting the rate to non-zero implies playing.
@property(nonatomic) float currentPlaybackRate;

// The seeking rate will increase the longer scanning is active.
- (void)beginSeekingForward;
- (void)beginSeekingBackward;
- (void)endSeeking;

@end