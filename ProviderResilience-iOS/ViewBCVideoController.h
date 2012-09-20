//
//  ViewVideoController.h
//  BrightcoveTest
//
//  Created by Roger Reeder on 5/6/11.
//  Copyright 2011 T2. All rights reserved.
//
//  Modified:
//  07/16/2012 BGD To use modally (requires a delegate)
//

#import <UIKit/UIKit.h>
#import "BCMoviePlayerController.h"

#import "BCVideo.h"
@class ViewBCVideoController;

@protocol ViewBCDelegate <NSObject>

- (void)dismissViewBC:(ViewBCVideoController *)controller;

@end


@interface ViewBCVideoController : UIViewController <UIAlertViewDelegate>{
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UILabel *lblLoading;
    BCMoviePlayerController *bcPlayer;
    BCVideo *video;
    long long videoID;
    NSString *videoDescription;
    
    // Delegate
    id < ViewBCDelegate > delegate;
}
@property (nonatomic, retain) BCMoviePlayerController *bcPlayer;
@property (nonatomic, retain) BCVideo *video;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic) long long videoID;
@property (nonatomic, retain) NSString *videoDescription;
@property (nonatomic, retain) 	IBOutlet UILabel *lblLoading;
@property (nonatomic, assign) id < ViewBCDelegate > delegate;

- (void)updateLayout:(CGRect)frame;

- (void)replay:(id)sender;
- (void)animateRotation: (UIInterfaceOrientation) interfaceOrientation 
               duration: (NSTimeInterval )duration;

- (void)animationHasFinished:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
- (void)fadeOutPlayer;
- (void)fadeInPlayer;
- (void)showWaitingOnDownload:(BOOL)bShow;
- (void)createWaitingOnDownload;

@end

