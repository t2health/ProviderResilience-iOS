//
//  SaveSettings.h
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/18/12.
//  Copyright (c) 2012 T2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIKit/UIKit.h"

// Notification Keys (to identify a particular local notification)
#define kNotifyDailyReminder @"keyDailyReminder"

// This is a plist (the type extension is appended in the code)
#define kFilename       @"Settings"

#define kWelcomeMessage @"keyWelcomeMessage"
#define kDailyReminders @"keyDailyReminders"
#define kAnonymousData  @"keyAnonymousData"
#define kVacationOnOff  @"keyVacationOnOff"
#define kLastResetDateTime  @"keyLastResetDateTime"
#define kDailyScoresResetTime  @"keyDailyScoresResetTime"
#define kDailyReminderTime  @"keyDailyReminderTime"
#define kLastVacationDateTime  @"keyLastVacationDateTime"
#define kLastBurnoutDateTime @"keyLastBurnoutDateTime"
#define kLastProQOLDateTime @"keyLastProQOLDateTime"
#define kBuilderKillerDateTime @"keyBuilderKillerDateTime"
#define kLastProQOLScoreCompasson @"keyLastProQOLScoreCompassion"
#define kLastProQOLScoreBurnout @"keyLastProQOLScoreBurnout"
#define kLastProQOLScoreTrauma @"keyLastProQOLScoreTrauma"
#define kLastProQOLScoreBuilders @"keyLastProQOLScoreBuilders"
#define kLastProQOLScoreBonus @"keyLastProQOLScoreBonus"
#define kLastProQOLScoreKillers @"keyLastProQOLScoreKillers"
#define kLastScoreFunStuff @"keyLastScoreFunStuff"
#define kTextBonus1 @"keyTextBonus1"
#define kTextBonus2 @"keyTextBonus2"
#define kTextBonus3 @"keyTextBonus3"
#define kTextBonus4 @"keyTextBonus4"

// Save App wide settings
@interface SaveSettings : NSObject {
    // Settings
    NSNumber *bWelcomeMessage;
    NSNumber *bDailyReminders;
    NSNumber *bAnonymousData;
    NSNumber *bVacationOnOff;
    NSDate   *dateTimeLastReset;
    NSDate   *dateTimeScoresReset;
    NSDate   *dateTimeDailyReminders;
    NSDate   *dateTimeLastVacation;
    NSDate   *dateTimeLastProQOL;
    NSDate   *dateTimeLastBurnout;
    NSDate   *dateTimeBuilderKiller;
    NSNumber *nScoreCompassion;
    NSNumber *nScoreBurnout;
    NSNumber *nScoreTrauma;
    NSNumber *nScoreBuilders;
    NSNumber *nScoreBonus;
    NSNumber *nScoreKillers;
    NSNumber *nScoreFunStuff;
    NSString *txtBonus1;    
}

@property (copy, nonatomic) NSNumber *bWelcomeMessage;
@property (copy, nonatomic) NSNumber *bDailyReminders;
@property (copy, nonatomic) NSNumber *bAnonymousData;
@property (copy, nonatomic) NSNumber *bVacationOnOff;
@property (nonatomic, copy) NSDate *dateTimeLastReset;
@property (nonatomic, copy) NSDate *dateTimeScoresReset;
@property (nonatomic, copy) NSDate *dateTimeDailyReminders;
@property (nonatomic, copy) NSDate *dateTimeLastVacation;
@property (nonatomic, copy) NSDate *dateTimeLastProQOL;
@property (nonatomic, copy) NSDate *dateTimeLastBurnout;
@property (nonatomic, copy) NSDate *dateTimeBuilderKiller;
@property (copy, nonatomic) NSNumber *nScoreCompassion;
@property (copy, nonatomic) NSNumber *nScoreBurnout;
@property (copy, nonatomic) NSNumber *nScoreTrauma;
@property (copy, nonatomic) NSNumber *nScoreBuilders;
@property (copy, nonatomic) NSNumber *nScoreBonus;
@property (copy, nonatomic) NSNumber *nScoreKillers;
@property (copy, nonatomic) NSNumber *nScoreFunStuff;
@property (copy, nonatomic) NSString *txtBonus1;

- (NSString *)dataFilePath;
- (void)initPlist;
- (void)writeToPlist;
- (BOOL)boolFromNumber: (NSNumber *)numItem;
- (void)boolToNumber: (BOOL)bYesNo: (NSNumber *)numItem;
- (void)uWelcome: (BOOL)bYesNo;
- (void)uDaily: (BOOL)bYesNo;
- (void)uAnonymous: (BOOL)bYesNo;
- (void)uVacation: (BOOL)bYesNo;
- (void)uDateTimeLastReset:(NSDate *)myNewDateTime;
- (void)uDateTimeScoresReset:(NSDate *)myNewDateTime;
- (void)uDateTimeDailyReminders:(NSDate *)myNewDateTime;
- (void)uDateTimeLastVacation:(NSDate *)myNewDateTime;
- (void)uDateTimeLastProQOL:(NSDate *)myNewDateTime;
- (void)uDateTimeLastBurnout:(NSDate *)myNewDateTime;
- (void)uDateTimeBuilderKiller:(NSDate *)myNewDateTime;
- (void)uScoreCompassion:(NSInteger *)myNewScoreCompassion;
- (void)uScoreBurnout:(NSInteger *)myNewScoreBurnout;
- (void)uScoreTrauma:(NSInteger *)myNewScoreTrauma;
- (void)uScoreBuilders:(NSInteger *)myNewScoreBuilders;
- (void)uScoreBonus:(NSInteger *)myNewScoreBonus;
- (void)uScoreKillers:(NSInteger *)myNewScoreKillers;
- (void)uScoreFunStuff:(NSInteger *)myNewScoreFunStuff;
- (void)uTextBonus1:(NSString *)myNewTextBonus1;
@end
