//
//  BurnoutDetailScores.m
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
#import "BurnoutDetailScores.h"

@implementation BurnoutDetailScores
@synthesize nScoreHappy;
@synthesize nScoreCaring;
@synthesize nScoreOnedge;
@synthesize nScoreTrapped;
@synthesize nScoreWornout;
@synthesize nScoreValuable;
@synthesize nScoreConnected;
@synthesize nScoreSatisfied;
@synthesize nScorePreoccupied;
@synthesize nScoreTraumatized;



NSString *fileName;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    fileName = [[[NSString alloc] initWithString:kFilename2] autorelease];
    fileName  = [fileName stringByAppendingString:@".plist"];
    return [documentsDirectory stringByAppendingPathComponent:fileName];
}

- (void)initPlist {   
    
    // Read our data from the plist
    NSString *filePath = [self dataFilePath];
    
    // We first try to find it in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:kFilename2 ofType:@"plist"];
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
            nScoreHappy = [[temp objectForKey:kHappyScore] retain];
            nScoreTrapped = [[temp objectForKey:kTrappedScore] retain];
            nScoreSatisfied = [[temp objectForKey:kSatisfiedScore] retain];
            nScorePreoccupied = [[temp objectForKey:kPreoccupiedScore] retain];
            nScoreConnected = [[temp objectForKey:kConnectedScore] retain];
            nScoreWornout = [[temp objectForKey:kWornoutScore] retain];
            nScoreCaring = [[temp objectForKey:kCaringScore] retain];
            nScoreOnedge = [[temp objectForKey:kOnedgeScore] retain];
            nScoreValuable = [[temp objectForKey:kValuableScore] retain];
            nScoreTraumatized = [[temp objectForKey:kTraumatizedScore] retain];
            
        }
        
    } 
}


- (void)writeToPlist {
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    // Set the values for each attribute
    [data setObject:nScoreHappy forKey:kHappyScore];
    [data setObject:nScoreTrapped forKey:kTrappedScore];
    [data setObject:nScoreSatisfied forKey:kSatisfiedScore];
    [data setObject:nScorePreoccupied forKey:kPreoccupiedScore];
    [data setObject:nScoreConnected forKey:kConnectedScore];
    [data setObject:nScoreWornout forKey:kWornoutScore];
    [data setObject:nScoreCaring forKey:kCaringScore];
    [data setObject:nScoreOnedge forKey:kOnedgeScore];
    [data setObject:nScoreValuable forKey:kValuableScore];
    [data setObject:nScoreTraumatized forKey:kTraumatizedScore];
    
    [data writeToFile:[self dataFilePath] atomically:YES];
    [data release];   
}


- (void)dealloc {;
    [nScoreHappy release];
    [nScoreTrapped release];
    [nScoreSatisfied release];
    [nScorePreoccupied release];
    [nScoreConnected release];
    [nScoreWornout release];
    [nScoreCaring release];
    [nScoreOnedge release];
    [nScoreValuable release];
    [nScoreTraumatized release];
    [super dealloc];
}



@end
