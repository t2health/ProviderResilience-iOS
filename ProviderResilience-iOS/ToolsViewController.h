//
//  ToolsViewController.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
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
#import <UIKit/UIKit.h>
#import "VirtueCardDeck.h"
#import "SaveSettings.h"
#import <ShinobiCharts/ShinobiChart.h>
#import "LineChartDataSource.h"
#import "ViewBCVideoController.h"

@interface ToolsViewController : UIViewController <SChartDelegate, ViewBCDelegate, 
                            UIWebViewDelegate, NSURLConnectionDelegate, UIAlertViewDelegate> {
    IBOutlet UIImageView *viewStretchCard;
    // Definition of the Stretch Card Deck
    VirtueCardDeck  *stretchCards;
    
    // RSS Feed
    NSMutableArray *_allEntries;
    int nCurrentEntry;
    NSMutableData *receivedData;
    
    //  Charts/Graphs
    ShinobiChart    *qolChart;
    LineChartDataSource *qolDatasource;
    
    // Determine which video menu to return to
    int videoReturn;            // 0->Video Menu, 1->Remind Me..Menu
    
}

// This is the default view (menu items)
@property (retain, nonatomic) IBOutlet UIView *viewToolsMenu;

// These are the buttons that take us to the other (non-default) views
// Videos
@property (retain, nonatomic) IBOutlet UIButton *videoButton;
@property (retain, nonatomic) IBOutlet UIView *viewVideos;
@property (retain, nonatomic) IBOutlet UIScrollView *viewScrollVideos;

// Physical Exercise (Stretching)
@property (retain, nonatomic) IBOutlet UIButton *physicalButton;
@property (retain, nonatomic) IBOutlet UIView *viewExercise;
@property (copy, nonatomic) VirtueCardDeck *stretchCards;

// Remind (videos)
@property (retain, nonatomic) IBOutlet UIButton *remindButton;
@property (retain, nonatomic) IBOutlet UIView *viewRemindVideos;
@property (retain, nonatomic) IBOutlet UIScrollView *viewRemindScrollVideos;

// Laugh (Dilbert RSS)
@property (retain, nonatomic) IBOutlet UIButton *laughButton;
@property (retain, nonatomic) IBOutlet UIView *viewRSSFeed;
@property (retain, nonatomic) IBOutlet UIWebView *webView;
@property (retain) NSMutableArray *allEntries;
@property (retain) NSMutableData *receivedData;
@property (retain, nonatomic) IBOutlet UIButton *prevButton_Dilbert;
@property (retain, nonatomic) IBOutlet UIButton *nextButton_Dilbert;
@property (retain, nonatomic) IBOutlet UILabel *nameDateDiblert;
@property (retain, nonatomic) IBOutlet UIActivityIndicatorView *dilbertActivityIndicator;
- (IBAction)prevDilbert:(id)sender;
- (IBAction)nextDilbert:(id)sender;

// ProQOL Pocket Helper Card
@property (retain, nonatomic) IBOutlet UIButton *proqolButton;
@property (retain, nonatomic) IBOutlet UIView *viewProQOLHelper;

// ProQOL Graph
@property (retain, nonatomic) IBOutlet UIButton *graphButton;
@property (retain, nonatomic) IBOutlet UIView *viewProQOLGraph;

// Burnout Graph
@property (retain, nonatomic) IBOutlet UIButton *burnoutButton;

// ...and the Actions that initiate the above
- (IBAction)videoButton_Clicked:(id)sender;
- (IBAction)physicalButton_Clicked:(id)sender;
- (IBAction)remindButton_Clicked:(id)sender;
- (IBAction)laughButton_Clicked:(id)sender;
- (IBAction)proqolButton_Clicked:(id)sender;
- (IBAction)graphButton_Clicked:(id)sender;
- (IBAction)burnoutButton_Clicked:(id)sender;

// Select a video to play (based on the tag value)
- (IBAction)videoSelection_Clicked:(id)sender;

@end
