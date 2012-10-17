//
//  DashboardViewController.h
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
#import "SaveSettings.h"
#import "DateTimePicker.h"
#import <ShinobiCharts/ShinobiChart.h>
#import "LineChartDataSource.h"
#import "BurnoutDetailScores.h"

// ProQOL boundary scores
#define kQOLHighScoreCutoff     42
#define kQOLMedScoreCutoff      23
#define kQOLLowScoreCutoff      1

// VAS Burnout boundary scores
#define kVASHighBurnoutCutoff   85
#define kVASMedBurnoutCutoff    65
#define kVASLowBurnoutCutoff    0

// Resilience Rating boundary scores
#define kRESHighBurnoutCutoff   80
#define kRESMedBurnoutCutoff    40
#define kRESLowBurnoutCutoff    0

// Builder/Killer Button Tags
// Tags 21-29 are Builder Buttons
#define kBuilderButtonLowTag   21
#define kBuilderFirstCustomTag 26
#define kBuilderButtonHighTag  26
// Tags 31-35 are Killer Buttons
#define kKillerButtonLowTag     31
#define kKillerButtonHighTag    35


@interface DashboardViewController : UIViewController <DateTimePickerDelegate, SChartDelegate, UITextFieldDelegate> {
    //  Charts/Graphs
    // Burnout
    ShinobiChart    *burnoutChart;
    LineChartDataSource *burnoutDatasource;
    
    
    // Quality Of Life Survey
    NSMutableArray *QOLItemArray;
    NSEnumerator *QOLItemEnumerator;
    NSUInteger currentQOLelement;
    
    // Scorekeeper for ProQOL  (Will change to SQL or other persistent store)
    NSInteger scoreCompassion, scoreBurnout, scoreTrauma;
    
    // Scores for resiliency builders/killers
    NSInteger scoreBuilders, scoreKillers, scoreBonus;
    
    // Timer to update the clock
    NSTimer *updateClockTimer;
    
    // Plist with our settings
    SaveSettings *currentSettings;
    
    // Remember if we are doing an Assessment
    BOOL bAssessmentMode;
    
    CGFloat keyBoardHeight;
    
}

@property (retain, nonatomic) SaveSettings *currentSettings;
@property (retain, nonatomic) NSMutableArray *QOLItemArray;
@property (retain, nonatomic) NSEnumerator *QOLItemEnumerator;
@property NSUInteger currentQOLelement;

@property (nonatomic, retain) NSTimer *updateClockTimer;


// Dashboard Views (and subviews!)
@property (retain, nonatomic) IBOutlet UIView *viewMainDashboard;
@property (retain, nonatomic) IBOutlet UIView *viewUpdateRRClock;
@property (retain, nonatomic) IBOutlet UIView *viewDigitalClock;
@property (retain, nonatomic) IBOutlet UIView *viewUpdateQuality;
@property (retain, nonatomic) IBOutlet UIView *viewSurveyQualityOfLife;
@property (retain, nonatomic) IBOutlet UIView *viewInstructionsQualityOfLife;
@property (retain, nonatomic) IBOutlet UIView *viewAssessments;
@property (retain, nonatomic) IBOutlet UIView *viewBurnoutChart;
@property (retain, nonatomic) IBOutlet UIView *viewBurnoutSurvey;
@property (retain, nonatomic) IBOutlet UIView *viewBuilders;
@property (retain, nonatomic) IBOutlet UIView *viewBuildersBonus;
@property (retain, nonatomic) IBOutlet UIView *viewKillers;

// R&R Clock Elements 
@property (retain, nonatomic) IBOutlet UILabel *digitLabelYear;
@property (retain, nonatomic) IBOutlet UILabel *digitLabelMonth;
@property (retain, nonatomic) IBOutlet UILabel *digitLabelDay;
@property (retain, nonatomic) IBOutlet UILabel *digitLabelHour;
@property (retain, nonatomic) IBOutlet UILabel *digitLabelMinute;
@property (retain, nonatomic) IBOutlet UILabel *charLabelYear;
@property (retain, nonatomic) IBOutlet UILabel *charLabelMonth;
@property (retain, nonatomic) IBOutlet UILabel *charLabelDay;
@property (retain, nonatomic) IBOutlet UILabel *charLabelHour;
@property (retain, nonatomic) IBOutlet UILabel *charLabelMinute;
@property (retain, nonatomic) IBOutlet UILabel *digitLabelVacation;

// Assessments Actions
- (IBAction)presentBurnout_Clicked:(id)sender;
- (IBAction)presentBuildersKillers_Clicked:(id)sender;

// Resilience (res) Elements
@property (retain, nonatomic) IBOutlet UILabel *lblBonusBuilder;
@property (retain, nonatomic) IBOutlet UITextField *txtBonusBuilder1;

// Turn off Assessment mode everytime this view is selected
// Assessment must be proactively selected by the user
- (void)NoAssessment;           

// Resilience (res) Actions
- (IBAction)resBuilder_Clicked:(id)sender;
- (IBAction)presentKillers_Clicked:(id)sender;
- (IBAction)doneBuildersKillers_Clicked:(id)sender;


// Main Dashboard (md) QOL Elements
@property (retain, nonatomic) IBOutlet UILabel *mdRateCompassionLabel;
@property (retain, nonatomic) IBOutlet UIImageView *mdRateCompassionImage;
@property (retain, nonatomic) IBOutlet UILabel *mdRateBurnoutLabel;
@property (retain, nonatomic) IBOutlet UIImageView *mdRateBurnoutImage;
@property (retain, nonatomic) IBOutlet UILabel *mdRateTraumaLabel;
@property (retain, nonatomic) IBOutlet UIImageView *mdRateTraumaImage;

// Main Dashboard (bo) Burnout Elements
@property (retain, nonatomic) IBOutlet UILabel *boLabelScore;
@property (retain, nonatomic) IBOutlet UIImageView *boImageGauge;
@property (retain, nonatomic) IBOutlet UILabel *boLabelGauge;

// Main Dashboard (res) Resiliency Elements
@property (retain, nonatomic) IBOutlet UILabel *resLabelScore;
@property (retain, nonatomic) IBOutlet UIImageView *resImageGauge;
@property (retain, nonatomic) IBOutlet UILabel *resLabelGauge;

// Burnout Survey Elements
@property (retain, nonatomic) IBOutlet UIScrollView *boScrollView;

@property (retain, nonatomic) IBOutlet UISlider *boSliderHappy;
@property (retain, nonatomic) IBOutlet UISlider *boSliderTrapped;
@property (retain, nonatomic) IBOutlet UISlider *boSliderSatisfied;
@property (retain, nonatomic) IBOutlet UISlider *boSliderPreoccupied;
@property (retain, nonatomic) IBOutlet UISlider *boSliderConnected;
@property (retain, nonatomic) IBOutlet UISlider *boSliderWornout;
@property (retain, nonatomic) IBOutlet UISlider *boSliderCaring;
@property (retain, nonatomic) IBOutlet UISlider *boSliderOnedge;
@property (retain, nonatomic) IBOutlet UISlider *boSliderValuable;
@property (retain, nonatomic) IBOutlet UISlider *boSliderTraumatized;

// Action method to track the slider movement
- (void)boSliderAction:(id)sender;

// Burnout item Labels
@property (retain, nonatomic) IBOutlet UILabel *boLabelHappy;
@property (retain, nonatomic) IBOutlet UILabel *boLabelTrapped;
@property (retain, nonatomic) IBOutlet UILabel *boLabelSatisfied;
@property (retain, nonatomic) IBOutlet UILabel *boLabelPreoccupied;
@property (retain, nonatomic) IBOutlet UILabel *boLabelConnected;
@property (retain, nonatomic) IBOutlet UILabel *boLabelWornout;
@property (retain, nonatomic) IBOutlet UILabel *boLabelCaring;
@property (retain, nonatomic) IBOutlet UILabel *boLabelOnedge;
@property (retain, nonatomic) IBOutlet UILabel *boLabelValuable;
@property (retain, nonatomic) IBOutlet UILabel *boLabelTraumatized;

// Labels to describe the status of each one of the above
@property (retain, nonatomic) IBOutlet UILabel *boLabelHappyNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelHappyMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelTrappedNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelTrappedMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelSatisfiedNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelSatisfiedMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelPreoccupiedNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelPreoccupiedMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelConnectedNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelConnectedMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelWornoutNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelWornoutMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelCaringNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelCaringMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelOnedgeNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelOnedgeMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelValuableNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelValuableMuch;
@property (retain, nonatomic) IBOutlet UILabel *boLabelTraumatizedNot;
@property (retain, nonatomic) IBOutlet UILabel *boLabelTraumatizedMuch;

// Burnout (bo) Buttons
@property (retain, nonatomic) IBOutlet UIButton *boButtonSubmit;

// Burnout (bo) Chart Actions
- (IBAction)updateBurnoutScore:(id)sender;
- (IBAction)computeBurnoutScore:(id)sender;

// Main View Actions
- (IBAction)updateClock_Clicked:(id)sender;
- (IBAction)updateResilience_Clicked:(id)sender;
- (IBAction)updateQuality_Clicked:(id)sender;

// Update R&R Clock Elements
@property (retain, nonatomic) IBOutlet UIButton *buttonToggleRR;
@property (retain, nonatomic) IBOutlet UIImageView *img_toggleRR;
@property (retain, nonatomic) IBOutlet UIButton *buttonReturnToAssessment;
@property (retain, nonatomic) IBOutlet UILabel *labelReturnToAssessment;

// Update R&R Clock Actions
- (IBAction)changeClock_Clicked:(id)sender;
- (IBAction)toggleRR_Clicked:(id)sender;
- (IBAction)returnToAssessment_Clicked:(id)sender;

- (void)attachDigitalClockView:(UIView *)viewForClock;

// Update Quality of Life Elements  (Shows Updated Status)
@property (retain, nonatomic) IBOutlet UILabel *qlDaysSinceLabel;

@property (retain, nonatomic) IBOutlet UILabel *rateCompassionLabel;
@property (retain, nonatomic) IBOutlet UIImageView *rateCompassionImage;
@property (retain, nonatomic) IBOutlet UILabel *rateCompassionExplainLabel;
@property (retain, nonatomic) IBOutlet UILabel *rateCompassionScoreDescLabel;

@property (retain, nonatomic) IBOutlet UILabel *rateBurnoutLabel;
@property (retain, nonatomic) IBOutlet UIImageView *rateBurnoutImage;
@property (retain, nonatomic) IBOutlet UILabel *rateBurnoutExplainLabel;
@property (retain, nonatomic) IBOutlet UILabel *rateBurnoutScoreDescLabel;

@property (retain, nonatomic) IBOutlet UILabel *rateTraumaLabel;
@property (retain, nonatomic) IBOutlet UIImageView *rateTraumaImage;
@property (retain, nonatomic) IBOutlet UILabel *rateTraumaExplainLabel;
@property (retain, nonatomic) IBOutlet UILabel *rateTraumaScoreDescLabel;

@property (retain, nonatomic) IBOutlet UIButton *continueQOLButton;
@property (retain, nonatomic) IBOutlet UIButton *surveyQOLButton1;
@property (retain, nonatomic) IBOutlet UIButton *surveyQOLButton2;
@property (retain, nonatomic) IBOutlet UIButton *surveyQOLButton3;
@property (retain, nonatomic) IBOutlet UIButton *surveyQOLButton4;
@property (retain, nonatomic) IBOutlet UIButton *surveyQOLButton5;



// Update Quality of Life Actions   (Shows Updated Status)
- (IBAction)updateProQOL_Clicked:(id)sender;
- (IBAction)rateCompassionExplain_Clicked:(id)sender;
- (IBAction)rateBurnoutExplain_Clicked:(id)sender;
- (IBAction)rateTraumaExplain_Clicked:(id)sender;

// Move from QOL Instructions page to the actual survey page
- (IBAction)surveyQOLContinue_Clicked:(id)sender;


// Survey Quality of Life Elements   (Survey to change Status)
@property (retain, nonatomic) IBOutlet UILabel *surveyQOLxxOfxxLabel;
@property (retain, nonatomic) IBOutlet UILabel *surveyQolStatementLabel;

// Survey Quality of Life Actions   (Survey to change Status)
- (IBAction)surveyAnswerButton_Clicked:(id)sender;

// Change the view we present
- (void)changeViewToBurnoutChart;

// Helper Methods
- (void)toggleVacationButton:(BOOL)bOnOff;
- (NSString *)dataFilePath:(NSString *)plistFileName;
@end
