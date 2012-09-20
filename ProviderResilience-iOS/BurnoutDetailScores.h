//
//  BurnoutDetailScores.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 7/25/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

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
