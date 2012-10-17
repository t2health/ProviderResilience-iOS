//
//  PRresources.m
//  ProviderResilience-iOS
//
//  Created by Brian Doherty on 6/28/12.
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
#import "PRresources.h"

@implementation PRresources
@synthesize chosenString;
NSString *fileName2;

- (NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    fileName2 = [[[NSString alloc] initWithString:kFilenamePR] autorelease];
    fileName2  = [fileName2 stringByAppendingString:@".plist"];
    return [documentsDirectory stringByAppendingPathComponent:fileName2];
}

- (NSString *)QOLstringForKey:(NSString *)key {  
    // Here's where the return string will go
    NSString *myString;
    
    
    // Read our data from the plist
    NSString *filePath = [self dataFilePath];
    
    // We first try to find it in our App directory (the updated version)
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        // Doesn't exist in our App directory...use the original one in the bundle
        filePath = [[NSBundle mainBundle] pathForResource:kFilenamePR ofType:@"plist"];
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
            myString = [temp objectForKey:key];       
                      
        }
        
    } 
    
    return myString; 
}



@end
