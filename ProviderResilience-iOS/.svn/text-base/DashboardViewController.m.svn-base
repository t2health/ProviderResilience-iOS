//
//  DashboardViewController.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/8/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import "DashboardViewController.h"
#import "PRdatabaseSQL.h"
#import "PRresources.h"
#import "Analytics.h"
#import "QuartzCore/QuartzCore.h"


@interface DashboardViewController ()

@end

@implementation DashboardViewController
@synthesize boImageGauge;
@synthesize boLabelGauge;
@synthesize boLabelScore;

@synthesize resImageGauge;
@synthesize resLabelGauge;
@synthesize resLabelScore;

@synthesize updateClockTimer;

@synthesize mdRateTraumaImage;
@synthesize mdRateTraumaLabel;
@synthesize mdRateBurnoutImage;
@synthesize mdRateBurnoutLabel;
@synthesize mdRateCompassionImage;
@synthesize mdRateCompassionLabel;

@synthesize QOLItemArray;
@synthesize QOLItemEnumerator;
@synthesize currentQOLelement;
@synthesize surveyQOLxxOfxxLabel;
@synthesize surveyQolStatementLabel;
@synthesize continueQOLButton;
@synthesize surveyQOLButton1;
@synthesize surveyQOLButton2;
@synthesize surveyQOLButton3;
@synthesize surveyQOLButton4;
@synthesize surveyQOLButton5;

@synthesize rateBurnoutExplainLabel;
@synthesize rateBurnoutScoreDescLabel;
@synthesize rateTraumaLabel;
@synthesize rateTraumaImage;
@synthesize rateTraumaExplainLabel;
@synthesize rateTraumaScoreDescLabel;

@synthesize qlDaysSinceLabel;
@synthesize rateCompassionLabel;
@synthesize rateCompassionImage;
@synthesize rateCompassionExplainLabel;
@synthesize rateCompassionScoreDescLabel;
@synthesize rateBurnoutLabel;
@synthesize rateBurnoutImage;

@synthesize currentSettings = _currentSettings;
@synthesize buttonToggleRR;
@synthesize img_toggleRR;
@synthesize buttonReturnToAssessment;
@synthesize labelReturnToAssessment;

@synthesize viewMainDashboard;
@synthesize viewUpdateRRClock;
@synthesize viewDigitalClock;
@synthesize viewUpdateQuality;
@synthesize viewSurveyQualityOfLife;
@synthesize viewInstructionsQualityOfLife;
@synthesize viewBurnoutChart;
@synthesize viewBurnoutSurvey;
@synthesize viewAssessments;
@synthesize viewBuilders;
@synthesize viewBuildersBonus;
@synthesize viewKillers;

@synthesize digitLabelYear;
@synthesize digitLabelMonth;
@synthesize digitLabelDay;
@synthesize digitLabelHour;
@synthesize digitLabelMinute;
@synthesize charLabelYear;
@synthesize charLabelMonth;
@synthesize charLabelDay;
@synthesize charLabelHour;
@synthesize charLabelMinute;
@synthesize digitLabelVacation;

@synthesize boScrollView;

@synthesize boSliderHappy;
@synthesize boSliderCaring;
@synthesize boSliderOnedge;
@synthesize boSliderTrapped;
@synthesize boSliderWornout;
@synthesize boSliderValuable;
@synthesize boSliderConnected;
@synthesize boSliderSatisfied;
@synthesize boSliderPreoccupied;
@synthesize boSliderTraumatized;
@synthesize boButtonSubmit;

@synthesize boLabelHappy;
@synthesize boLabelTrapped;
@synthesize boLabelWornout;
@synthesize boLabelValuable;
@synthesize boLabelConnected;
@synthesize boLabelSatisfied;
@synthesize boLabelPreoccupied;
@synthesize boLabelTraumatized;
@synthesize boLabelOnedge;
@synthesize boLabelCaring;

@synthesize boLabelHappyNot, boLabelHappyMuch;
@synthesize boLabelTrappedNot, boLabelTrappedMuch;
@synthesize boLabelSatisfiedNot, boLabelSatisfiedMuch;
@synthesize boLabelPreoccupiedNot, boLabelPreoccupiedMuch;
@synthesize boLabelConnectedNot, boLabelConnectedMuch;
@synthesize boLabelWornoutNot, boLabelWornoutMuch;
@synthesize boLabelCaringNot, boLabelCaringMuch;
@synthesize boLabelOnedgeNot, boLabelOnedgeMuch;
@synthesize boLabelValuableNot, boLabelValuableMuch;
@synthesize boLabelTraumatizedNot, boLabelTraumatizedMuch;

@synthesize lblBonusBuilder;
@synthesize txtBonusBuilder1;

#pragma mark Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Testing...take a look at our database
    //NSLog(@"Open and read our SQL database...");
    //PRdatabaseSQL *mySQL = [PRdatabaseSQL alloc];
    //[mySQL logSQLrecords];
    //[mySQL release];
    
    // Grab the current settings
    self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    // Set up the On/Off buttons 
    [self toggleVacationButton:[self.currentSettings boolFromNumber:[self.currentSettings bVacationOnOff]]];
    
    
    // Get our custom font for the 'Leave' clock
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {  // iPad
        [digitLabelYear setFont:[UIFont fontWithName:@"DS-Digital" size:91.0]];
        [digitLabelMonth setFont:[UIFont fontWithName:@"DS-Digital" size:91.0]];
        [digitLabelDay setFont:[UIFont fontWithName:@"DS-Digital" size:91.0]];
        [digitLabelHour setFont:[UIFont fontWithName:@"DS-Digital" size:91.0]];
        [digitLabelMinute setFont:[UIFont fontWithName:@"DS-Digital" size:91.0]];
        [charLabelYear setFont:[UIFont fontWithName:@"DS-Digital" size:58.0]];
        [charLabelMonth setFont:[UIFont fontWithName:@"DS-Digital" size:58.0]];
        [charLabelDay setFont:[UIFont fontWithName:@"DS-Digital" size:58.0]];
        [charLabelHour setFont:[UIFont fontWithName:@"DS-Digital" size:58.0]];
        [charLabelMinute setFont:[UIFont fontWithName:@"DS-Digital" size:58.0]];
    } else {  // iPhone
        [digitLabelYear setFont:[UIFont fontWithName:@"DS-Digital" size:44.0]];
        [digitLabelMonth setFont:[UIFont fontWithName:@"DS-Digital" size:44.0]];
        [digitLabelDay setFont:[UIFont fontWithName:@"DS-Digital" size:44.0]];
        [digitLabelHour setFont:[UIFont fontWithName:@"DS-Digital" size:44.0]];
        [digitLabelMinute setFont:[UIFont fontWithName:@"DS-Digital" size:44.0]];
        [charLabelYear setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        [charLabelMonth setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        [charLabelDay setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        [charLabelHour setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
        [charLabelMinute setFont:[UIFont fontWithName:@"DS-Digital" size:24.0]];
    }
    
    // Add subviews 
    // Digital Clock
    
    [self attachDigitalClockView:self.view];                    // Main View
    // Set the 'digits' depending on whether we are on vacation or not
    digitLabelVacation.hidden = ![[self.currentSettings bVacationOnOff] boolValue];
    digitLabelYear.hidden = [[self.currentSettings bVacationOnOff] boolValue];
    digitLabelMonth.hidden = [[self.currentSettings bVacationOnOff] boolValue];
    digitLabelDay.hidden = [[self.currentSettings bVacationOnOff] boolValue];
    digitLabelHour.hidden = [[self.currentSettings bVacationOnOff] boolValue];
    digitLabelMinute.hidden = [[self.currentSettings bVacationOnOff] boolValue];
   
    
    // Customize our buttons
    buttonToggleRR.layer.cornerRadius = 8;
    boButtonSubmit.layer.cornerRadius = 8;
    buttonReturnToAssessment.layer.cornerRadius = 8;
    continueQOLButton.layer.cornerRadius = 8;
    surveyQOLButton1.layer.cornerRadius = 8;
    surveyQOLButton2.layer.cornerRadius = 8;
    surveyQOLButton3.layer.cornerRadius = 8;
    surveyQOLButton4.layer.cornerRadius = 8;
    surveyQOLButton5.layer.cornerRadius = 8;
    
    // Set our delegates
    txtBonusBuilder1.delegate = self;
    
    // Housekeeping
    lblBonusBuilder.layer.cornerRadius = 8;
    //labelReturnToAssessment.layer.cornerRadius = 8;
    
    // Customize Burnout Survey
    // Round off the status labels
    // 08/23/2012  It has been determined that the background should not be displayed so this code is commented out
    /*
    boLabelTraumatizedNot.layer.cornerRadius = 8;
    boLabelTraumatizedMuch.layer.cornerRadius = 8;
    boLabelTrappedNot.layer.cornerRadius = 8;
    boLabelTrappedMuch.layer.cornerRadius = 8;
    boLabelSatisfiedNot.layer.cornerRadius = 8;
    boLabelSatisfiedMuch.layer.cornerRadius = 8;
    boLabelPreoccupiedNot.layer.cornerRadius = 8;
    boLabelPreoccupiedMuch.layer.cornerRadius = 8;
    boLabelConnectedNot.layer.cornerRadius = 8;
    boLabelConnectedMuch.layer.cornerRadius = 8;
    boLabelCaringNot.layer.cornerRadius = 8;
    boLabelCaringMuch.layer.cornerRadius = 8;
    boLabelHappyNot.layer.cornerRadius = 8;
    boLabelHappyMuch.layer.cornerRadius = 8;
    boLabelValuableNot.layer.cornerRadius = 8;
    boLabelValuableMuch.layer.cornerRadius = 8;
    boLabelOnedgeNot.layer.cornerRadius = 8;
    boLabelOnedgeMuch.layer.cornerRadius = 8;
    boLabelWornoutNot.layer.cornerRadius = 8;
    boLabelWornoutMuch.layer.cornerRadius = 8;
    
    // Set the default color of the status labels
    boLabelHappyMuch.backgroundColor = [UIColor grayColor];
    boLabelTrappedMuch.backgroundColor = [UIColor grayColor];
    boLabelSatisfiedMuch.backgroundColor = [UIColor grayColor];
    boLabelPreoccupiedMuch.backgroundColor = [UIColor grayColor];
    boLabelConnectedMuch.backgroundColor = [UIColor grayColor];
    boLabelWornoutMuch.backgroundColor = [UIColor grayColor];
    boLabelCaringMuch.backgroundColor = [UIColor grayColor];
    boLabelOnedgeMuch.backgroundColor = [UIColor grayColor];
    boLabelValuableMuch.backgroundColor = [UIColor grayColor];
    boLabelTraumatizedMuch.backgroundColor = [UIColor grayColor];
    boLabelHappyNot.backgroundColor = [UIColor grayColor];
    boLabelTrappedNot.backgroundColor = [UIColor grayColor];
    boLabelSatisfiedNot.backgroundColor = [UIColor grayColor];
    boLabelPreoccupiedNot.backgroundColor = [UIColor grayColor];
    boLabelConnectedNot.backgroundColor = [UIColor grayColor];
    boLabelWornoutNot.backgroundColor = [UIColor grayColor];
    boLabelCaringNot.backgroundColor = [UIColor grayColor];
    boLabelOnedgeNot.backgroundColor = [UIColor grayColor];
    boLabelValuableNot.backgroundColor = [UIColor grayColor];
    boLabelTraumatizedNot.backgroundColor = [UIColor grayColor];
    */
    
    // Position the scrollers, etc
    // Define the position of the first one (and then the incremental offset for all the others)
    // NOTE:  Most of these values are 'center' coordinates...see code below to verify how they are used
    int notX=60, notY=28;
    int muchX=258, muchY=28;
    int titleX=160, titleY=18; // 23;
    int sliderX=160, sliderY=55;
    int nOffset=75; //90; // 105;
    int nSubmitXpos = 275, nSubmitYoffset = 40;;
    
    // Adjust the valuse for the iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        notX=173;
        notY=20;
        muchX=600;
        muchY=20;
        
        titleX=384;
        titleY=20; 
        
        sliderX=384;
        sliderY=60; //75;
        
        nOffset=90; //140;  //180; 
        nSubmitXpos = 600;
        nSubmitYoffset = 108;
    }
    
    self.boLabelHappyNot.center = CGPointMake(notX,notY);
    self.boLabelHappyMuch.center = CGPointMake(muchX, muchY);
    self.boLabelHappy.center = CGPointMake(titleX, titleY);
    self.boSliderHappy.center = CGPointMake(sliderX, sliderY);
    
    self.boLabelTrappedNot.center = CGPointMake(notX,notY+1*nOffset);
    self.boLabelTrappedMuch.center = CGPointMake(muchX, muchY+1*nOffset);
    self.boLabelTrapped.center = CGPointMake(titleX, titleY+1*nOffset);
    self.boSliderTrapped.center = CGPointMake(sliderX, sliderY+1*nOffset);
    
    self.boLabelSatisfiedNot.center = CGPointMake(notX,notY+2*nOffset);
    self.boLabelSatisfiedMuch.center = CGPointMake(muchX, muchY+2*nOffset);
    self.boLabelSatisfied.center = CGPointMake(titleX, titleY+2*nOffset);
    self.boSliderSatisfied.center = CGPointMake(sliderX, sliderY+2*nOffset);
    
    self.boLabelPreoccupiedNot.center = CGPointMake(notX,notY+3*nOffset);
    self.boLabelPreoccupiedMuch.center = CGPointMake(muchX, muchY+3*nOffset);
    self.boLabelPreoccupied.center = CGPointMake(titleX, titleY+3*nOffset);
    self.boSliderPreoccupied.center = CGPointMake(sliderX, sliderY+3*nOffset);
    
    self.boLabelConnectedNot.center = CGPointMake(notX,notY+4*nOffset);
    self.boLabelConnectedMuch.center = CGPointMake(muchX, muchY+4*nOffset);
    self.boLabelConnected.center = CGPointMake(titleX, titleY+4*nOffset);
    self.boSliderConnected.center = CGPointMake(sliderX, sliderY+4*nOffset);
    
    self.boLabelWornoutNot.center = CGPointMake(notX,notY+5*nOffset);
    self.boLabelWornoutMuch.center = CGPointMake(muchX, muchY+5*nOffset);
    self.boLabelWornout.center = CGPointMake(titleX, titleY+5*nOffset);
    self.boSliderWornout.center = CGPointMake(sliderX, sliderY+5*nOffset);
    
    self.boLabelCaringNot.center = CGPointMake(notX,notY+6*nOffset);
    self.boLabelCaringMuch.center = CGPointMake(muchX, muchY+6*nOffset);
    self.boLabelCaring.center = CGPointMake(titleX, titleY+6*nOffset);
    self.boSliderCaring.center = CGPointMake(sliderX, sliderY+6*nOffset);
    
    self.boLabelOnedgeNot.center = CGPointMake(notX,notY+7*nOffset);
    self.boLabelOnedgeMuch.center = CGPointMake(muchX, muchY+7*nOffset);
    self.boLabelOnedge.center = CGPointMake(titleX, titleY+7*nOffset);
    self.boSliderOnedge.center = CGPointMake(sliderX, sliderY+7*nOffset);
    
    self.boLabelValuableNot.center = CGPointMake(notX,notY+8*nOffset);
    self.boLabelValuableMuch.center = CGPointMake(muchX, muchY+8*nOffset);
    self.boLabelValuable.center = CGPointMake(titleX, titleY+8*nOffset);
    self.boSliderValuable.center = CGPointMake(sliderX, sliderY+8*nOffset);
    
    self.boLabelTraumatizedNot.center = CGPointMake(notX,notY+9*nOffset);
    self.boLabelTraumatizedMuch.center = CGPointMake(muchX, muchY+9*nOffset);
    self.boLabelTraumatized.center = CGPointMake(titleX, titleY+9*nOffset);
    self.boSliderTraumatized.center = CGPointMake(sliderX, sliderY+9*nOffset);
    
    self.boButtonSubmit.center = CGPointMake(nSubmitXpos,sliderY+9*nOffset+nSubmitYoffset);         // Place this a little lower than the last slider
    
    // Customize the sliders.
    /* 08/23/2012 Go back to default slider thumb
    [self.boSliderHappy setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderHappy setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderTrapped setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderTrapped setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderSatisfied setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderSatisfied setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderPreoccupied setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderPreoccupied setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderConnected setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderConnected setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderWornout setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderWornout setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderCaring setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderCaring setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderOnedge setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderOnedge setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderValuable setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderValuable setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
    [self.boSliderTraumatized setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateNormal];
    [self.boSliderTraumatized setThumbImage:[UIImage imageNamed:@"ball-green.png"] forState:UIControlStateHighlighted];
     */
    
    // Set the action method to track value changes in each slider
    [boSliderHappy addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderTrapped addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderSatisfied addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderPreoccupied addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderConnected addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderWornout addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderCaring addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderOnedge addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderValuable addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    [boSliderTraumatized addTarget:self action:@selector(boSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    // And get the current Burnout Scores
    BurnoutDetailScores *detailScores = [[BurnoutDetailScores alloc] init];
    [detailScores initPlist];
    // Set each slider value (and call its action method to set default colors in the slider)
    boSliderHappy.value = [detailScores.nScoreHappy integerValue]; [self boSliderAction:(id)boSliderHappy];
    boSliderTrapped.value = [detailScores.nScoreTrapped integerValue]; [self boSliderAction:(id)boSliderTrapped];
    boSliderSatisfied.value = [detailScores.nScoreSatisfied integerValue]; [self boSliderAction:(id)boSliderSatisfied];
    boSliderPreoccupied.value = [detailScores.nScorePreoccupied integerValue]; [self boSliderAction:(id)boSliderPreoccupied];
    boSliderConnected.value = [detailScores.nScoreConnected integerValue]; [self boSliderAction:(id)boSliderConnected];
    boSliderWornout.value = [detailScores.nScoreWornout integerValue]; [self boSliderAction:(id)boSliderWornout];
    boSliderCaring.value = [detailScores.nScoreCaring integerValue]; [self boSliderAction:(id)boSliderCaring];
    boSliderOnedge.value = [detailScores.nScoreOnedge integerValue]; [self boSliderAction:(id)boSliderOnedge];
    boSliderValuable.value = [detailScores.nScoreValuable integerValue]; [self boSliderAction:(id)boSliderValuable];
    boSliderTraumatized.value = [detailScores.nScoreTraumatized integerValue]; [self boSliderAction:(id)boSliderTraumatized];
    
    [detailScores release];
    detailScores = nil;
    
    // And we are not in Assessment Mode now
    bAssessmentMode = NO;
    buttonReturnToAssessment.hidden = YES;
    labelReturnToAssessment.hidden = YES;
    
}


- (void)viewWillAppear:(BOOL)animated  {
    // Not in Assessment mode!
    bAssessmentMode = NO;
    //buttonReturnToAssessment.hidden = YES;
    //labelReturnToAssessment.hidden = YES;
    
    // Specify the view to start with
    self.view = self.viewMainDashboard;
    
    // Display the clock
    [self displayCurrentClock]; 
    
    // Set a timer to update the clock (once a minute will do) // Kill the timer
    if (updateClockTimer != nil) {
        [updateClockTimer invalidate];
        // [updateClockTimer release];
        updateClockTimer = nil;
    }
	updateClockTimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(onClockTimerFire) userInfo:nil repeats:YES];
    
    // Other content on the Main Dashboard view
    [self presentViewStatusQOL];
    [self presentResilienceRating];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)changeViewToBurnoutChart {
    [Analytics logEvent:@"BURNOUT CHART"];
    self.view = self.viewBurnoutChart;
    [burnoutDatasource reReadData];
    [burnoutChart reloadData];
    [burnoutChart redrawChartAndGL:YES];
    

}

- (void)viewDidUnload
{
    // Kill the timer
    if (updateClockTimer != nil) {
        [updateClockTimer invalidate];
       // [updateClockTimer release];
        updateClockTimer = nil;
    }
    
    /*
    [self setDigitLabelYear:nil];
    [self setDigitLabelMonth:nil];
    [self setDigitLabelDay:nil];
    [self setDigitLabelHour:nil];
    [self setDigitLabelMinute:nil];
    [self setCharLabelYear:nil];
    [self setCharLabelMonth:nil];
    [self setCharLabelDay:nil];
    [self setCharLabelHour:nil];
    [self setCharLabelMinute:nil];
    [self setViewMainDashboard:nil];
    [self setViewUpdateRRClock:nil];
    [self setViewDigitalClock:nil];
    [self setViewVacationClock:nil]; 
    [self setButtonToggleRR:nil];
    [self setImg_toggleRR:nil];
    [self setViewUpdateQuality:nil];
    [self setQlDaysSinceLabel:nil];
    [self setRateCompassionLabel:nil];
    [self setRateCompassionImage:nil];
    [self setRateCompassionExplainLabel:nil];
    [self setRateBurnoutLabel:nil];
    [self setRateBurnoutImage:nil];
    [self setRateBurnoutExplainLabel:nil];
    [self setRateTraumaLabel:nil];
    [self setRateTraumaImage:nil];
    [self setRateTraumaExplainLabel:nil];
    [self setViewSurveyQualityOfLife:nil];
    [self setSurveyQOLxxOfxxLabel:nil];
    [self setSurveyQolStatementLabel:nil];
    [self setViewInstructionsQualityOfLife:nil];
    [self setRateCompassionScoreDescLabel:nil];
    [self setRateBurnoutScoreDescLabel:nil];
    [self setRateTraumaScoreDescLabel:nil];
     */
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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


// Turn off Assessment
- (void)NoAssessment {
    bAssessmentMode = NO;
    buttonReturnToAssessment.hidden = YES;
    labelReturnToAssessment.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    //NSLog(@"DashboardViewController Did Receive Memory Warning");
    
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [digitLabelYear release];
    [digitLabelMonth release];
    [digitLabelDay release];
    [digitLabelHour release];
    [digitLabelMinute release];
    [charLabelYear release];
    [charLabelMonth release];
    [charLabelDay release];
    [charLabelHour release];
    [charLabelMinute release];
    [digitLabelVacation release];
    [viewMainDashboard release];
    [viewUpdateRRClock release];
    [viewDigitalClock release];
    [buttonToggleRR release];
    [img_toggleRR release];
    [viewUpdateQuality release];
    [qlDaysSinceLabel release];
    [rateCompassionLabel release];
    [rateCompassionImage release];
    [rateCompassionExplainLabel release];
    [rateBurnoutLabel release];
    [rateBurnoutImage release];
    [rateBurnoutExplainLabel release];
    [rateTraumaLabel release];
    [rateTraumaImage release];
    [rateTraumaExplainLabel release];
    [viewSurveyQualityOfLife release];
    [surveyQOLxxOfxxLabel release];
    [surveyQolStatementLabel release];
    [viewInstructionsQualityOfLife release];
    [currentSettings release];
    [QOLItemArray release];
    [QOLItemEnumerator release];
    [rateCompassionScoreDescLabel release];
    [rateBurnoutScoreDescLabel release];
    [rateTraumaScoreDescLabel release];
    [super dealloc];
}

#pragma mark File methods
- (NSString *)dataFilePath:(NSString *)plistFileName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString * fileName = [[[NSString alloc] initWithString:plistFileName] autorelease];
    fileName  = [fileName stringByAppendingString:@".plist"];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}


#pragma mark View Transition Methods

// Digital Clock
- (void)attachDigitalClockView:(UIView *)viewForClock {
    // Get its current frame and modify it
    CGRect oldFrame = self.viewDigitalClock.frame;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {   // iPad
        CGRect newFrame = CGRectMake(0, 150, oldFrame.size.width, oldFrame.size.height);
        [self.viewDigitalClock setFrame:newFrame];
    } else {   // iPhone
        CGRect newFrame = CGRectMake(0, 87, oldFrame.size.width, oldFrame.size.height);
        [self.viewDigitalClock setFrame:newFrame];
    }
    [viewForClock addSubview:viewDigitalClock];    
       
}


#pragma mark Update Clock

// Hand the timer (to display the clock)
- (void)onClockTimerFire {
    // Determine if we need to reset the Daily scores
    // First, create a 'reset target' datetime using the Reset Time and Today's date
    NSDate *today = [NSDate date];              // Today (right now!)  
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    
    // Get 'today' components
    NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | 
                                       NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:today];
    
    // Now get the Reset Time components for when we want to reset the Scores
    [self.currentSettings initPlist];           // Make sure we have current data
    NSDate *resetTargetTime = [self.currentSettings dateTimeScoresReset];   // Grab the target reset time...which includes the date also
    //  And get the Hour/Minute from this
    NSDateComponents *targetComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | 
                                          NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:resetTargetTime];
    
    // Now build the actual reset target date time
    // Use today's day/month/year and the targets hour/minute
    [targetComponents setDay:[nowComponents day]];
    [targetComponents setMonth:[nowComponents month]];
    [targetComponents setYear:[nowComponents year]];
    
    NSDate *targetDate = [gregorian dateFromComponents:targetComponents];
    //NSLog(@"today: %@",today);
    //NSLog(@"reset target date: %@",resetTargetTime);
    //NSLog(@"actual target date: %@",targetDate);
    
    // Now check if it is time to reset the daily scores
    NSDate *lastResetDate = [self.currentSettings dateTimeLastReset];
    NSComparisonResult lastResetVStargetReset = [lastResetDate compare:targetDate];     // Is our last reset before our current target?
    NSComparisonResult nowVStargetRest = [today compare:targetDate];                    // Is rignt how later than our current target?
    
    if ((lastResetVStargetReset == NSOrderedAscending) && 
        (nowVStargetRest == NSOrderedDescending)) {
        // Reset the daily scores!
        NSInteger newScore = 0;
        [self.currentSettings uScoreFunStuff:&newScore];
        [self.currentSettings uScoreBonus:&newScore];
        [self.currentSettings uScoreBuilders:&newScore];
        [self.currentSettings uScoreKillers:&newScore];
        
        // Finally, make note that we just reset the dates
        [self.currentSettings uDateTimeLastReset:[NSDate date]];
        [self.currentSettings writeToPlist];
        
        // And show the updated scores
        [self presentResilienceRating];
    }
    
    
    [gregorian release];
    
    // Display the clock
    [self displayCurrentClock]; 
    [self presentResilienceRating];
}

// Display the clock
- (void)displayCurrentClock {
    // Set the clock values
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"MM/dd/yy hh:mma"];
    
    // Grab the current settings
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    
    // Set the font color based on how long since the last vacation
    NSTimeInterval myInterval = [[NSDate date] timeIntervalSinceDate:[self.currentSettings dateTimeLastVacation]];
    UIColor *myColor = [UIColor greenColor];     // Default to green
    if (myInterval > 60*60*24*152)              // ~5 months...assuming non leap year of 365 days!
        myColor = [UIColor redColor];
    else if (myInterval > 60*60*24*60)          // ~60 days
    {
        myColor = [UIColor yellowColor];
    } else if (myInterval < 0) {
        myColor = [UIColor magentaColor];
    }
    
    
    // Set up to convert this interval to YY MM DD HH MM 
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:[self.currentSettings dateTimeLastVacation]  toDate:[NSDate date]  options:0];
    
    //NSLog(@"Conversion: %dyears %dmonths %ddays %dhours %dmins",[conversionInfo year], [conversionInfo month], [conversionInfo day], [conversionInfo hour], [conversionInfo minute]);
    
    // Only display the clock if it is less than 50 years!
    if (myInterval < 60*60*24*365*50) {
        
        digitLabelYear.textColor = myColor;
        digitLabelYear.text = [NSString stringWithFormat:@"%.2d",[conversionInfo year]];
        digitLabelMonth.textColor = myColor;
        digitLabelMonth.text = [NSString stringWithFormat:@"%.2d",[conversionInfo month]];
        digitLabelDay.textColor = myColor;
        digitLabelDay.text = [NSString stringWithFormat:@"%.2d",[conversionInfo day]];
        digitLabelHour.textColor = myColor;
        digitLabelHour.text = [NSString stringWithFormat:@"%.2d",[conversionInfo hour]];
        digitLabelMinute.textColor = myColor;
        digitLabelMinute.text = [NSString stringWithFormat:@"%.2d",[conversionInfo minute]];
    } else {
        
        digitLabelYear.text = [NSString stringWithFormat:@"??"];
        digitLabelMonth.text = [NSString stringWithFormat:@"??"];
        digitLabelDay.text = [NSString stringWithFormat:@"??"];
        digitLabelHour.text = [NSString stringWithFormat:@"??"];
        digitLabelMinute.text = [NSString stringWithFormat:@"??"];
    }

    
    /*
     // This code displays the date...we are removing it to display the interval instead
    NSString *myStrDate = [dateFormat stringFromDate:[self.currentSettings dateTimeLastVacation]];
    
    digitLabelYear.text = [myStrDate substringWithRange:NSMakeRange(6, 2)];
    digitLabelMonth.text = [myStrDate substringWithRange:NSMakeRange(0, 2)];
    digitLabelDay.text = [myStrDate substringWithRange:NSMakeRange(3, 2)];
    digitLabelHour.text = [myStrDate substringWithRange:NSMakeRange(9, 2)];
    digitLabelMinute.text = [myStrDate substringWithRange:NSMakeRange(12, 2)];
     */
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
    myColor = nil;
}

#pragma mark    Actions: Main Dashboard View
// Take us to the View to Change the Clock
- (IBAction)updateClock_Clicked:(id)sender {
    [Analytics logEvent:@"UPDATE R&R CLOCK"];
    [self attachDigitalClockView:self.viewUpdateRRClock];       // Update R&R Clock View
    
    // Set the current value of the On Vacation button 
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    [self toggleVacationButton:[self.currentSettings boolFromNumber:[self.currentSettings bVacationOnOff]]];
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
    self.view = self.viewUpdateRRClock;
}


- (IBAction)updateResilience_Clicked:(id)sender {
    [Analytics logEvent:@"UPDATE RESILIENCE RATING"];
    bAssessmentMode = YES;
    buttonReturnToAssessment.hidden = NO;
    labelReturnToAssessment.hidden = NO;
    self.view = self.viewAssessments;
}

- (IBAction)updateQuality_Clicked:(id)sender {
    [Analytics logEvent:@"UPDATE QOL RATING"];
    // Display the current ProQOL status
    [self presentViewStatusQOL];
    [self presentResilienceRating];
    self.view = self.viewUpdateQuality;
}

#pragma mark    Actions: R&R Clock View
// Actually change the Clock value
- (IBAction)changeClock_Clicked:(id)sender {
    // Present dialog to allow user to enter the date of their last vacation
	DateTimePicker *controller = [[DateTimePicker alloc] init];
    [controller resetDatePickerMode:UIDatePickerModeDate];
	controller.delegate = self;
        
    // Grab the current settings
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
        
    // Determine which date to use
    NSDate *defaultDate = [NSDate date];                    // Default to today's date
    
    // But if there is a valid date saved...then use it
    NSTimeInterval myInterval = [[NSDate date] timeIntervalSinceDate:[self.currentSettings dateTimeLastVacation]];
    // Only display this value if it is less than 50 years!
    if (myInterval < 60*60*24*365*50) {
        defaultDate = [self.currentSettings dateTimeLastVacation];
    }
    
	controller.defaultDate = defaultDate;  
	[self presentModalViewController:controller animated:YES];
	[controller release];
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
}

- (IBAction)toggleRR_Clicked:(id)sender {
    // Change the settings of this button
    // Grab the current settings
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    BOOL bCurrent = ![self.currentSettings boolFromNumber:[self.currentSettings bVacationOnOff]]; 
    [self.currentSettings uVacation:bCurrent];
    
    // Save the date of their last vacation (R&R)...which is NOW but only if we are coming OFF of vacation
    if (bCurrent == NO)
        [self.currentSettings uDateTimeLastVacation:[NSDate date]];
    
    [self.currentSettings writeToPlist];     // Save the changes
    
    [self toggleVacationButton:bCurrent];
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
    // Update the clock
    [self displayCurrentClock];
    [self presentResilienceRating];
    
    self.view = self.viewUpdateRRClock;
}

- (void)toggleVacationButton:(BOOL)bOnOff {
    // Set the button image and title based on the status
    if (bOnOff) {
        img_toggleRR.image = [UIImage imageNamed:@"exercise.png"];
        [buttonToggleRR setTitle:@"On" forState:UIControlStateNormal];
    } else {
        img_toggleRR.image = [UIImage imageNamed:@"bg-on-1pxl.png"]; 
        [buttonToggleRR setTitle:@"Off" forState:UIControlStateNormal]; 
    }
    
    // Set the 'digits' depending on whether we are on vacation or not
    digitLabelVacation.hidden = !bOnOff;
    digitLabelYear.hidden = bOnOff;
    digitLabelMonth.hidden = bOnOff;
    digitLabelDay.hidden = bOnOff;
    digitLabelHour.hidden = bOnOff;
    digitLabelMinute.hidden = bOnOff;
}

- (IBAction)returnToAssessment_Clicked:(id)sender {
    self.view = self.viewAssessments;
}

#pragma mark Actions: Burnout Slider

- (void)boSliderAction:(id)sender {
    // Figure out which slider this is from the tag
    UISlider *ourSlider = (UISlider *)sender;
    NSInteger myTag = ourSlider.tag;
    
    // Our ranges can be from -100 to 0 or from 0 to 100.   Find out if the abs value is on the high end
    // NOTE: We have changed the range in which the colors change, but we kept the var the same name! (50/50)
    BOOL bGreaterThanMuch = (ourSlider.value>70); 
    BOOL bLessThanMuch = (ourSlider.value<30);      // Or on the low end
    BOOL bGreaterThanNot = (ourSlider.value<-70); 
    BOOL bLessThanNot = (ourSlider.value>-30); 
    
    // Set the color of the slider that is responding
    // 08/23/2012  It has been decided to change the text color (and keep the background as the default-transparent)
    switch (myTag) {
        case 1:
            
            boLabelHappyNot.textColor = [UIColor lightGrayColor];
            boLabelHappyMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanMuch)
                boLabelHappyMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanMuch)
                boLabelHappyNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            
            /* 
             08/23/2012 This code is left as an example if we go back to changing the background!!!
            boLabelHappyNot.backgroundColor = [UIColor grayColor];
            boLabelHappyMuch.backgroundColor = [UIColor grayColor];
            if (bGreaterThanMuch)
                boLabelHappyMuch.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanMuch)
                boLabelHappyNot.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
             */
            break;
            
        case 2:
            boLabelTrappedNot.textColor = [UIColor lightGrayColor];
            boLabelTrappedMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanNot)
                boLabelTrappedNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanNot)
                boLabelTrappedMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            
        case 3:
            boLabelSatisfiedNot.textColor = [UIColor lightGrayColor];
            boLabelSatisfiedMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanMuch)
                boLabelSatisfiedMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanMuch)
                boLabelSatisfiedNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            
        case 4:
            boLabelPreoccupiedNot.textColor = [UIColor lightGrayColor];
            boLabelPreoccupiedMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanNot)
                boLabelPreoccupiedNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanNot)
                boLabelPreoccupiedMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            break;
            
        case 5:
            boLabelConnectedNot.textColor = [UIColor lightGrayColor];
            boLabelConnectedMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanMuch)
                boLabelConnectedMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanMuch)
                boLabelConnectedNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            
        case 6:
            boLabelWornoutNot.textColor = [UIColor lightGrayColor];
            boLabelWornoutMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanNot)
                boLabelWornoutNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanNot)
                boLabelWornoutMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            break;
            
        case 7:
            boLabelCaringNot.textColor = [UIColor lightGrayColor];
            boLabelCaringMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanMuch)
                boLabelCaringMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanMuch)
                boLabelCaringNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            
        case 8:
            boLabelOnedgeNot.textColor = [UIColor lightGrayColor];
            boLabelOnedgeMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanNot)
                boLabelOnedgeNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanNot)
                boLabelOnedgeMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            break;
            
        case 9:
            boLabelValuableNot.textColor = [UIColor lightGrayColor];
            boLabelValuableMuch.textColor = [UIColor lightGrayColor];
            if (bGreaterThanMuch)
                boLabelValuableMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanMuch)
                boLabelValuableNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            
        case 10:
            boLabelTraumatizedMuch.textColor = [UIColor lightGrayColor];
            boLabelTraumatizedNot.textColor = [UIColor lightGrayColor];
            if (bGreaterThanNot)
                boLabelTraumatizedNot.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            else if (bLessThanNot)
                boLabelTraumatizedMuch.textColor = [UIColor colorWithRed:82.0/255.0 green:162.0/255.0 blue:17.0/255.0 alpha:1.0];
            break;
            
        default:
            break;
            
    }
    
    // Now set the label color as appropriate (call a method that is shared with the initial value?)
    //currentInterval = ourSlider.value;    
}

#pragma mark Actions: Burnout Chart View
- (IBAction)updateBurnoutScore:(id)sender {
    // Present Burnout Survey
    // But first make sure the content size is set (for scrolling)
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) 
        [self.boScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1010.0f)];
    else
        [self.boScrollView setContentSize:CGSizeMake(self.view.frame.size.width, 800.0f)];
    
    // And reset the scroll view position for the iPad (it doesn't position correctly for some reason)
    /*
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        CGRect oldFrame = self.boScrollView.frame;
        CGPoint newOrigin = CGPointMake(oldFrame.origin.x,oldFrame.origin.y-50);
        CGRect newFrame = CGRectMake(newOrigin.x, newOrigin.y, oldFrame.size.width, oldFrame.size.height);
        self.boScrollView.frame = newFrame;  
    }
     */
    // Set the color of the scroll bar
    self.boScrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.view = self.viewBurnoutSurvey;
}


- (IBAction)computeBurnoutScore:(id)sender {
    // Compute the new Burnout Score
    // Retrieve each one manually for now (to check on each component)....get more clever later, if needed)
    
    // Save the current scores
    
    BurnoutDetailScores *detailScores = [[BurnoutDetailScores alloc] init];
    [detailScores initPlist];
    
    [detailScores setNScoreHappy:[NSNumber numberWithInteger:boSliderHappy.value]];
    [detailScores setNScoreTrapped:[NSNumber numberWithInteger:boSliderTrapped.value]];
    [detailScores setNScoreSatisfied:[NSNumber numberWithInteger:boSliderSatisfied.value]];
    [detailScores setNScorePreoccupied:[NSNumber numberWithInteger:boSliderPreoccupied.value]];
    [detailScores setNScoreConnected:[NSNumber numberWithInteger:boSliderConnected.value]];
    [detailScores setNScoreWornout:[NSNumber numberWithInteger:boSliderWornout.value]];
    [detailScores setNScoreCaring:[NSNumber numberWithInteger:boSliderCaring.value]];
    [detailScores setNScoreOnedge:[NSNumber numberWithInteger:boSliderOnedge.value]];
    [detailScores setNScoreValuable:[NSNumber numberWithInteger:boSliderValuable.value]];
    [detailScores setNScoreTraumatized:[NSNumber numberWithInteger:boSliderTraumatized.value]];
    
    [detailScores writeToPlist];
    [detailScores release];
    detailScores = nil;
    
    // NOTE:  All scores are 0-100
    // BUT for the negative characteristics, the range is reversed...100-0
    // To make this work with the UISlider, it is calibrated at -100 to 0 (and then the inverse is taken below...'-1*' )
    NSInteger newScore = 0;
    newScore += boSliderHappy.value;
    newScore += -1*boSliderTrapped.value;
    newScore += boSliderSatisfied.value;
    newScore += -1*boSliderPreoccupied.value;
    newScore += boSliderConnected.value;
    newScore += -1*boSliderWornout.value;
    newScore += boSliderCaring.value;
    newScore += -1*boSliderOnedge.value;
    newScore += boSliderValuable.value;
    newScore += -1*boSliderTraumatized.value;
    
    // Average the new score
    newScore = newScore/10;
        
    // Save it!
    [self addBurnoutScore:newScore];
    
    // Plot it and display on the chart
    [self createBurnoutChart];
    self.view = self.viewBurnoutChart;
    [burnoutDatasource reReadData];
    [burnoutChart reloadData];
    [burnoutChart redrawChartAndGL:YES];

    
    [self presentResilienceRating];  // Update the RR score    // Navigate back to the Assessments view
    if (bAssessmentMode)
        self.view = self.viewAssessments;
    else {
        self.view = self.viewMainDashboard;
    }
}

- (void)addBurnoutScore:(NSInteger) score {

    NSMutableArray *rawData;


    NSString *filePath = [self dataFilePath:LineChartSource_Burnout];

    // We first try to find the data in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:LineChartSource_Burnout ofType:@"plist"];
    }


    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        rawData =[[NSMutableArray alloc] initWithContentsOfFile:filePath];
    } else {
        rawData = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    // If the last entry has today's date, then we will replace it.
    if ([rawData count] > 0) {
        // Get the date for this object
        if ([self isThisToday:[rawData objectAtIndex:([rawData count] - 2)]]) {
            [rawData removeObjectAtIndex:[rawData count]-1];   // This ought to get the last 2 objects
            [rawData removeObjectAtIndex:[rawData count]-1];
        }
        
    }

    // Now add the new score
    [rawData addObject:[NSDate date]];                                          // Date 
    [rawData addObject:[[NSNumber alloc] initWithInteger:score]];               // Score
    
    [rawData writeToFile:[self dataFilePath:LineChartSource_Burnout] atomically:YES];
    
    // Reload the data
    [burnoutDatasource reReadData];
    [burnoutChart reloadData];
    [burnoutChart redrawChartAndGL:YES];
 

}

- (void)createBurnoutChart {
    /*if (burnoutChart != nil) {
        [burnoutChart release];
        burnoutChart = nil;
    }*/
    
    //Create the chart (if needed)
    if (burnoutChart == nil) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
            burnoutChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 270, 768,725)];  // iPad
        else
            burnoutChart = [[ShinobiChart alloc] initWithFrame:CGRectMake(0, 165, 320,290)];  // iPhone
        
        // Set a different theme on the chart
        SChartMidnightTheme *midnight = [[SChartMidnightTheme alloc] init];
        [burnoutChart setTheme:midnight];
        [midnight release];
        
        //As the chart is a UIView, set its resizing mask to allow it to automatically resize when screen orientation changes.
        burnoutChart.autoresizingMask = ~UIViewAutoresizingNone;
        
        // Initialise the data source we will use for the chart
        burnoutDatasource = [[LineChartDataSource alloc] initWithFileName:LineChartSource_Burnout seriesCount:1];
        
        // Give the chart the data source
        burnoutChart.datasource = burnoutDatasource;
        [burnoutDatasource release];
        
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
        
        burnoutChart.xAxis = xAxis;
        [xAxis release];
        
        //Create a number axis to use as the y axis.
        NSNumber *lowRange = [[NSNumber alloc] initWithInteger:0];
        NSNumber *highRange = [[NSNumber alloc] initWithInteger:100];
        
        SChartNumberRange *yRange = [[SChartNumberRange alloc] initWithMinimum:lowRange andMaximum:highRange];
        SChartNumberAxis *yAxis = [[SChartNumberAxis alloc] initWithRange:yRange ];
        
        //Enable panning and zooming on Y
        yAxis.enableGesturePanning = NO;
        yAxis.enableGestureZooming = NO;
        yAxis.enableMomentumPanning = NO;
        yAxis.enableMomentumZooming = NO;
        
        //[yAxis setRangeWithMinimum:[NSNumber numberWithDouble: 0.0] andMaximum:[NSNumber numberWithDouble: 100.0] withAnimation:NO];
        
        burnoutChart.yAxis = yAxis;
        [lowRange release];
        [highRange release];
        [yRange release];
        [yAxis release];
        
        //Set the chart title

        burnoutChart.title = @"";
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            burnoutChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:27.0f];
        } else {
            burnoutChart.titleLabel.font = [UIFont fontWithName:@"TrebuchetMS" size:17.0f];
        }
        burnoutChart.titleLabel.textColor = [UIColor whiteColor];
    
        
        // If you have a trial version, you need to enter your licence key here:
        //    chart.licenseKey = @"";
     
        // Add the chart to the view controller
        [self.viewBurnoutChart addSubview:burnoutChart];
    }
    
    // Make sure we get the latest data
    NSInteger lastScore = [burnoutDatasource reReadData];
    [self vasBurnoutImage:lastScore];
    [self vasBurnoutScore:lastScore];
    [burnoutChart reloadData];
    [burnoutChart redrawChartAndGL:YES];
    
    //***** Important for resetting visible portion..if I ever get it towork
    //[burnoutChart.xAxis resetZoomLevel];
    
}

#pragma mark Helper Methods: VAS Burnout Rating
-(void)vasBurnoutScore:(NSInteger)currentScore {
    if (currentScore >= 0)
        self.boLabelScore.text = [NSString stringWithFormat:@"%d",currentScore];
    else
        self.boLabelScore.text = [NSString stringWithFormat:@"??"];
}

-(void)vasBurnoutImage:(NSInteger)currentScore {
    
    UIImage *newImage = nil;
    NSString *scoreLabel = [NSString stringWithFormat:@"?"];
    
    if (currentScore >= kVASHighBurnoutCutoff) {
        scoreLabel = [NSString stringWithFormat:@"HIGH"];
        newImage = [UIImage  imageNamed:@"gaugehoriz_green.png"];   
    }
    else {
        if (currentScore >= kVASMedBurnoutCutoff) {
            scoreLabel = [NSString stringWithFormat:@"MED"];
            newImage = [UIImage  imageNamed:@"gaugehoriz_blue.png"];   
        }
        else
            if (currentScore >= kVASLowBurnoutCutoff) {
                scoreLabel = [NSString stringWithFormat:@"LOW"];
                newImage = [UIImage  imageNamed:@"gaugehoriz_red.png"];   
            }
    }
    
    self.boImageGauge.image = newImage;
    self.boLabelGauge.text = scoreLabel;
}

#pragma mark Actions: Quality of Life View

// Begin the QOL survey
- (IBAction)updateProQOL_Clicked:(id)sender {
    self.view = self.viewInstructionsQualityOfLife;    
}

// Present extended explanation - QOL Compassion Score
- (IBAction)rateCompassionExplain_Clicked:(id)sender {
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    NSInteger myCompassion = [self.currentSettings.nScoreCompassion integerValue];
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
    NSString *myMessage  = [self scoreCompassionDescriptorDetails:myCompassion];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Compassion Satisfaction", @"")
                          message:myMessage
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Close", @"")
                          otherButtonTitles:nil];
    
    //alert.tag = kTagResetApplication;
    [alert show];
    [alert release];
    
    
}

// Present extended explanation - QOL Burnout Score
- (IBAction)rateBurnoutExplain_Clicked:(id)sender {
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    NSInteger myBurnout = [self.currentSettings.nScoreBurnout integerValue];
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
    NSString *myMessage = [self scoreBurnoutDescriptorDetails:myBurnout];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Burnout", @"")
                          message:myMessage
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Close", @"")
                          otherButtonTitles:nil];
    
    //alert.tag = kTagResetApplication;
    [alert show];
    [alert release];
    
    
    
}

// Present extended explanation - QOL Trauma Score
- (IBAction)rateTraumaExplain_Clicked:(id)sender {
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    NSInteger myTrauma = [self.currentSettings.nScoreTrauma integerValue];
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
    NSString *myMessage = self.rateTraumaExplainLabel.text = [self scoreTraumaDescriptorDetails:myTrauma];
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:NSLocalizedString(@"Secondary Traumatic Stress", @"")
                          message:myMessage
                          delegate:self
                          cancelButtonTitle:NSLocalizedString(@"Close", @"")
                          otherButtonTitles:nil];
    
    //alert.tag = kTagResetApplication;
    [alert show];
    [alert release];
}


#pragma mark Actions: Instructions Survey Quality of Life View
- (IBAction)surveyQOLContinue_Clicked:(id)sender {
    // Grab the Database object    
    PRdatabaseSQL *mySQL = [[PRdatabaseSQL alloc] init];
    [mySQL createDbTables];
    
    // Now put the rows into an array
    self.QOLItemArray = [mySQL getProQOLdata];
    self.currentQOLelement = 0;
    
    // Clear out and setup the scorekeeping 
    scoreCompassion = scoreBurnout = scoreTrauma = 0;
    
    
    // Set up & display the initial view
    NSArray *myElement = [self.QOLItemArray objectAtIndex:currentQOLelement];
    
    NSString *newLabel = [NSString stringWithFormat:@"%@ of %d",[myElement objectAtIndex:2], [self.QOLItemArray count]];
    surveyQOLxxOfxxLabel.text = newLabel;
    surveyQolStatementLabel.text = [myElement objectAtIndex:1];
    self.view = self.viewSurveyQualityOfLife;
    
    // Clean up
    [mySQL release];
}

#pragma mark Actions: Survey Quality of Life View
// Process the response to each QOL statement/question
- (IBAction)surveyAnswerButton_Clicked:(id)sender {
    // This is the response to the current statement
    UIButton *myButton = (UIButton *)sender;
    
    // Accumulate the scores
    NSInteger currentScore = myButton.tag;
    // But reverse the score of some of the statements
    switch (self.currentQOLelement+1) {   // <==== note we added one to the index to keep the #'s consistent with what the user sees
        case 1:
        case 4:
        case 15:
        case 17:
        case 29:
            currentScore = 6 - currentScore;
            break;
            
        default:
            break;
    }
    
    // Now add the scores to the proper category
    switch (self.currentQOLelement+1) {  
        // Compassion
        case 3: case 6: case 12: case 16: case 18: case 20: case 22: case 24: case 27: case 30:
            scoreCompassion += currentScore;
            break;
            
        // Burnout    
        case 1: case 4: case 8: case 10: case 15: case 17: case 19: case 21: case 26: case 29:
            scoreBurnout += currentScore;
            break;
            
        case 2: case 5: case 7: case 9: case 11: case 13: case 14: case 23: case 25: case 28:
            scoreTrauma += currentScore;
            break;
    }
    
    // Now move on to the next item    
    if (self.currentQOLelement++ < ([self.QOLItemArray count]-1)) {
        // Set up & display the next item
        
        NSArray *myElement = [self.QOLItemArray objectAtIndex:currentQOLelement];
        
        NSString *newLabel = [NSString stringWithFormat:@"%@ of %d",[myElement objectAtIndex:2], [self.QOLItemArray count]];
        surveyQOLxxOfxxLabel.text = newLabel;
        surveyQolStatementLabel.text = [myElement objectAtIndex:1]; 
    } else {
        // Save the date and this score! (all three parts)  
        //self.currentSettings = [[SaveSettings alloc] init];
        [self.currentSettings initPlist];
        
        [self.currentSettings uDateTimeLastProQOL:[NSDate date]];
        [self.currentSettings uScoreCompassion:&(scoreCompassion)];
        [self.currentSettings uScoreBurnout:&(scoreBurnout)];
        [self.currentSettings uScoreTrauma:&(scoreTrauma)];
        [self.currentSettings writeToPlist];     // Save the changes
        
        
        // Now save this score for graphing
        [self addProQOLScore];
        
        // Now display the status....
        [self presentViewStatusQOL];
        [self presentResilienceRating];
        
        // Now show the next view
        if (bAssessmentMode)  // If we are in assessment mode...go back to that menu
            self.view = self.viewAssessments;
        else
            self.view = self.viewUpdateQuality;
    }
    
}

// Note:  When this is invoked the instance vars have the current score
- (void)addProQOLScore {
    
    NSMutableArray *rawData;
    
    
    NSString *filePath = [self dataFilePath:LineChartSource_ProQOL];
    
    // We first try to find the data in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:LineChartSource_ProQOL ofType:@"plist"];
    }
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        rawData =[[NSMutableArray alloc] initWithContentsOfFile:filePath];
    } else {
        rawData = [[NSMutableArray alloc] initWithCapacity:10];
    }
    
    // If the last entry has today's date, then we will replace it.
    if ([rawData count] > 0) {
        // Get the date for this object
        if ([self isThisToday:[rawData objectAtIndex:([rawData count] - 4)]]) {
            
            // Giving up...this should remove 4 objects...only removing 3!
            //NSInteger lowRange = [rawData count] - 4;       // Being overly cautious here, in case it modifies 'count' on the fly
            //NSInteger highRange = [rawData count] - 1;
            
            //[rawData removeObjectsInRange:NSMakeRange(lowRange, highRange )];
            [rawData removeObjectAtIndex:[rawData count]-1];   // This ought to get the last 4 objects
            [rawData removeObjectAtIndex:[rawData count]-1];
            [rawData removeObjectAtIndex:[rawData count]-1];
            [rawData removeObjectAtIndex:[rawData count]-1];
        }
        
    }
    
    // Add the new score object
    [rawData addObject:[NSDate date]];                                          // Date 
    [rawData addObject:[[NSNumber alloc] initWithInteger:scoreCompassion]];     // Score
    [rawData addObject:[[NSNumber alloc] initWithInteger:scoreBurnout]];
    [rawData addObject:[[NSNumber alloc] initWithInteger:scoreTrauma]];
    
    [rawData writeToFile:[self dataFilePath:LineChartSource_ProQOL] atomically:YES];
}

// Test if the given date is Today (ymd only)
- (BOOL)isThisToday:(NSDate *)testDate {
    BOOL bToday = NO;
    
    NSDate *today = [NSDate date];              // Today (right now!)  
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setLocale:[NSLocale currentLocale]];
    
    // Get 'today' components
    NSDateComponents *nowComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | 
                                       NSDayCalendarUnit fromDate:today];
    NSDate *ymdToday = [gregorian dateFromComponents:nowComponents];
    
    // Now get the test Date components
    NSDateComponents *testComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | 
                                          NSDayCalendarUnit  fromDate:testDate];
    NSDate *ymdTest = [gregorian dateFromComponents:testComponents];
    

    NSComparisonResult dateCompareResult = [ymdToday compare:ymdTest];     
    
    if (dateCompareResult == NSOrderedSame) 
        bToday = YES;
    
    return bToday;
}

#pragma mark Helper Methods - Present Resilience Rating
-(NSInteger)computeResilienceRating{
    // NOTE:  I did not use constants to define the scoring cutoff points, unless they were already defined elsewhere
    // At this time, the other #'s are only used here, so it is easier to see the numbers instead of a 'name'.  
    // If these numbers are used somewhere else in the future, then that developer can make the decision to use #defines
  
    NSInteger newRating = 0;
    
    // Add each component (a 'perfect' score will be 100 points)
    
    // Grab the current scores...we'll need this a couple of times below
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    //***** Leave Clock (20% of total score)
    // How many days has it been since the last Leave   
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"MM/dd/yy hh:mma"];
    
    // Score based on how long it has been since the last vacation
    NSTimeInterval myInterval = [[NSDate date] timeIntervalSinceDate:[self.currentSettings dateTimeLastVacation]];
    if (myInterval > 60*60*24*152)                  // >5 months -- 0 pts
        newRating += 0;         
    else if (myInterval >= 60*60*24*122)            // >4 months -- 5 pts
            newRating += 5;
        else if (myInterval >= 60*60*24*91)         // >3 months -- 10 pts
                newRating += 10;
            else if (myInterval >= 60*60*24*61)     // >2 months -- 15 pts
                        newRating += 15;
                else       
                    newRating += 20;                // <2 months -- 20 pts
    
    //NSLog(@"Rating after Leave Clock: %d",newRating);
    
    //***** Daily Burnout VAS (15% of total score)
    // Use the last Burnout score
    [self createBurnoutChart];              // Make sure we have the burnout data loaded
    NSInteger boScore = [burnoutDatasource reReadData];
    if (boScore >= 85)
        newRating += 15;
    else if (boScore >= 70)
            newRating += 10;
         else if (boScore >= 50)
                newRating += 5;
    
    //NSLog(@"Rating after Burnout VAS: %d",newRating);
    
    //***** Professional QOL scale (45% of total) // 08/16/2012 NOTE:  See NOTE Below
    NSInteger myCompassion, myBurnout, myTrauma;
    myCompassion = [self.currentSettings.nScoreCompassion integerValue];
    myBurnout = [self.currentSettings.nScoreBurnout integerValue];
    myTrauma = [self.currentSettings.nScoreTrauma integerValue];
    
    // Score each of these seperately
    CGFloat fRating = 0.0;
    if (myCompassion >= kQOLHighScoreCutoff)
        fRating += 7;
    else
        if (myCompassion >= kQOLMedScoreCutoff)
            fRating += 3;
        else
            if (myCompassion >= kQOLLowScoreCutoff)
                fRating += 0;
    
    if (myBurnout >= kQOLHighScoreCutoff)
        fRating += 0;
    else
        if (myBurnout >= kQOLMedScoreCutoff)
            fRating += 3;
        else
            if (myBurnout >= kQOLLowScoreCutoff)
                fRating += 7;
    
    if (myTrauma >= kQOLHighScoreCutoff)
        fRating += 0;
    else
        if (myTrauma >= kQOLMedScoreCutoff)
            fRating += 2;
        else
            if (myTrauma >= kQOLLowScoreCutoff)
                fRating += 6;
    
    // 08/16/2012 NOTE: The original ratings had Pro QOL at 20% of total...that has been increased to 45%
    //  Rather than change the original, individual ratings, we will multiply the sum by 2.25 (45%/20%)
    
    // Add to our cumulative rating (with appropriate round-off)
    newRating += (fRating * 2.25);
    //NSLog(@"ProQOL Score: %0.2f",(fRating*2.25));
    //NSLog(@"Rating after ProQOL: %d",newRating);
    
    
    //***** Builders/Bonus/Killers (10% of total)
    NSInteger myBuilders, myKillers, myBonus, myFun;
    NSInteger myBuilderScore = 0;
    myBuilders = [self.currentSettings.nScoreBuilders integerValue];
    // Needs to have happened in the past 24 hours...taken care of by a timer that resets these!
    if (myBuilders > 0) {
        myBuilderScore = 6 + (myBuilders - 1);  // 6 pts for having any Builder, plus 1 more point for each additional one
    }
    newRating += myBuilderScore;       
    //NSLog(@"Rating after Builders: %d",newRating);         
    
    // Bonus will be reset everyday
    myBonus = [self.currentSettings.nScoreBonus integerValue];
    if ((myBonus > 0) && (myBuilderScore < 10))     // 1 more point possible for the Bonus, but only if we don't already have 10 pts
        newRating += myBonus;                       // 1 or 0 points added, depending on whether they selected a Bonus
    //NSLog(@"Rating after Bonus: %d",newRating);
    
    // Killers need to be reset everyday
    myKillers = [self.currentSettings.nScoreKillers integerValue];
    //myInterval = [[NSDate date] timeIntervalSinceDate:[self.currentSettings dateTimeBuilderKiller]];
    if (myKillers > 0)   // Needs to have happened in the past 24 hours
        newRating -= myKillers;
    //NSLog(@"Rating after Killers: %d",newRating);
    
    //***** Fun Stuff (10% of total)
    myFun = [self.currentSettings.nScoreFunStuff integerValue];
    if (myFun > 0)                  // If it is here, it happened in the past 24 hours, count it
        newRating += 10;
    //NSLog(@"Rating after Fun Stuff: %d",newRating);
    
    return newRating;
}

-(void)presentResilienceRating {
    // First, get/compute the current Resilience Rating
    NSInteger currentScore = [self computeResilienceRating];
    
    // Now present it in image and numeric form    
    if (currentScore > 0)
        self.resLabelScore.text = [NSString stringWithFormat:@"%d",currentScore];
    else
        self.resLabelScore.text = [NSString stringWithFormat:@"??"];
  
    UIImage *newImage = nil;
    NSString *scoreLabel = [NSString stringWithFormat:@"?"];
    
    if (currentScore >= kRESHighBurnoutCutoff) {
        scoreLabel = [NSString stringWithFormat:@"HIGH"];
        newImage = [UIImage  imageNamed:@"gaugehoriz_green.png"];   
    }
    else {
        if (currentScore >= kRESMedBurnoutCutoff) {
            scoreLabel = [NSString stringWithFormat:@"MED"];
            newImage = [UIImage  imageNamed:@"gaugehoriz_blue.png"];   
        }
        else
            if (currentScore > kRESLowBurnoutCutoff) {
                scoreLabel = [NSString stringWithFormat:@"LOW"];
                newImage = [UIImage  imageNamed:@"gaugehoriz_red.png"];   
            }
    }
    
    self.resImageGauge.image = newImage;
    self.resLabelGauge.text = scoreLabel;
    
}

#pragma mark Helper Methods - Present QOL Scores
- (void)presentViewStatusQOL{
    // Update all views that contain this information...
    // viewUpdateQuality,  viewMainDashboard  ???
    
    // Always present the last ProQOL scores (if any) 
    // ...so retrieve the last scores 
    
   // self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    NSInteger myCompassion, myBurnout, myTrauma;
    myCompassion = [self.currentSettings.nScoreCompassion integerValue];
    myBurnout = [self.currentSettings.nScoreBurnout integerValue];
    myTrauma = [self.currentSettings.nScoreTrauma integerValue];
    

    // Header area...how long has it been since the user took the ProQOL?
    if (myCompassion == 0)
        self.qlDaysSinceLabel.text = [NSString stringWithFormat:@"You have not yet taken the ProQOL."];
    else {
        // Compute how many days since the user took ProQOL test
        NSTimeInterval myInterval = [[NSDate date] timeIntervalSinceDate:[self.currentSettings dateTimeLastProQOL]];
        myInterval /= 60*60*24;   // Get the interval in days
        int numDays = (int)(myInterval + .5);  // round it to get the number of days
        
        // Now sort out the possibilities so that it reads well
        if (numDays == 0)
            self.qlDaysSinceLabel.text = [NSString stringWithFormat:@"It's been less than a day since your last update."];
        else if (numDays == 1)
                self.qlDaysSinceLabel.text = [NSString stringWithFormat:@"It's been 1 day since your last update."];
        else 
            self.qlDaysSinceLabel.text = [NSString stringWithFormat:@"It's been %d days since your last update.",numDays];
    }
    
    // Score area (ie; 'Med 30' on 2 lines in same label)
    // viewUpdateQuality
    self.rateCompassionLabel.text = [NSString stringWithFormat:@"%@ %d",[self scoreDescriptor:myCompassion], myCompassion];        
    self.rateBurnoutLabel.text = [NSString stringWithFormat:@"%@ %d",[self scoreDescriptor:myBurnout], myBurnout];
    self.rateTraumaLabel.text = [NSString stringWithFormat:@"%@ %d",[self scoreDescriptor:myTrauma], myTrauma];
    // viewMainDashboard
    self.mdRateCompassionLabel.text = [NSString stringWithFormat:@"%@ %d",[self scoreDescriptor:myCompassion], myCompassion];        
    self.mdRateBurnoutLabel.text = [NSString stringWithFormat:@"%@ %d",[self scoreDescriptor:myBurnout], myBurnout];
    self.mdRateTraumaLabel.text = [NSString stringWithFormat:@"%@ %d",[self scoreDescriptor:myTrauma], myTrauma];
    
    // Score Icon Image
    // viewUpdateQuality
    self.rateCompassionImage.image = [self imagePositiveTrait:myCompassion];
    self.rateBurnoutImage.image = [self imageNegativeTrait:myBurnout];
    self.rateTraumaImage.image = [self imageNegativeTrait:myTrauma];
    // viewMainDashboard
    self.mdRateCompassionImage.image = [self imagePositiveTrait:myCompassion];
    self.mdRateBurnoutImage.image = [self imageNegativeTrait:myBurnout];
    self.mdRateTraumaImage.image = [self imageNegativeTrait:myTrauma];
    
    // Text Description area
    // Text Title
    // viewUpdateQuality
    self.rateCompassionScoreDescLabel.text = [self scoreDescriptorTitle:myCompassion];
    self.rateBurnoutScoreDescLabel.text = [self scoreDescriptorTitle:myBurnout];
    self.rateTraumaScoreDescLabel.text = [self scoreDescriptorTitle:myTrauma];
    
    // Text Description (and extended dialog)
    // viewUpdateQuality
    self.rateCompassionExplainLabel.text = [self scoreCompassionDescriptorDetails:myCompassion];
    self.rateBurnoutExplainLabel.text = [self scoreBurnoutDescriptorDetails:myBurnout];
    self.rateTraumaExplainLabel.text = [self scoreTraumaDescriptorDetails:myTrauma];
    
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
}

// Determine the Score Descriptor ...this goes with the Score image icon and the numeric score
- (NSString *)scoreDescriptor:(NSInteger) score {
    NSString *scoreLabel = [NSString stringWithFormat:@"?"];
    
    if (score >= kQOLHighScoreCutoff)
        scoreLabel = [NSString stringWithFormat:@"HIGH"];
    else
    if (score >= kQOLMedScoreCutoff)
        scoreLabel = [NSString stringWithFormat:@"MED"];
    else
        if (score >= kQOLLowScoreCutoff)
            scoreLabel = [NSString stringWithFormat:@"LOW"];
    
    return scoreLabel;
}

// Determine the Score Descriptor Title...this goes with the Text Explanation of the score
- (NSString *)scoreDescriptorTitle:(NSInteger) score {
    NSString *scoreTitle = [NSString stringWithFormat:@""];
    
    if (score >= kQOLHighScoreCutoff)
        scoreTitle = [NSString stringWithFormat:@"High Score"];
    else
        if (score >= kQOLMedScoreCutoff)
            scoreTitle = [NSString stringWithFormat:@"Average Score"];
        else
            if (score >= kQOLLowScoreCutoff)
                scoreTitle = [NSString stringWithFormat:@"Low Score"];
    
    return scoreTitle;
}

// Determine the Score Detailed Description...this is the Text Explanation of the score and it goes in the popup dialog also
- (NSString *)scoreCompassionDescriptorDetails:(NSInteger) score {
    
    NSString *scoreDetail; 
    
    PRresources *prResources = [[PRresources alloc] init];
    
    if (score >= kQOLHighScoreCutoff)
        scoreDetail = [prResources QOLstringForKey:kQOLHighCompassion];
    else
        if (score >= kQOLMedScoreCutoff)
            scoreDetail = [prResources QOLstringForKey:kQOLMedCompassion];
        else
            if (score >= kQOLLowScoreCutoff)
                scoreDetail = [prResources QOLstringForKey:kQOLLowCompassion];
            else
                scoreDetail = [prResources QOLstringForKey:kQOLPreviewCompassion];
    
    [prResources release];
    
    return scoreDetail;
}

- (NSString *)scoreBurnoutDescriptorDetails:(NSInteger) score {
    
    NSString *scoreDetail; 
    
    PRresources *prResources = [[PRresources alloc] init];
    
    if (score >= kQOLHighScoreCutoff)
        scoreDetail = [prResources QOLstringForKey:kQOLHighBurnout];
    else
        if (score >= kQOLMedScoreCutoff)
            scoreDetail = [prResources QOLstringForKey:kQOLMedBurnout];
        else
            if (score >= kQOLLowScoreCutoff)
                scoreDetail = [prResources QOLstringForKey:kQOLLowBurnout];
            else
                scoreDetail = [prResources QOLstringForKey:kQOLPreviewBurnout];
    
    [prResources release];
    
    return scoreDetail;
}

- (NSString *)scoreTraumaDescriptorDetails:(NSInteger) score {
    
    NSString *scoreDetail; 
    
    PRresources *prResources = [[PRresources alloc] init];
    
    if (score >= kQOLHighScoreCutoff)
        scoreDetail = [prResources QOLstringForKey:kQOLHighTrauma];
    else
        if (score >= kQOLMedScoreCutoff)
            scoreDetail = [prResources QOLstringForKey:kQOLMedTrauma];
        else
            if (score >= kQOLLowScoreCutoff)
                scoreDetail = [prResources QOLstringForKey:kQOLLowTrauma];
            else
                scoreDetail = [prResources QOLstringForKey:kQOLPreviewTrauma];
    
    [prResources release];
    
    return scoreDetail;
}

// Select the proper images...
- (UIImage *)imagePositiveTrait:(NSInteger) score {
    UIImage *newImage = [UIImage  imageNamed:@"gaugevert_red.png"];   // Default to Low
    
    
    if (score >= kQOLHighScoreCutoff)
        newImage = [UIImage  imageNamed:@"gaugevert_green.png"];
    else
        if (score >= kQOLMedScoreCutoff)
            newImage = [UIImage  imageNamed:@"gaugevert_blue.png"];
    return newImage;
}

- (UIImage *)imageNegativeTrait:(NSInteger) score {
    UIImage *newImage = [UIImage  imageNamed:@"gaugevert2_green.png"];   // Default to Low...which is good for a negative trait!
    
    
    if (score >= kQOLHighScoreCutoff)
        newImage = [UIImage  imageNamed:@"gaugevert2_red.png"];
    else
        if (score >= kQOLMedScoreCutoff)
            newImage = [UIImage  imageNamed:@"gaugevert2_blue.png"];
    return newImage;
}

#pragma mark Actions: Assessments View
// Note:  Other 'Assessments' methods don't show up here (ProQOL and R&R Clock)...they use methods previously defined elsewhere
- (IBAction)presentBurnout_Clicked:(id)sender {
    
    [self createBurnoutChart];
    self.view = self.viewBurnoutChart;
    [burnoutDatasource reReadData];
    [burnoutChart reloadData];
    [burnoutChart redrawChartAndGL:YES];
    
}


- (IBAction)presentBuildersKillers_Clicked:(id)sender {
    // Populate their Personal Bonus Builders)
    [self.currentSettings initPlist];
    
    txtBonusBuilder1.text = [self.currentSettings txtBonus1];
    
    self.view = self.viewBuilders;
}

#pragma mark Actions: Resilience Builders Killers
- (IBAction)resBuilder_Clicked:(id)sender {
    // Toggle the Selected attribute of these buttons
    // But skip this if this is a bonus button and nothing has been entered!
    BOOL bToggle = YES;
    NSInteger tag = [sender tag];
    if (tag == kBuilderFirstCustomTag) {
        if (((txtBonusBuilder1.text == nil) || (txtBonusBuilder1.text.length < 1)) )
            bToggle = NO;
    }    
    
    if (bToggle) {
        UIButton *myButton = (UIButton *)sender;
        [myButton setSelected:!myButton.selected];    
    }
}



- (IBAction)presentKillers_Clicked:(id)sender {
    // Move on to the Resilience Killers view
    // But first save the scores from the Builders! 
    scoreBuilders = scoreKillers = scoreBonus = 0;
    
    // Look at each button to see what they checked...
    // We'll count on the buttons being tagged...since it is possible the user prompts us to create one on the fly!
    for (int i=kBuilderButtonLowTag; i<kBuilderFirstCustomTag; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        if (button != nil) {
            if (button.selected) {              // If the button is selected...increment our count
                if (i < kBuilderFirstCustomTag) {
                    scoreBuilders += 1;         // Count the # of buttons selected
                }                               
                
            }
        }
    }
    
    // And now score the Bonus Builder
    
    // Look at each button to see what they checked...
    // We'll count on the buttons being tagged...since it is possible the user prompts us to create one on the fly!
    for (int i=kBuilderFirstCustomTag; i<=kBuilderButtonHighTag; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        if (button != nil) {
            if (button.selected) {              // If the button is selected...increment our count
                if (i >= kBuilderFirstCustomTag)
                    scoreBonus += 1;         // 1 point for a Custom Builder ... if we didn't already max out (checked when score is compiled)
            }
        }
    }
    
    self.view = self.viewKillers;
}

- (IBAction)doneBuildersKillers_Clicked:(id)sender {
    // Save the scores from the Killers!
    // Wrap everything up...
    
    // Look at each button to see what they checked...
    // We'll count on the buttons being tagged...since it is possible the user prompts us to create one on the fly!
    for (int i=kKillerButtonLowTag; i<=kKillerButtonHighTag; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i];
        if (button != nil) {
            if (button.selected) {
                scoreKillers += 5;        // These will be subtracted from the total!
                if (scoreKillers >= 10)
                    break;                // They 'get' (lose) 5 points for each (up to 10 points)
            }                                          
        }
    }
        
    // Save these scores    
    // Save the date and this score! (both parts)  
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
    
    [self.currentSettings uDateTimeBuilderKiller:[NSDate date]];
    [self.currentSettings uScoreBuilders:&(scoreBuilders)];
    [self.currentSettings uScoreBonus:&(scoreBonus)];
    [self.currentSettings uScoreKillers:&(scoreKillers)];
    
    [self.currentSettings uTextBonus1:txtBonusBuilder1.text];
    [self.currentSettings writeToPlist];     // Save the changes
        
    // Update the displays
    [self presentResilienceRating];
    
    // Navigate back to the Assessments view
    if (bAssessmentMode)
        self.view = self.viewAssessments;
    else {
        self.view = self.viewMainDashboard;
    }
}



#pragma mark Date Time Delegate
- (void)dateTimePickerOK:(DateTimePicker *)controller didPickDate:(NSDate *)date
{
    // User changed and saved the date...get it 
    // But don't let them pick a date in the future!
    NSDate *newDate = date;
    NSTimeInterval myInterval = [[NSDate date] timeIntervalSinceDate:newDate];
    if (myInterval < 0)
        newDate = [NSDate date];        // Forcethe date to today
    
    
    // Grab the current settings file contents
    //self.currentSettings = [[SaveSettings alloc] init];
    [self.currentSettings initPlist];
        
    [self.currentSettings uDateTimeLastVacation:newDate];
    [self.currentSettings writeToPlist];     // Save the changes
	
    //[self.currentSettings release];
    //self.currentSettings = nil;
    
	[controller dismissModalViewControllerAnimated:YES];
    self.view = self.viewUpdateRRClock;
    
    [self presentResilienceRating];  // Update the Resilience Rating
}

- (void)dateTimePickerCancel:(DateTimePicker *)controller
{
	[controller dismissModalViewControllerAnimated:YES];
    self.view = self.viewUpdateRRClock;
}

#pragma mark UITextField Delegates
/**
 *  textFieldDidBeginEditing
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField:textField up:YES];
}

/**
 *  textFieldDidEndEditing
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField:textField up:NO];
}

// Move the text fields so they are not hidden by the keyboard when edit begins
// Move them back to their original position when editting is complete
- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{
    int animatedDistance;
    //int origin = self.view.frame.origin.y;
    int origin = 70;                 // Place holder....need to figure this out dynamiclly in the code
    int moveUpValue = textField.frame.origin.y+ textField.frame.size.height+origin;
    
    // UGH....There is an iOS bug getting the keyboard height
    // ...textFieldDidBeginEditing which calls us, is called before keyBoardWillShow which gets the keyboardheight
    // So once we go through the cycle, we have the keyboard height, but we can't get it the first time through!
    // I'll come back to this with a timer or something, but for now...here goes a kluge...
    if (keyBoardHeight == 0) keyBoardHeight = 216;
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;  
    CGFloat screenWidth = screenSize.width;
    CGFloat screenHeight = screenSize.height;
    
    UIInterfaceOrientation orientation =
    [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait ||
        orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
        animatedDistance = keyBoardHeight-(screenHeight-moveUpValue-5);
    }
    else
    {
        animatedDistance = keyBoardHeight-(screenWidth-moveUpValue-5);
    }
    
    if(animatedDistance>0)
    {
        const int movementDistance = animatedDistance;
        const float movementDuration = 0.3f; 
        int movement = (up ? -movementDistance : movementDistance);
        [UIView beginAnimations: nil context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);       
        [UIView commitAnimations];
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
@end
