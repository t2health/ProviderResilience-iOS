//
//  BurnoutDetailScores.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 7/25/12.
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
#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"


// This is a plist (the type extension is appended in the code)
#define kFilename2       @"BurnoutDetailScores"

#define kHappyScore         @"keyHappyScore"
#define kTrappedScore       @"keyTrappedScore"
#define kSatisfiedScore     @"keySatisfiedScore"
#define kPreoccupiedScore   @"keyPreoccupiedScore"
#define kConnectedScore     @"keyConnectedScore"
#define kWornoutScore       @"keyWornoutScore"
#define kCaringScore        @"keyCaringScore"
#define kOnedgeScore        @"keyOnedgeScore"
#define kValuableScore      @"keyValuableScore"
#define kTraumatizedScore   @"keyTraumatizedScore"

// Save the Burnout Detail Scores
@interface BurnoutDetailScores : NSObject {
    
    NSNumber *nScoreHappy;
    NSNumber *nScoreTrapped;
    NSNumber *nScoreSatisfied;
    NSNumber *nScorePreoccupied;
    NSNumber *nScoreConnected;
    NSNumber *nScoreWornout;
    NSNumber *nScoreCaring;
    NSNumber *nScoreOnedge;
    NSNumber *nScoreValuable;
    NSNumber *nScoreTraumatized;
}


- (NSString *)dataFilePath;
- (void)initPlist;
- (void)writeToPlist;

@property (copy, nonatomic) NSNumber *nScoreHappy;
@property (copy, nonatomic) NSNumber *nScoreTrapped;
@property (copy, nonatomic) NSNumber *nScoreSatisfied;
@property (copy, nonatomic) NSNumber *nScorePreoccupied;
@property (copy, nonatomic) NSNumber *nScoreConnected;
@property (copy, nonatomic) NSNumber *nScoreWornout;
@property (copy, nonatomic) NSNumber *nScoreCaring;
@property (copy, nonatomic) NSNumber *nScoreOnedge;
@property (copy, nonatomic) NSNumber *nScoreValuable;
@property (copy, nonatomic) NSNumber *nScoreTraumatized;


@end
