//
//  SaveSettings.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 5/18/12.
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
#import "SaveSettings.h"

@implementation SaveSettings 
@synthesize bWelcomeMessage;
@synthesize bDailyReminders;
@synthesize bAnonymousData;
@synthesize bVacationOnOff;
@synthesize dateTimeLastReset;
@synthesize dateTimeScoresReset;
@synthesize dateTimeDailyReminders;
@synthesize dateTimeLastVacation;
@synthesize dateTimeLastProQOL;
@synthesize dateTimeLastBurnout;
@synthesize dateTimeBuilderKiller;
@synthesize nScoreCompassion;
@synthesize nScoreBurnout;
@synthesize nScoreTrauma;
@synthesize nScoreKillers;
@synthesize nScoreBonus;
@synthesize nScoreBuilders;
@synthesize nScoreFunStuff;
@synthesize txtBonus1;

NSString *fileName;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    fileName = [[[NSString alloc] initWithString:kFilename] autorelease];
    fileName  = [fileName stringByAppendingString:@".plist"];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)initPlist {   
    // First, set default values in case the file does not exist yet
    // If the file doesn't exist yet,  set default values
    bWelcomeMessage = [[NSNumber numberWithBool:NO] retain];
    bDailyReminders = [[NSNumber numberWithBool:NO] retain];
    bAnonymousData = [[NSNumber numberWithBool:NO] retain];
    bVacationOnOff = [[NSNumber numberWithBool:NO] retain];
    
    NSDateFormatter *dateFormat = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormat setDateFormat:@"MM/dd/yyyy hh:mma"];
    
    dateTimeLastReset = [[dateFormat dateFromString:@"07/11/2000 12:00"] retain];
    dateTimeLastProQOL = [[dateFormat dateFromString:@"07/11/2000 12:00"] retain];
    dateTimeLastBurnout = [[dateFormat dateFromString:@"07/11/2000 12:00"] retain];
    dateTimeBuilderKiller = [[dateFormat dateFromString:@"07/11/2000 12:00"] retain];
    dateTimeLastVacation = [[dateFormat dateFromString:@"07/11/1962 12:00"] retain];    // Needs to be at least 50 years ago
    dateTimeDailyReminders = [[dateFormat dateFromString:@"07/11/2012 08:00"] retain];
    dateTimeScoresReset = [[dateFormat dateFromString:@"07/11/2012 02:00"] retain];
    
    nScoreCompassion = [[NSNumber numberWithInteger:0] retain];
    nScoreBurnout = [[NSNumber numberWithInteger:0] retain];
    nScoreTrauma = [[NSNumber numberWithInteger:0] retain];
    nScoreBuilders = [[NSNumber numberWithInteger:0] retain];
    nScoreBonus = [[NSNumber numberWithInteger:0] retain];
    nScoreKillers = [[NSNumber numberWithInteger:0] retain];
    nScoreFunStuff = [[NSNumber numberWithInteger:0] retain];
    
    txtBonus1 = [NSString stringWithFormat:@""];
    
    // Read our data from the plist
    NSString *filePath = [self dataFilePath];
    
    // We first try to find it in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:kFilename ofType:@"plist"];
    }
    
    // Make sure we have a file     
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        // Create a dictionary where we will load the data from the plist
        NSString *errorDesc = nil;
        NSPropertyListFormat format;
        NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:filePath];
        
        // Read it in
        NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization
                                              propertyListFromData:plistXML
                                              mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                              format:&format
                                              errorDescription:&errorDesc];
        
        if (!temp) {
            NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
        }
        
        // Only continue if we read the plist
        if (temp) {
            // OK...let's process what we got
            
            // Grab the values
            bWelcomeMessage = [[temp objectForKey:kWelcomeMessage] retain] ; 
            bDailyReminders = [[temp objectForKey:kDailyReminders] retain]; 
            bAnonymousData = [[temp objectForKey:kAnonymousData] retain];   
            bVacationOnOff = [[temp objectForKey:kVacationOnOff] retain];
            dateTimeLastReset = [[temp objectForKey:kLastResetDateTime] retain];
            dateTimeScoresReset = [[temp objectForKey:kDailyScoresResetTime] retain];
            dateTimeDailyReminders = [[temp objectForKey:kDailyReminderTime] retain];
            dateTimeLastVacation = [[temp objectForKey:kLastVacationDateTime] retain];
            dateTimeLastProQOL = [[temp objectForKey:kLastProQOLDateTime] retain];
            dateTimeLastBurnout = [[temp objectForKey:kLastBurnoutDateTime] retain];
            dateTimeBuilderKiller = [[temp objectForKey:kBuilderKillerDateTime] retain];
            nScoreCompassion = [[temp objectForKey:kLastProQOLScoreCompasson] retain];
            nScoreBurnout = [[temp objectForKey:kLastProQOLScoreBurnout] retain];
            nScoreTrauma = [[temp objectForKey:kLastProQOLScoreTrauma] retain];
            nScoreBuilders = [[temp objectForKey:kLastProQOLScoreBuilders] retain];
            nScoreBonus = [[temp objectForKey:kLastProQOLScoreBonus] retain];
            nScoreKillers = [[temp objectForKey:kLastProQOLScoreKillers] retain];
            nScoreFunStuff = [[temp objectForKey:kLastScoreFunStuff] retain];
            txtBonus1 = [[temp objectForKey:kTextBonus1] retain];
                                   
        }
        
    } else{
        
        [self writeToPlist];            // Make sure the file does exist        
    }
}

// Helper method to retreive BOOL from a NSNumber
- (BOOL)boolFromNumber: (NSNumber *)numItem {
    BOOL bValue = NO;
    if ([numItem intValue] != 0)
        bValue = YES;
    
    return bValue;
}

// Helper method to set BOOL into an NSNumber
- (void)boolToNumber: (BOOL)bYesNo: (NSNumber *)numItem {
    
    // We will be changing this
    [numItem release];
    numItem = nil;
    
    // Set the value
    if (bYesNo) 
    {
        numItem = [[NSNumber alloc] initWithInteger:1];
    } else {
        numItem = [[NSNumber alloc] initWithInteger:0];
    }
         
}

- (void)uWelcome: (BOOL)bYesNo{
    [bWelcomeMessage release];
    bWelcomeMessage = nil;
    
    // Set the value
    if (bYesNo) 
    {
        bWelcomeMessage = [[NSNumber alloc] initWithInteger:1];
    } else {
        bWelcomeMessage = [[NSNumber alloc] initWithInteger:0];
    }
}
- (void)uDaily: (BOOL)bYesNo{
    [bDailyReminders release];
    bDailyReminders = nil;
    
    // Set the value
    if (bYesNo) 
    {
        bDailyReminders = [[NSNumber alloc] initWithInteger:1];
    } else {
        bDailyReminders = [[NSNumber alloc] initWithInteger:0];
    }
    
}
- (void)uAnonymous: (BOOL)bYesNo{
    [bAnonymousData release];
    bAnonymousData = nil;
    
    // Set the value
    if (bYesNo) 
    {
        bAnonymousData = [[NSNumber alloc] initWithInteger:1];
    } else {
        bAnonymousData = [[NSNumber alloc] initWithInteger:0];
    }
    
}


- (void)uScoreCompassion:(NSInteger *)myNewScoreCompassion {
    
    [nScoreCompassion release];
    nScoreCompassion = nil;
    
    // Set the value
    nScoreCompassion = [[NSNumber alloc] initWithInteger:*myNewScoreCompassion];    
}

- (void)uScoreBurnout:(NSInteger *)myNewScoreBurnout {
    
    [nScoreBurnout release];
    nScoreBurnout = nil;
    
    // Set the value
    nScoreBurnout = [[NSNumber alloc] initWithInteger:*myNewScoreBurnout];    
}

- (void)uScoreTrauma:(NSInteger *)myNewScoreTrauma {
    
    [nScoreTrauma release];
    nScoreTrauma = nil;
    
    // Set the value
    nScoreTrauma = [[NSNumber alloc] initWithInteger:*myNewScoreTrauma];
}

- (void)uScoreBuilders:(NSInteger *)myNewScoreBuilders {
    
    [nScoreBuilders release];
    nScoreBuilders = nil;
    
    // Set the value
    nScoreBuilders = [[NSNumber alloc] initWithInteger:*myNewScoreBuilders];
}

- (void)uScoreBonus:(NSInteger *)myNewScoreBonus {
    
    [nScoreBonus release];
    nScoreBonus = nil;
    
    // Set the value
    nScoreBonus = [[NSNumber alloc] initWithInteger:*myNewScoreBonus];
}

- (void)uScoreKillers:(NSInteger *)myNewScoreKillers {
    
    [nScoreKillers release];
    nScoreKillers = nil;
    
    // Set the value
    nScoreKillers = [[NSNumber alloc] initWithInteger:*myNewScoreKillers];
}

- (void)uScoreFunStuff:(NSInteger *)myNewScoreFunStuff {
    
    [nScoreFunStuff release];
    nScoreFunStuff = nil;
    
    // Set the value
    nScoreFunStuff = [[NSNumber alloc] initWithInteger:*myNewScoreFunStuff];
}


- (void)uTextBonus1:(NSString *)myNewTextBonus1 {
    if (myNewTextBonus1 != nil) {
        [txtBonus1 release];
        txtBonus1 = nil;
        
        txtBonus1 = [[NSString alloc] initWithString:myNewTextBonus1];
    }
}

- (void)uVacation:(BOOL)bYesNo{
    [bVacationOnOff release];
    bVacationOnOff = nil;
    
    // Set the value
    if (bYesNo) 
    {
        bVacationOnOff = [[NSNumber alloc] initWithInteger:1];
    } else {
        bVacationOnOff = [[NSNumber alloc] initWithInteger:0];
    }
    
}


- (void)uDateTimeLastReset:(NSDate *)myNewDateTime {
    [dateTimeLastReset release];
    dateTimeLastReset = nil;
    
    dateTimeLastReset = [myNewDateTime retain];
}

- (void)uDateTimeScoresReset:(NSDate *)myNewDateTime {
    [dateTimeScoresReset release];
    dateTimeScoresReset = nil;
    
    dateTimeScoresReset = [myNewDateTime retain];
}

- (void)uDateTimeDailyReminders:(NSDate *)myNewDateTime {
    [dateTimeDailyReminders release];
    dateTimeDailyReminders = nil;
    
    dateTimeDailyReminders = [myNewDateTime retain];
}


- (void)uDateTimeLastVacation:(NSDate *)myNewDateTime {
    [dateTimeLastVacation release];
    dateTimeLastVacation = nil;
    
    dateTimeLastVacation = [myNewDateTime retain];
}

- (void)uDateTimeLastProQOL:(NSDate *)myNewDateTime {
    [dateTimeLastProQOL release];
    dateTimeLastProQOL = nil;
    
    dateTimeLastProQOL = [myNewDateTime retain];
}

- (void)uDateTimeLastBurnout:(NSDate *)myNewDateTime {
    [dateTimeLastBurnout release];
    dateTimeLastBurnout = nil;
    
    dateTimeLastBurnout = [myNewDateTime retain];
}

- (void)uDateTimeBuilderKiller:(NSDate *)myNewDateTime {
    [dateTimeBuilderKiller release];
    dateTimeBuilderKiller = nil;
    
    dateTimeBuilderKiller = [myNewDateTime retain];
}

/*
[myElement setObject:(id)kCFBooleanTrue forKey:kFrontKey];
else
[myElement setObject:(id)kCFBooleanFalse forKey:kFrontKey];
*/


- (void)writeToPlist {
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    // Set the values for each attribute
    [data setObject:bWelcomeMessage    forKey:kWelcomeMessage];
    [data setObject:bDailyReminders    forKey:kDailyReminders];
    [data setObject:bAnonymousData    forKey:kAnonymousData];
    [data setObject:bVacationOnOff    forKey:kVacationOnOff];
    [data setObject:dateTimeScoresReset forKey:kDailyScoresResetTime];
    [data setObject:dateTimeDailyReminders forKey:kDailyReminderTime];
    [data setObject:dateTimeLastVacation forKey:kLastVacationDateTime];
    [data setObject:dateTimeLastReset forKey:kLastResetDateTime];
    [data setObject:dateTimeLastBurnout forKey:kLastBurnoutDateTime];
    [data setObject:dateTimeLastProQOL forKey:kLastProQOLDateTime];
    [data setObject:dateTimeBuilderKiller forKey:kBuilderKillerDateTime];
    [data setObject:nScoreCompassion forKey:kLastProQOLScoreCompasson];
    [data setObject:nScoreBurnout forKey:kLastProQOLScoreBurnout];
    [data setObject:nScoreTrauma forKey:kLastProQOLScoreTrauma];
    [data setObject:nScoreBuilders forKey:kLastProQOLScoreBuilders];
    [data setObject:nScoreBonus forKey:kLastProQOLScoreBonus];
    [data setObject:nScoreKillers forKey:kLastProQOLScoreKillers];
    [data setObject:nScoreFunStuff forKey:kLastScoreFunStuff];
    if (txtBonus1 != nil) [data setObject:txtBonus1 forKey:kTextBonus1];
    
    
    [data writeToFile:[self dataFilePath] atomically:YES];
    [data release];   
}


- (void)dealloc {;
    [bAnonymousData release];
    [bWelcomeMessage release];
    [bDailyReminders release];
    [bVacationOnOff release];
    [dateTimeDailyReminders release];
    [dateTimeLastVacation release];
    [dateTimeLastBurnout release];
    [dateTimeLastProQOL release];
    [dateTimeBuilderKiller release];
    [nScoreBurnout release];
    [nScoreCompassion release];
    [nScoreTrauma release];
    [nScoreBuilders release];
    [nScoreBonus release];
    [nScoreKillers release];
    [nScoreFunStuff release];
    [txtBonus1 release];
    [super dealloc];
}
@end
